import 'package:firebase/controll/firebase_auth_service.dart';
import 'package:firebase/views/Textwidget/Text.dart';
import 'package:firebase/views/screens/signingpage.dart';
import 'package:firebase/views/screens/user_detiles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _userPasswordController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              backgroundColor: Colors.cyan,
              centerTitle: true,
              title: title,
            ),
            body: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color(0xff881736),
                Color(0xff281537),
              ])),
              child: SingleChildScrollView(
                  child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("LOGIN ACCOUNT"),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _userNameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          hintText: 'Enter Name',
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: _userEmailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          hintText: 'Email id',
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: _userPasswordController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          hintText: 'password',
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () => signIn(context),
                            child: Text("Login"),
                          ),
                          SizedBox(width: 15),
                          ElevatedButton(
                            onPressed: _clearFields,
                            child: Text("CLEAR"),
                          ),
                        ],
                      ),
                      SizedBox(height: 200),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => SigningPage()),
                          );
                        },
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                " you don't have account?",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "signing",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ]),
              )),
            )));
  }

  void signIn(BuildContext context) async {
    String email = _userEmailController.text;
    String password = _userPasswordController.text;

    Object? user = await _auth.loginWithEmailAndPassword(email, password);

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("User created successfully"),
        ),
      );
      print('Login Successful');
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) =>  UserDetailsScreen()),
      );
    } else {
      print('Login Failed');
      // Display error message or dialog
    }
  }

  void _clearFields() {
    _userNameController.text = '';
    _userEmailController.text = '';
    _userPasswordController.text = '';
  }
}
