import 'package:flutter/material.dart';
import 'screens/notification_screen.dart';
import 'screens/home_screen.dart';
import 'screens/bird_selection_screen.dart';

void main() {
  runApp(const SmartPerchApp());
}

class SmartPerchApp extends StatelessWidget {
  const SmartPerchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Perch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),  // ✅ HomeScreen can be const if stateless
        '/selection': (context) => BirdSelectionScreen(), // ❌ Remove const here
        '/notifications': (context) => NotificationsScreen(),
      },
    );
  }
}
