import 'package:flutter/material.dart';

// --- Data Model ---
// A class to hold the expert's information.
class Expert {
  final String name;
  final String title;
  final String phone;
  final String email;

  const Expert({
    required this.name,
    required this.title,
    required this.phone,
    required this.email,
  });
}

// --- Main Page Widget ---
// This is the main screen that displays the list.
class ExpertAdvice extends StatelessWidget {
  const ExpertAdvice({super.key});

  // A list holding the data for all the experts.
  final List<Expert> experts = const [
    Expert(
      name: 'Dr. Jane Smith',
      title: 'Plant Nutrition Expert',
      phone: '99987 64321',
      email: 'jane.smith@example.com',
    ),
    Expert(
      name: 'Dr. John Doe',
      title: 'Soil Health Specialist',
      phone: '91234 56789',
      email: 'john.doe@example.com',
    ),
    Expert(
      name: 'Dr. Emily White',
      title: 'Agricultural Scientist',
      phone: '98765 43210',
      email: 'emily.white@example.com',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expert Advice')),
      // Use ListView.builder to create a scrollable list from your data.
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: experts.length,
        itemBuilder: (BuildContext context, int index) {
          // For each item in the list, create a reusable ExpertInfoCard.
          return ExpertInfoCard(expert: experts[index]);
        },
      ),
    );
  }
}

// --- Reusable Card Widget ---
// A separate widget for the card's UI to avoid repeating code.
class ExpertInfoCard extends StatelessWidget {
  const ExpertInfoCard({super.key, required this.expert});

  final Expert expert;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: const Color.fromARGB(255, 161, 160, 160)),
      ),
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: const Icon(
                Icons.person_pin_rounded,
                size: 40,
                color: Colors.blueAccent,
              ),
              title: Text(
                expert.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Text(expert.title),
            ),
            const SizedBox(height: 8),
            Text(
              'Contact: ${expert.phone}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 4),
            Text(
              'Email: ${expert.email}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
