import 'package:flutter/material.dart';

class CropDetailPage extends StatelessWidget {
  final Map<String, dynamic> crop;

  const CropDetailPage({super.key, required this.crop});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(crop['crop'])),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                crop['image'],
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),

            Text(
              crop['crop'],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),

            // ✅ DETAILED INFO: Variety is shown here
            Text(
              crop['variety'],
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
            const Divider(height: 30, thickness: 1),

            // All the detailed rows are present here
            _buildDetailRow("Market", crop['market']),
            _buildDetailRow("Modal Price", "₹${crop['modalPrice']} / Qtl"),
            // ✅ DETAILED INFO: Arrival is shown here
            _buildDetailRow("Today's Arrival", crop['arrival']),
            _buildTrendRow("Price Trend", crop['trend']),
          ],
        ),
      ),
    );
  }

  // Helper widget to create a consistent row style for details
  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // A specific helper for showing the trend with an icon
  Widget _buildTrendRow(String title, String trend) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
          Row(
            children: [
              Text(
                trend[0].toUpperCase() + trend.substring(1), // Capitalize
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 5),
              if (trend == 'up')
                const Icon(Icons.arrow_upward, color: Colors.green)
              else if (trend == 'down')
                const Icon(Icons.arrow_downward, color: Colors.red)
              else
                const Icon(Icons.horizontal_rule, color: Colors.grey),
            ],
          ),
        ],
      ),
    );
  }
}
