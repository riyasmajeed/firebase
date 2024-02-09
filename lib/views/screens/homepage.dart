import 'package:firebase/views/screens/logingpage.dart';
import 'package:firebase/views/screens/signingpage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
home: Scaffold(
  body: 
  Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(colors: [
        Color(0xff881736),
        Color(0xff281537),
      ])
    ),
    child: Padding(
     padding: const EdgeInsets.only(top: 30),
     child: Center(
     child: Column(
      children: [
     ElevatedButton(onPressed: (){
     Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext)=>SigningPage()));
     },
     child:Container(
      height: 52, 
      width: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        // border: Border.all(width: 2,color: Colors.black)
        
      ),
      child: Center(
        child: Text("Signing page",style: TextStyle(color: Colors.black),),
      ),
     )
     
     ),
     SizedBox(height: 20,),
     
     ElevatedButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext)=>Loginpage()));
      // Navigator.pushNamed(context, '/page');
     },
     child:Container(
      height: 52,
      width: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        // border: Border.all(width: 2,color: Colors.black)
        
      ),
      child: const Center(
        child: Text("Login page",style: TextStyle(color: Colors.black),),
      ),
     )
     
     )
        
      ],
     ),
     ),
     ),
  ),
),

    );
  }
}