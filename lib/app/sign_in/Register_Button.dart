// ignore_for_file: file_names, import_of_legacy_library_into_null_safe, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/change_provider.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    Key? key,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey, super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 75,
      width: MediaQuery.of(context).size.width * 1,
      padding: const EdgeInsets.only(top:28),
      //color: Colors.pink,
      child: ElevatedButton(
        onPressed: (){
          if(!_formKey.currentState!.validate()){
            return;
          }
          else{
            print('okay');
          }
        },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          primary: const Color(0xFF27AE60),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: Text(
          context.watch<Change>().string2,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            fontSize: 20,
          ),
        ),
        ),
    );
  }
}