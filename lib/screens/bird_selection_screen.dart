import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../data/birds.dart';
import '../widgets/bird_tile.dart';
import 'dart:convert';  
import 'package:http/http.dart' as http; 

class BirdSelectionScreen extends StatefulWidget {
  const BirdSelectionScreen({super.key});

  @override
  State<BirdSelectionScreen> createState() => _BirdSelectionScreenState();
}

class _BirdSelectionScreenState extends State<BirdSelectionScreen> {
  bool isWantedMode = true;

  // Send data to Raspberry Pi (HTTP POST)
  Future<void> transmitData() async {
    final wanted = birdList.where((b) => b.isWanted).map((b) => b.name).toList();
    final unwanted = birdList.where((b) => b.isUnwanted).map((b) => b.name).toList();

    final data = {
      "wanted_birds": wanted,
      "unwanted_birds": unwanted,
    };

    print("Sending to Pi...");
    print("Wanted: $wanted");
    print("Unwanted: $unwanted");

    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.10:5000/birds'), // Change to your Pi's IP
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Preferences sent to Raspberry Pi!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("⚠ Failed: ${response.statusCode}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  // Reset selections when switching modes
  void resetSelections() {
    for (var bird in birdList) {
      bird.isWanted = false;
      bird.isUnwanted = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min, // Keeps title and icon together
          children: [
            const Text("SmartPerch Bird Selector"),
            const SizedBox(width: 8), // Space between text and icon
            Tooltip(
              message:
                  'Select which birds you want to feed (Wanted) or avoid (Unwanted). '
                  'Tap on birds to select/deselect. Use the switch to change mode. '
                  'Press the send button to transmit preferences to the feeder.',
              child: IconButton(
                icon: const Icon(Icons.help_outline),
                onPressed: () {
                  // Detailed help dialog
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Help'),
                      content: const Text(
                        'Select which birds you want to feed (Wanted) or avoid (Unwanted). '
                        'Tap on birds to select/deselect. Use the switch to change mode. '
                        'Press the send button to transmit preferences to the feeder.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(),
                          child: const Text('Got it!'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        actions: [
          Switch(
            value: isWantedMode,
            onChanged: (value) {
              setState(() {
                isWantedMode = value;
                resetSelections(); // ✅ Clears all selections when switching modes
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Text(isWantedMode ? "Wanted" : "Unwanted"),
          ),
        ],
      ),

      drawer: AppDrawer(),

      body: GridView.builder(
        padding: const EdgeInsets.all(2),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          childAspectRatio: 1,
        ),
        itemCount: birdList.length,
        itemBuilder: (context, index) {
          final bird = birdList[index];
          return BirdTile(
            bird: bird,
            isWantedMode: isWantedMode,
            onSelected: (value) {
              setState(() {
                if (isWantedMode) {
                  bird.isWanted = value;
                  bird.isUnwanted = false;
                } else {
                  bird.isUnwanted = value;
                  bird.isWanted = false;
                }
              });
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: transmitData, 
        tooltip: "Send Preferences to Feeder",
        child: const Icon(Icons.send),
      ),
    );
  }
}
