import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // Placeholder data
  double batteryLevel = 75.0;
  double feedLevel = 40.0;

  List<Map<String, dynamic>> birdVisits = [
    {'name': 'Cardinal', 'time': '3:42 PM'},
    {'name': 'Blue Jay', 'time': '1:15 PM'},
    {'name': 'Sparrow', 'time': '11:10 AM'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notifications")),
      drawer: AppDrawer(), // ✅ Drawer included here
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Battery Section
            _buildSectionTitle('Battery Level'),
            _buildStatusCard(
              icon: Icons.battery_3_bar_sharp,
              text: 'Battery: ${batteryLevel.toStringAsFixed(0)}%',
            ),
            const SizedBox(height: 16),

            // Feed Level Section
            _buildSectionTitle('Feed Level'),
            _buildStatusCard(
              icon: Icons.restaurant,
              text: 'Feed Remaining: ${feedLevel.toStringAsFixed(0)}%',
            ),
            const SizedBox(height: 16),

            // Bird Visits Section
            _buildSectionTitle('Recent Bird Visits'),
            Column(
              children: birdVisits.map((bird) {
                return ListTile(
                  leading: const Icon(Icons.local_florist),
                  title: Text(bird['name']),
                  subtitle: Text('Time: ${bird['time']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.play_circle_fill),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Video not yet available")),
                      );
                    },
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            // Future video/live feed section
            _buildSectionTitle('Live Feed (Coming Soon)'),
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(child: Text("Live video feature coming soon")),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable widgets
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildStatusCard({required IconData icon, required String text}) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, size: 35),
        title: Text(text, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
