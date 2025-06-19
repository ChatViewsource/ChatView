import 'package:flutter/material.dart';
import 'package:chatview/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:chatview/services/chat_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatService()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatView',
      theme: ThemeData(
        primaryColor: Color(0xFF7289DA),
        colorScheme: ColorScheme.light(
          secondary: Color(0xFF99AAB5),
        ),
        fontFamily: 'Tajawal',
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(
          secondary: Color(0xFF99AAB5),
        ),
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
