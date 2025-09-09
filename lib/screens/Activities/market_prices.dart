import 'package:farm_buddy_project_iot/screens/plant%20details/crop_price_details.dart';
import 'package:flutter/material.dart';

// Your data remains the same, with all the details
final List<Map<String, dynamic>> cropData = [
  {
    "crop": "Rice",
    "market": "Bangalore",
    "variety": "Sona Masuri",
    "modalPrice": 2900,
    "trend": "up",
    "arrival": "1500 Qtl",
    "image": "assets/images/rice.jpg",
  },
  {
    "crop": "Wheat",
    "market": "Delhi",
    "variety": "Sharbati",
    "modalPrice": 2500,
    "trend": "down",
    "arrival": "3200 Qtl",
    "image": "assets/images/wheat.jpg",
  },
  {
    "crop": "Millets",
    "market": "Hyderabad",
    "variety": "Pearl Millets",
    "modalPrice": 2200,
    "trend": "stable",
    "arrival": "950 Qtl",
    "image": "assets/images/millets.jpg",
  },
];

class CropPricePage extends StatelessWidget {
  const CropPricePage({super.key});

  Widget _getTrendIcon(String trend) {
    if (trend == 'up') {
      return const Icon(Icons.arrow_upward, color: Colors.green, size: 18);
    } else if (trend == 'down') {
      return const Icon(Icons.arrow_downward, color: Colors.red, size: 18);
    }
    return const Icon(Icons.horizontal_rule, color: Colors.grey, size: 18);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Market Prices")),
      body: ListView.builder(
        itemCount: cropData.length,
        itemBuilder: (context, index) {
          final crop = cropData[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CropDetailPage(crop: crop),
                  ),
                );
              },
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  crop['image'],
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                crop['crop'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              // ✅ SIMPLIFIED SUBTITLE
              // Now it only shows the market name.
              subtitle: Text(
                crop['market'],
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "₹${crop['modalPrice']}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      _getTrendIcon(crop['trend']),
                    ],
                  ),
                  const Text(
                    "/ Qtl",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
