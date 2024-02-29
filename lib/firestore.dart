import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // Get collection of notes
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('users');

  // Create and add a new note
  Future<void> addNote(String note,String age,String Designation,String Gender,String City,String imageUrl) {
    return notes.add({
      'note': note,
      'timestamp': Timestamp.now(),
        'age':age ,
        'Designation':Designation,
        'Gender':Gender,
        'City': City,
        'image':imageUrl,
    });
  }

  // Read and get notes from database
  Stream<QuerySnapshot> getNotesStream() {
    final notesStream =
        notes.orderBy('timestamp', descending: true).snapshots();

    return notesStream;
  }

  // Update note given a doc id
  Future<void> updateNote(String docID, 
   String note, String age,String Designation,String Gender,String City, 
  ) {
    return notes.doc(docID).update({
       'note': note,
       'timestamp': Timestamp.now(),
       'age':age,
         'Designation':Designation,
         'Gender':Gender,
         'City': City,

    });
  }

  // Delete note given doc id
  Future<void> deleteNote(String docID) {

    return notes.doc(docID).delete();
  }

 
}