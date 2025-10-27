import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top Section with Logo and Title
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/smartperch_logo.png', // Replace with your logo path
                    width: 450,
                    height: 450,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            // About Section
            Container(
              width: double.infinity,
              color: Colors.blueGrey[50],
              padding: const EdgeInsets.all(20),
              child: Column(
                children: const [
                  Text(
                    'About SmartPerch',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Here at SIUE, we decided to solve the limitations of simple bird feeders by making a truly smart one.​ SmartPerch incorporates the AI tech of existing bird feeders, with the goal of mechanical selective feeders. ​'
                    'Using image recognition to determine bird type, you are now able be slective about which birds you would like to feed! \n'
                    'Scroll down to learn how to connect your devices and begin selecting!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // How to Connect Section
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: const [
                  Text(
                    'How to Connect',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '1. here\n',

                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
