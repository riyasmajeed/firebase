import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      print("Error signing up: $e");
      _showToast("Error signing up: $e");
      return null;
    }
  }

  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      print('Error logging in: $e');
      _showToast("Error logging in: $e");
      return null;
    }
  }

  Future<User?> signUpWithEmailAndPasswordAndConfirmPassword(
    String email,
    String password,
    String confirmPassword,
  ) async {
    if (password != confirmPassword) {
      print('Passwords do not match.');
      _showToast('Passwords do not match.');
      return null;
    }
    return signUpWithEmailAndPassword(email, password);
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }
}
