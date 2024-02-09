import 'package:firebase/views/screens/logingpage.dart';
import 'package:flutter/material.dart';

class SigningPage extends StatefulWidget {
  const SigningPage({super.key});

  @override
  State<SigningPage> createState() => _SigningPageState();
}

class _SigningPageState extends State<SigningPage> {
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
          title: Text("EMPOYEE MANAGEMENT"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("CREATE ACCOUNT",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                SizedBox(
                  height: 20,
                ),
                const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Name',
                  ),
                ),
                const SizedBox(height: 15,),
 const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email id',
                  ),
                ),
                    SizedBox(height: 15,),
 const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'password',
                  ),
                ),
                    SizedBox(height: 15,),
 const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'confirm password',
                  ),
                ),
                SizedBox(height: 15,),  
Row(
  children: [
   ElevatedButton(onPressed: (){}, child: Container(
    height: 50,
    width: 50,
   child: Center(child: Text("CREAT")),
   ),
   style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 39, 193, 198),
          ),
   ),
SizedBox(width: 15,),
    ElevatedButton(onPressed: (){}, child: Container(
    height: 50,
    width: 50,
   child: Center(child: Text("CLEAR")),
   ),
   style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 39, 193, 198),
          ),
   ),
  ],
),
const SizedBox(height: 135,),
InkWell(
  onTap: () {
     Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext)=>Loginpage()));

  },
  child: const Align(
   
    
    alignment: Alignment.bottomRight,
    child: Column(
      
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text("Do you have account?",style: TextStyle(color: Colors.black,
        fontWeight: FontWeight.bold),
        ),
        Text("Login",style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
          color: Colors.black,
        ),)
      ],
    ),
  ),
)

              ],
              
            ),
            
          ),
        ),
      ),
    );
  }
}
