
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

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _userPasswordController = TextEditingController();
  TextEditingController _userConfirmPasswordController =
      TextEditingController();
  bool _validateName = false;
  bool _validateEmail = false;
  bool _validatePassword = false;
  bool _validateConfirmPassword = false;
  bool _isSigning = false;

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
                    errorText: _validateName ? 'Name can\'t be empty' : null,
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: _userEmailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email id',
                    errorText: _validateEmail ? 'Email can\'t be empty' : null,
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: _userPasswordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                    errorText:
                        _validatePassword ? 'Password can\'t be empty' : null,
                  ),
                  obscureText: true, // Secure text entry
                ),
                SizedBox(height: 15),
                TextField(
                  controller: _userConfirmPasswordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Confirm password',
                    errorText: _validateConfirmPassword
                        ? 'Confirm password can\'t be empty'
                        : null,
                  ),
                  obscureText: true, // Secure text entry
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _isSigning ? null : () => _signUp(context),
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
    setState(() {
      _isSigning = true;
    });

    String userName = _userNameController.text;
    String email = _userEmailController.text;
    String password = _userPasswordController.text;
    String confirmPassword = _userConfirmPasswordController.text;

    // Add validation logic
    if (password != confirmPassword) {
      setState(() {
        _isSigning = false;
      });
      return;
    }

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    setState(() {
      _isSigning = false;
    });

    if (user != null) {
      _showSuccessSnackBar('User created successfully');
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => userdetiles()),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Sign Up Failed"),
            content: Text("Failed to create user. Please try again."),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _clearFields() {
    _userNameController.text = '';
    _userEmailController.text = '';
    _userPasswordController.text = '';
    _userConfirmPasswordController.text = '';
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
