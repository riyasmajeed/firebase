import 'package:firebase/controll/firebase_auth_service.dart';
import 'package:firebase/views/screens/logingpage.dart';
import 'package:firebase/views/screens/user_detiles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class SigningPage extends StatefulWidget {
  const SigningPage({Key? key}) : super(key: key);

  @override
  State<SigningPage> createState() => _SigningPageState();
}

class _SigningPageState extends State<SigningPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  
    _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _userPasswordController = TextEditingController();
  TextEditingController _userConfirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _userEmailController.dispose();
    _userPasswordController.dispose();
    _userConfirmPasswordController.dispose();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          // App bar configuration...
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "CREATE ACCOUNT",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _userNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Name',
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: _userEmailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email id',
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: _userPasswordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                  ),
                  obscureText: true, // Secure text entry
                ),
                SizedBox(height: 15),
                TextField(
                  controller: _userConfirmPasswordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Confirm password',
                  ),
                  obscureText: true, // Secure text entry
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: 
                      () => _signUp(context),
                      
                      child: Text("CREATE"),
                    ),
                    SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: _clearFields,
                      child: Text("CLEAR"),
                    ),
                  ],
                ),
                SizedBox(height: 135),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Loginpage()),
                    );
                  },
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Do you have an account?",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signUp(BuildContext context) async {
    String userName = _userNameController.text;
    String email = _userEmailController.text;
    String password = _userPasswordController.text;
    String confirmPassword = _userConfirmPasswordController.text;

    // Add validation logic
    if (password != confirmPassword) {
      // Passwords don't match
      // Display error message or dialog
      return;
    }

    // You can add further validation for email format, password strength, etc.

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    if (user != null) {
     print(' Detail Updated Success');
     _showSuccessSnackBar(' Detail Updated Success');
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => userdetiles()),
      );
    } else {
      print("Some error occurred");
      // Display error message or dialog
    }
  }

  void _clearFields() {
    _userNameController.text = '';
    _userEmailController.text = '';
    _userPasswordController.text = '';
    _userConfirmPasswordController.text = '';
  }
}
