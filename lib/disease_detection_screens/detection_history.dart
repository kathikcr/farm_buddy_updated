import 'package:farm_buddy_project_iot/models/detection_model.dart';
import 'package:farm_buddy_project_iot/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<Detection>> _detectionsFuture;
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _loadDetections();
  }

  void _loadDetections() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // If no user is logged in, show an empty list
      setState(() {
        _detectionsFuture = Future.value([]);
      });
      return;
    }

    setState(() {
      _detectionsFuture = _firestoreService.getDetectionsByUserId(user.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detection History')),
      body: RefreshIndicator(
        onRefresh: () async => _loadDetections(),
        child: FutureBuilder<List<Detection>>(
          future: _detectionsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No history found.'));
            }

            final detections = snapshot.data!;
            return ListView.builder(
              itemCount: detections.length,
              itemBuilder: (context, index) {
                final detection = detections[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        detection.imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, progress) {
                          return progress == null
                              ? child
                              : CircularProgressIndicator();
                        },
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.error),
                      ),
                    ),
                    title: Text(
                      detection.prediction,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${DateFormat.yMMMd().add_jm().format(detection.timestamp.toDate())}\n',
                    ),
                    trailing: detection.isMultimodal
                        ? Icon(
                            Icons.sensors,
                            color: Colors.blue,
                            semanticLabel: 'Multimodal',
                          )
                        : Icon(
                            Icons.image,
                            color: Colors.grey,
                            semanticLabel: 'Image Only',
                          ),
                    isThreeLine: true,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
