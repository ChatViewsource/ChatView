import 'package:flutter/material.dart';
import 'package:chatview/widgets/custom_tab_bar.dart';
import 'package:chatview/screens/chat_screen.dart';
import 'package:chatview/screens/media_screen.dart';
import 'package:chatview/screens/friends_screen.dart';
import 'package:chatview/screens/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatView'),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: _showSearch),
          IconButton(icon: Icon(Icons.more_vert), onPressed: _showMenu),
        ],
        bottom: CustomTabBar(tabController: _tabController),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ChatScreen(),
          MediaScreen(),
          FriendsScreen(),
          SettingsScreen(),
        ],
      ),
      floatingActionButton: _buildFAB(),
    );
  }

  Widget _buildFAB() {
    switch (_tabController.index) {
      case 0: return FloatingActionButton(
        child: Icon(Icons.chat),
        onPressed: _startNewChat,
      );
      case 1: return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _uploadMedia,
      );
      case 2: return FloatingActionButton(
        child: Icon(Icons.person_add),
        onPressed: _addFriend,
      );
      default: return SizedBox();
    }
  }

  void _showSearch() {}
  void _showMenu() {}
  void _startNewChat() {}
  void _uploadMedia() {}
  void _addFriend() {}
}
