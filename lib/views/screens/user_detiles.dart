

import 'package:flutter/material.dart';

class userdetiles extends StatefulWidget {
  const userdetiles({super.key});

  @override
  State<userdetiles> createState() => _userdetilesState();
}

class _userdetilesState extends State<userdetiles> {
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
),

    );
  }
}