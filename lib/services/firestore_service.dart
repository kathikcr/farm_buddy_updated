import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_buddy_project_iot/models/detection_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Uploads an image and adds the detection record to Firestore
  Future<void> addDetection({
    required File imageFile,
    required String prediction,
    required double finalProbability,
    required bool isMultimodal,
    Map<String, dynamic>? sensorData,
    required String userId, // Add userId parameter
  }) async {
    try {
      // 1. Upload image to Firebase Storage
      // Store images in a user-specific folder
      String fileName =
          'detections/$userId/${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference storageRef = _storage.ref().child(fileName);
      UploadTask uploadTask = storageRef.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // 2. Add detection data to Firestore
      await _db.collection('detections').add({
        'imageUrl': downloadUrl,
        'prediction': prediction,
        'finalProbability': finalProbability,
        'isMultimodal': isMultimodal,
        'sensorData': sensorData,
        'timestamp': FieldValue.serverTimestamp(),
        'userId': userId, // Save the userId
      });
    } catch (e) {
      print("Error adding detection: $e");
      rethrow;
    }
  }

  // Fetches detection records for a specific user using a Firestore query
  Future<List<Detection>> getDetectionsByUserId(String userId) async {
    try {
      QuerySnapshot snapshot = await _db
          .collection('detections')
          .where('userId', isEqualTo: userId) // Filter by user ID
          .orderBy('timestamp', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        return Detection.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print("Error fetching user detections: $e");
      return [];
    }
  }

  // The previous getDetections() method can be removed or kept as a general-purpose function
  Future<List<Detection>> getDetections() async {
    try {
      QuerySnapshot snapshot = await _db
          .collection('detections')
          .orderBy('timestamp', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        return Detection.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print("Error fetching detections: $e");
      return [];
    }
  }
}
