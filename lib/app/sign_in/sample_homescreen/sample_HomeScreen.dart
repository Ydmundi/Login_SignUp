// ignore_for_file: file_names, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../sign_in_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.ID}) : super(key: key);
  final String ID;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Sample Home Screen",
        ),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Text('UID: ${widget.ID}'),

          Container(
            margin: const EdgeInsets.all(65),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              
              onPressed: (){
                FirebaseAuth.instance.signOut();
                Navigator.of(context).push(MaterialPageRoute(builder: (c)=> SignInPage()));
              },

              child: const Text(
                "Logout",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  
                ),
              ),
            )
          )
        ],
      ),

    );
  }
}