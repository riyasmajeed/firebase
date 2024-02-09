import 'package:firebase/views/Textwidget/Text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  @override
  Widget build(BuildContext context) {
     
    return MaterialApp(
home: Scaffold(
  appBar: AppBar(
    leading:
           IconButton(onPressed: (){
             Navigator.pop(context);
           }, icon:  const Icon(Icons.arrow_back,color: Colors.black,
            ),),
  backgroundColor: Colors.cyan,
centerTitle: true,
title:
 title,
 ),
       body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("LOGIN ACCOUNT"),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Name',
                  ),
                ),
                SizedBox(height: 15,),
 TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email id',
                  ),
                ),
                    SizedBox(height: 15,),
 TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'password',
                  ),
                ),
              ]
),
  
    )
       )
)
);
  }
}