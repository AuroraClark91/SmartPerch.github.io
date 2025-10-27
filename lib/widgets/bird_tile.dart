import 'package:flutter/material.dart';
import '../models/bird.dart';

class BirdTile extends StatelessWidget {
  final Bird bird;
  final bool isWantedMode;
  final Function(bool) onSelected;

  const BirdTile({
    super.key,
    required this.bird,
    required this.isWantedMode,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = isWantedMode ? bird.isWanted : bird.isUnwanted;

    return GestureDetector(
      
      onTap: () => onSelected(!isSelected),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.green : Colors.blue,
            width: 6,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Image(
            image: ResizeImage(
              AssetImage(bird.imagePath),
              width: 200,
              height: 200,
            ),
            ),
            const SizedBox(height: 8),
            Text( 
              bird.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
