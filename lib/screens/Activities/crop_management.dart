import 'package:farm_buddy_project_iot/add_new_task.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CropManagement extends StatefulWidget {
  const CropManagement({super.key});

  @override
  State<CropManagement> createState() => _CropManagementState();
}

class _CropManagementState extends State<CropManagement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Crop Management",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddNewTask(),
                      ),
                    );
                    setState(() {}); // refresh after adding
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Add New Crop Details"),
                ),
              ),
            ),
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('crops')
                .where(
                  'creator',
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid,
                )
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData) {
                return const Text("No Crop Details Found");
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    //get crop data
                    final crop = snapshot.data!.docs[index].data();
                    // Convert Firestore Timestamp to DateTime
                    DateTime? date;
                    if (crop['date'] != null) {
                      date = (crop['date'] as Timestamp).toDate();
                    }
                    return ListTile(
                      title: Text(crop['title'] ?? 'Unknown Crop'),
                      subtitle: Text(
                        date != null
                            ? 'Date: ${date.day}/${date.month}/${date.year}'
                            : 'No Date Provided',
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection('crops')
                              .doc(snapshot.data!.docs[index].id)
                              .delete();
                          setState(() {}); // refresh after deletion
                        },
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),

                      onTap: () {
                        // Navigate to detail page or perform any action
                      },
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
