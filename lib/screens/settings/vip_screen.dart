import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatview/services/payment_service.dart';
import 'package:chatview/widgets/vip_badge.dart';

class VipScreen extends StatelessWidget {
  const VipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final paymentService = Provider.of<PaymentService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('الاشتراك المميز'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const VipBadge(),
            const SizedBox(height: 20),
            _buildPlanCard(
              context: context,
              title: 'اشتراك شهري',
              price: '10 دولار',
              features: [
                'إزالة جميع الإعلانات',
                'سعة تخزين 50GB',
                'أولوية في الدعم الفني',
                'شارات مميزة في الملف الشخصي',
              ],
              onTap: () => paymentService.initiatePayment(amount: 10, isYearly: false),
            ),
            const SizedBox(height: 16),
            _buildPlanCard(
              context: context,
              title: 'اشتراك سنوي',
              price: '100 دولار',
              features: [
                'كل مميزات الاشتراك الشهري',
                'توفير 20%',
                'شهادة عضوية مميزة',
                'دعم فني على مدار الساعة',
              ],
              isPopular: true,
              onTap: () => paymentService.initiatePayment(amount: 100, isYearly: true),
            ),
            const SizedBox(height: 20),
            const Text(
              'طرق الدفع المتاحة:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildPaymentMethod('بطاقة ائتمان', Icons.credit_card),
                const SizedBox(width: 15),
                _buildPaymentMethod('بيتكوين', Icons.currency_bitcoin),
                const SizedBox(width: 15),
                _buildPaymentMethod('ايثيريوم', Icons.currency_exchange),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required BuildContext context,
    required String title,
    required String price,
    required List<String> features,
    bool isPopular = false,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isPopular
            ? const BorderSide(color: Colors.amber, width: 2)
            : BorderSide.none,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isPopular)
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'الأكثر شعبية',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                price,
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              ...features.map((feature) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.check_circle,
                            color: Colors.green, size: 16),
                        const SizedBox(width: 8),
                        Expanded(child: Text(feature)),
                      ],
                    ),
                  )),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethod(String name, IconData icon) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          child: Icon(icon, size: 28),
        ),
        const SizedBox(height: 4),
        Text(name),
      ],
    );
  }
}
