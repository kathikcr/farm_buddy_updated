import 'package:cloud_firestore/cloud_firestore.dart';

class Detection {
  final String id;
  final String imageUrl;
  final String prediction;
  final double finalProbability;
  final bool isMultimodal;
  final Map<String, dynamic>? sensorData;
  final Timestamp timestamp;

  Detection({
    required this.id,
    required this.imageUrl,
    required this.prediction,
    required this.finalProbability,
    required this.isMultimodal,
    this.sensorData,
    required this.timestamp,
  });

  // Factory constructor to create a Detection from a Firestore document
  factory Detection.fromMap(String id, Map<String, dynamic> map) {
    return Detection(
      id: id,
      imageUrl: map['imageUrl'] ?? '',
      prediction: map['prediction'] ?? 'No prediction',
      finalProbability: (map['finalProbability'] as num?)?.toDouble() ?? 0.0,
      isMultimodal: map['isMultimodal'] ?? false,
      sensorData: map['sensorData'] != null
          ? Map<String, dynamic>.from(map['sensorData'])
          : null,
      timestamp: map['timestamp'] ?? Timestamp.now(),
    );
  }

  // Method to convert a Detection object to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'prediction': prediction,
      'finalProbability': finalProbability,
      'isMultimodal': isMultimodal,
      'sensorData': sensorData,
      'timestamp': timestamp,
    };
  }
}
