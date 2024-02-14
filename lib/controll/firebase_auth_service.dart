




import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

 

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      return credential.user;
    } catch (e) {
      print("Error signing up: $e");
      return null;
    }
  }

  Future<Object?> loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
     
      return 'Error logging in: $e';
    }
  }

  Future<Object> signUpWithEmailAndPasswordAndConfirmPassword(
    String email,
    String password,
    String confirmPassword,
  ) async {
    if (password != confirmPassword) {
      
      return 'Passwords do not match.';
    }
    return signUpWithEmailAndPassword(email, password);
  }
}
