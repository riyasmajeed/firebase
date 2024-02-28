import 'package:firebase/firestore.dart';
import 'package:flutter/material.dart';

class update extends StatefulWidget {
  const update({super.key});
  

  @override
  State<update> createState() => _updateState();
}

class _updateState extends State<update> {

  final FirestoreService firestoreService = FirestoreService();
void openNoteBox({String? docID}) {
  TextEditingController titleController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController DesignationController = TextEditingController();
    TextEditingController GenderController = TextEditingController();
    TextEditingController CityController = TextEditingController();
   
   


  showDialog(
    context: context,
    builder: (context) {
      return SingleChildScrollView(
        child: AlertDialog(
          title: Text('Edit Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('NAME:'),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Enter NAME',
                ),
              ),
               SizedBox(height: 16), // Adjust the height as needed
              Text('Age:'),
              TextField(
                controller: ageController,
                decoration: InputDecoration(
                  hintText: 'Enter your  age',
                ),
              ),
               Text('Designation,:'),
              TextField(
                controller: DesignationController,
                decoration: InputDecoration(
                  hintText: 'Enter your  Designation,',
                ),
              ),
 Text('Gender :'),
              TextField(
                controller: GenderController,
                decoration: InputDecoration(
                  hintText: 'Enter your  Gender ',
                ),
              ),

              Text('City:'),
              TextField(
                controller: CityController,
                decoration: InputDecoration(
                  hintText: 'Enter your  City',
                ),
              ),

            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Clear the text controllers and close the dialog
                titleController.clear();
                ageController.clear();
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Add or update the note and close the dialog
                if (titleController== docID) {
                  firestoreService.updateNote(
                    docID!,
                    titleController.text,
                    ageController.text,
                     DesignationController.text,
                      GenderController.text,
                      CityController.text,
                  );
                } else {
                 
                }
                titleController.clear();
                ageController.clear();
                 DesignationController.clear();
                      GenderController.clear();
                      CityController.clear();
                Navigator.of(context).pop();
              },
              child: Text( 'Update'),
            ),
          ],
        ),
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      home:Scaffold(
        appBar: AppBar(
          title: Text("welcome"),
        ),
      
      ) ,
    );
  }
}