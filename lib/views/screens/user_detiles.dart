import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({Key? key}) : super(key: key);

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  void openUserDetailsDialog({String? docID, Map<String, dynamic>? userData}) {
    TextEditingController nameController =
        TextEditingController(text: userData?['name']);
    TextEditingController ageController =
        TextEditingController(text: userData?['age']);
    TextEditingController designationController =
        TextEditingController(text: userData?['designation']);
    TextEditingController genderController =
        TextEditingController(text: userData?['gender']);
    TextEditingController cityController =
        TextEditingController(text: userData?['city']);

    String imageUrl = userData?['imageUrl'] ?? "";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(docID == null ? 'Add User Details' : 'Edit User Details'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name:'),
                  TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter a name";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Name',
                    ),
                  ),
                  SizedBox(height: 16),
                  Text('Age:'),
                  TextFormField(
                    controller: ageController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter an age";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Age',
                    ),
                  ),
                  Text('Designation:'),
                  TextFormField(
                    controller: designationController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter a designation";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Designation',
                    ),
                  ),
                  Text('Gender:'),
                  TextFormField(
                    controller: genderController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter a gender";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Gender',
                    ),
                  ),
                  Text('City:'),
                  TextFormField(
                    controller: cityController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter a city";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter City',
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () async {
                final pickedFile =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (pickedFile == null) return;

                String fileName =
                    DateTime.now().millisecondsSinceEpoch.toString(); // Using milliseconds for a more unique filename

                Reference referenceRoot = FirebaseStorage.instance.ref();
                Reference referenceDireImage = referenceRoot.child('image');

                // Create reference for the image to be stored
                Reference referenceImageToUpload =
                    referenceDireImage.child(fileName);

                // Upload the image
                try {
                  await referenceImageToUpload.putFile(File(pickedFile.path));
                  // Handle success here if needed
                  imageUrl =
                      await referenceImageToUpload.getDownloadURL();
                } catch (e) {
                  // Handle errors here
                }
              },
              icon: const Icon(Icons.camera_alt),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (docID == null) {
                    usersCollection.add({
                      'name': nameController.text,
                      'age': ageController.text,
                      'designation': designationController.text,
                      'gender': genderController.text,
                      'city': cityController.text,
                      'imageUrl': imageUrl, // Add imageUrl to Firestore
                    }).then((_) {
                      showSuccessSnackBar('User Added Successfully');
                    });
                  } else {
                    usersCollection.doc(docID).update({
                      'name': nameController.text,
                      'age': ageController.text,
                      'designation': designationController.text,
                      'gender': genderController.text,
                      'city': cityController.text,
                      'imageUrl': imageUrl, // Update imageUrl in Firestore
                    }).then((_) {
                      showSuccessSnackBar(
                          'User Details Updated Successfully');
                    });
                  }
                  nameController.clear();
                  ageController.clear();
                  designationController.clear();
                  genderController.clear();
                  cityController.clear();
                  Navigator.of(context).pop();
                }
              },
              child: Text(docID == null ? 'Add' : 'Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('User Details'),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: usersCollection.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = snapshot.data!.docs[index];
                  String docID = document.id;

                  Map<String, dynamic> userData =
                      document.data() as Map<String, dynamic>;

                  return ListTile(
                    leading: CircleAvatar(
                      radius: 27,
                      backgroundImage: NetworkImage(userData['imageUrl']),
                    ),
                    title: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Name: ${userData['name']}'),
                          Text('Age: ${userData['age']}'),
                          Text(
                              'Designation: ${userData['designation']}'),
                          Text('Gender: ${userData['gender']}'),
                          Text('City: ${userData['city']}'),
                        ],
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            openUserDetailsDialog(
                                docID: docID, userData: userData);
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Confirm Deletion"),
                                  content: const Text(
                                      "Are you sure you want to delete this user?"),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        usersCollection.doc(docID).delete();
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Delete"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => openUserDetailsDialog(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

