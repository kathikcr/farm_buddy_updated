import 'package:farm_buddy_project_iot/disease_detection_screens/detection_history.dart';
import 'package:farm_buddy_project_iot/disease_detection_screens/disease_detection.dart';
import 'package:farm_buddy_project_iot/disease_detection_screens/mutimodel_screen.dart';
import 'package:flutter/material.dart';

class Disease extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rice Sheath Blight Detection')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageDetectionScreen(),
                  ),
                );
              },
              child: Text('Image Detection'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiModalDetectionScreen(),
                  ),
                );
              },
              child: Text('Multimodal Detection'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistoryScreen()),
                );
              },
              child: Text('View Detection History'),
            ),
          ],
        ),
      ),
    );
  }
}
