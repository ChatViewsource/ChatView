import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:chatview/screens/auth/login_screen.dart';
import 'package:chatview/services/auth_service.dart';
import 'package:chatview/services/chat_service.dart';
import 'package:chatview/services/payment_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => ChatService()),
        ChangeNotifierProvider(create: (_) => PaymentService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatView',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF7289DA),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFF99AAB5),
        ),
        fontFamily: 'Tajawal',
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFF7289DA),
          secondary: const Color(0xFF99AAB5),
        ),
      ),
      home: Consumer<AuthService>(
        builder: (context, auth, child) {
          return auth.isAuthenticated ? const HomeScreen() : const LoginScreen();
        },
      ),
    );
  }
}
