

import 'package:firebase/firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
 


class userdetiles extends StatefulWidget {
  const userdetiles({super.key});



  @override
  State<userdetiles> createState() => _userdetilesState();
}

class _userdetilesState extends State<userdetiles> {
  // fire store
final FirestoreService firestoreService = FirestoreService();

TextEditingController textController = TextEditingController();
//open a dialog box 
  void openNoteBox({String? docID}){
    showDialog(context: context, 
    builder:(context) => AlertDialog(
      // test user input
content: TextField(
  controller: textController,
),
actions: [
  ElevatedButton(onPressed: (){
   if(docID==null){
     firestoreService.addNote(textController.text);
   }
   //updata an existing note 
   else{
    firestoreService.updateNote(docID, textController.text);
   }
    //clear the text controller
    textController.clear();
    //close the box 
    Navigator.pop(context);
  }, child: Text("add"),)
],
    ),);
  }
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
home: Scaffold(
  appBar: AppBar(
    backgroundColor: Colors.blue,
    title: const Center(
      child: Text(
        "welcome"
        
      ),
    ),
  ),

  floatingActionButton: FloatingActionButton(onPressed: 
    openNoteBox,

  child: const Icon(Icons.add),
  ),

  body:  StreamBuilder<QuerySnapshot>(
    stream: firestoreService.getNotesStream(),
    builder: (context, snapshot) {
      //if we have data get all the docs
      if(snapshot.hasData){
        List notesList = snapshot.data!.docs;

        //display as a list
        return ListView.builder(itemCount: notesList.length,
          itemBuilder: (context, index) {
          //get each individual doc 
          DocumentSnapshot document = notesList[index];
          String docID = document.id;

          //get note from each doc
          Map<String,dynamic>data =document.data() as Map<String,dynamic>;
          String noteText = data ['note'];
          

          //display as a list tile
          return ListTile(
  title: Text(noteText),
  trailing: Row(
    mainAxisSize: MainAxisSize.min, // Ensure row takes minimum space
    children: [
      SizedBox(
        width: 40, // Adjust the width according to your preference
        child: IconButton(
          onPressed: () => openNoteBox(docID: docID),
          icon: const Icon(Icons.settings),
        ),
      ),
      SizedBox(
        width: 40, // Adjust the width according to your preference
        child: IconButton(
          onPressed: () => firestoreService.deleteNote(docID),
          icon: const Icon(Icons.delete),
        ),
      ),
    ],
  ),
);

          // return ListTile(
          //   title: Text(noteText),
          //   trailing: 
          //    Row(
          //      children: [
          //       //update button
          //        IconButton(onPressed: ()=>openNoteBox(docID:docID), icon: const Icon(Icons.settings)),
          //        //delete button
          //         IconButton(onPressed: ()=>firestoreService.deleteNote(docID), icon: const Icon(Icons.delete)),
          //      ],
          //    ),
          // );



        },);
      }
      else{
        return const Text('no data');
      }


    },



  ),



),

    );
  }
}