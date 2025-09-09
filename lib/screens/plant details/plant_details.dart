import 'package:flutter/material.dart';
import 'package:farm_buddy_project_iot/screens/Activities/soil_health.dart';

class PlantDetailPage extends StatelessWidget {
  final Plant plant;

  const PlantDetailPage({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(plant.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(plant.imageUrl, fit: BoxFit.cover),
            const SizedBox(height: 10),
            Text(
              plant.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              "Best Soil: ${plant.soil}",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Text(plant.soilDetails, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
