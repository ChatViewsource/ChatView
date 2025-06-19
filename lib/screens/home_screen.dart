import 'package:flutter/material.dart';
import 'package:chatview/widgets/custom_tabbar.dart';
import 'package:chatview/screens/chat/chat_screen.dart';
import 'package:chatview/screens/media/media_screen.dart';
import 'package:chatview/screens/friends/friends_screen.dart';
import 'package:chatview/screens/settings/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const ChatScreen(),
    const MediaScreen(),
    const FriendsScreen(),
    const SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo.png',
          height: 40,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _handleSearch,
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: _handleNotifications,
          ),
        ],
        bottom: CustomTabBar(tabController: _tabController),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _screens,
      ),
      floatingActionButton: _buildFAB(),
    );
  }

  Widget _buildFAB() {
    switch (_currentIndex) {
      case 0:
        return FloatingActionButton(
          backgroundColor: const Color(0xFF7289DA),
          child: const Icon(Icons.chat, color: Colors.white),
          onPressed: _startNewChat,
        );
      case 1:
        return FloatingActionButton(
          backgroundColor: const Color(0xFF7289DA),
          child: const Icon(Icons.add, color: Colors.white),
          onPressed: _uploadMedia,
        );
      case 2:
        return FloatingActionButton(
          backgroundColor: const Color(0xFF7289DA),
          child: const Icon(Icons.person_add, color: Colors.white),
          onPressed: _addFriend,
        );
      default:
        return const SizedBox();
    }
  }

  void _handleSearch() {}
  void _handleNotifications() {}
  void _startNewChat() {}
  void _uploadMedia() {}
  void _addFriend() {}

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
