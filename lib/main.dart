import 'package:firebase/views/Textwidget/Text.dart';
import 'package:firebase/views/screens/homepage.dart';
import 'package:firebase/views/screens/signingpage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
home: Scaffold(
 appBar: AppBar(
  backgroundColor: Colors.cyan,
centerTitle: true,
title:
 title,
 ),
 
 body: const HomePage(),
  
),
  
    );
  }
}
