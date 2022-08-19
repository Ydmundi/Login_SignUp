// ignore_for_file: file_names, use_key_in_widget_constructors, avoid_print, import_of_legacy_library_into_null_safe


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../app/sign_in/sample_homescreen/sample_HomeScreen.dart';
import '../providers/change_provider.dart';


class OtpControllerScreen extends StatefulWidget {
  
  final String phone;
  final String name;

  const OtpControllerScreen({required this.phone, required this.name,});

  @override
  State<OtpControllerScreen> createState() => _OtpControllerScreenState();
}

class _OtpControllerScreenState extends State<OtpControllerScreen> {
  
  final GlobalKey<ScaffoldState> _scaffolkey = GlobalKey<ScaffoldState>();
  final TextEditingController _pinOTPCodeController = TextEditingController();
  final FocusNode _pinOTPCodeFocus = FocusNode();
  String? verificationCode;

  final BoxDecoration pinOTPCodeDecoration = BoxDecoration(
    color: Colors.greenAccent,
    borderRadius: BorderRadius.circular(10.0),
    
  );

  @override
  //TODO AUTO SENT CODE WHEN VISITED THE PAGE
  void initState(){
    super.initState();
    verifyPhoneNumber();
  }
  
  //TODO FIREBASE FUNCTION FOR SMS
  verifyPhoneNumber() async{
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+63 ${widget.phone}",
      verificationCompleted: (PhoneAuthCredential credential) async { 
        await FirebaseAuth.instance.signInWithCredential(credential).then((value){
          if(value.user != null) {

             if(context.watch<Change>().count==0){
             User().createUser(value.user!.uid, widget.name, "+63${widget.phone}");
             }

             Navigator.of(context).push(MaterialPageRoute(builder: (c)=> HomeScreen(
              ID: value.user!.uid,
             )));
            
            }
        });
      },

      verificationFailed: (FirebaseAuthException e ) {
        ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
              content: Text(e.message.toString()),
              duration: const Duration(seconds: 3),
            ),
          );
      },

      codeSent: (String vID, int? resentToken) {
        setState(() {
          verificationCode = vID;
        });
      },

      codeAutoRetrievalTimeout: (verificationID) async{
        setState(() {
          verificationCode = verificationID;
        });
      },

      timeout: const Duration(seconds:60),

    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffolkey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //TODO HIDDEN GESTURE AND DISPLAY PHONE NUMBER
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Center(
              child: GestureDetector(
                onTap: (){
                  verifyPhoneNumber();
                },
                child: Text(
                  "Veryfying: +63 ${widget.phone}",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ),
          
          //TODO PIN DESIGN AND MANUAL INPUT
          Padding(
            padding: const EdgeInsets.all(40.0),
            child : PinPut(
              fieldsCount: 6,
              textStyle: const TextStyle(fontSize: 25.0, color: Colors.white),
              eachFieldWidth: 40.0,
              eachFieldHeight: 55.0,
              focusNode: _pinOTPCodeFocus,
              controller: _pinOTPCodeController,
              submittedFieldDecoration: pinOTPCodeDecoration,
              selectedFieldDecoration: pinOTPCodeDecoration,
              followingFieldDecoration: pinOTPCodeDecoration,

              //pinAnimationType: PinAnimationType.rotation,
              onSubmit: (pin) async {
                try{
                  //TODO MANUAL INPUT SIGN UP OR LOGIN
                  await FirebaseAuth.instance.signInWithCredential(
                    PhoneAuthProvider.credential(
                      verificationId: verificationCode!, smsCode: pin
                      )).then((value) => {

                        
                        if(value.user != null){ 
                           if(context.watch<Change>().count==0){
                            User().createUser(value.user!.uid, widget.name, "+63${widget.phone}"),
                           },
                           
                           Navigator.of(context).push(MaterialPageRoute(builder: (c)=> HomeScreen(
                            ID: value.user!.uid,
                           )))
                           //password and name needs to be passed on database
                        }
                      });
                }
                //TODO MANUAL INPUT INVALID OTP
                catch(e){
                  FocusScope.of(context).unfocus();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Invalid OPT"),
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              },


            ),
          )
        ],
      ),
    );
  }
}

//TODO CREATE USER IF SIGN UP
class User {
  Future<String> createUser(String uid, String name, String phone) async {
      try{
          await FirebaseFirestore.instance.collection('users').doc(uid).set({
              'Fullname' : name,
              'Phone' : phone
             });
      }catch(e){
        print(e);
      }
      return 'success';
  }
}