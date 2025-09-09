import 'package:farm_buddy_project_iot/screens/plant%20details/plant_details.dart';
import 'package:flutter/material.dart';

// Plant model
class Plant {
  final String name;
  final String soil;
  final String imageUrl;
  final String soilDetails;

  Plant({
    required this.name,
    required this.soil,
    required this.imageUrl,
    required this.soilDetails,
  });
}

// Plant data with soil details
final List<Plant> plants = [
  Plant(
    name: "Rice",
    soil: "Clayey or Loamy Soil",
    imageUrl: "assets/images/rice.jpg",
    soilDetails:
        "Rice grows best in clayey and loamy soils that can hold water for long periods. "
        "Since rice requires standing water during most of its growth, such soils are ideal for puddling and transplanting. "
        "Farmers should ensure the field has proper bunds to retain water and prevent seepage.",
  ),
  Plant(
    name: "Wheat",
    soil: "Loamy or Clay Loam Soil",
    imageUrl: "assets/images/wheat.jpg",
    soilDetails:
        "Wheat prefers well-drained loamy or clay loam soils rich in organic matter. "
        "These soils store enough moisture for the crop but do not get waterlogged, which is important for wheat’s growth during cooler and relatively dry seasons. "
        "Adding farmyard manure before sowing helps improve soil fertility and yield.",
  ),
  Plant(
    name: "Coconut",
    soil: "Sandy, Alluvial or Laterite Soil",
    imageUrl: "assets/images/coconut.jpg",
    soilDetails:
        "Coconut thrives in sandy, alluvial, or laterite soils that have good drainage and a high water table. "
        "Coconut roots need both moisture and aeration; therefore, waterlogged soils harm the plant, while overly dry soils reduce productivity. "
        "Farmers in coastal and river basin areas often get the best results, especially when they apply organic matter regularly.",
  ),
  Plant(
    name: "Millets",
    soil: "Light Sandy or Red Loamy Soil",
    imageUrl: "assets/images/millets.jpg",
    soilDetails:
        "Millets such as bajra, ragi, and jowar are hardy crops that do well in light, sandy, and red loamy soils which are well-drained. "
        "These soils suit dry and less fertile regions where other crops struggle to survive. "
        "Millets are particularly suitable for rainfed conditions, but heavy clay soils should be avoided as they retain excess water.",
  ),
];

class SoilHealthPage extends StatelessWidget {
  const SoilHealthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Soil Details for Plants")),
      body: Center(
        child: GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // two cards per row
            childAspectRatio: 0.75,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: plants.length,
          itemBuilder: (context, index) {
            final plant = plants[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PlantDetailPage(plant: plant),
                  ),
                );
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        child: Image.asset(
                          plant.imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            plant.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            plant.soil,
                            style: const TextStyle(color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
