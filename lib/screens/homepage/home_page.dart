import 'package:farm_buddy_project_iot/disease_detection_screens/disease.dart';
import 'package:farm_buddy_project_iot/screens/Activities/crop_management.dart';
import 'package:farm_buddy_project_iot/disease_detection_screens/detection_history.dart';
import 'package:farm_buddy_project_iot/screens/Activities/expert_advice.dart';
import 'package:farm_buddy_project_iot/screens/Activities/soil_health.dart';
import 'package:farm_buddy_project_iot/screens/Activities/market_prices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, dynamic>> cards = [
    {
      "title": "Crop Management",
      "icon": Icons.agriculture,
      "page": CropManagement(),
    },
    {"title": "Disease Detection", "icon": Icons.search, "page": Disease()},
    {
      "title": "Soil Information",
      "icon": Icons.terrain,
      "page": SoilHealthPage(),
    },
    {
      "title": "Market Prices",
      "icon": Icons.shopping_bag,
      "page": CropPricePage(),
    },
    {"title": "Expert Advice", "icon": Icons.person, "page": ExpertAdvice()},
    {
      "title": "Detection History",
      "icon": Icons.timelapse,
      "page": HistoryScreen(),
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome Back', style: Theme.of(context).textTheme.titleLarge),

            Text(
              'Enjoy our Services',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const LoginPage()),
              // );
            },
            icon: const Icon(Icons.logout, color: Colors.grey),
          ),
        ],
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: cards.map((card) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => card["page"]),
                );
              },
              child: Card(
                color: Colors.green,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(card["icon"], size: 50, color: Colors.white),
                    SizedBox(height: 10),
                    Text(
                      card["title"],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
