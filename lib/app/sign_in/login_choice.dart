//import 'package:calculator/app/sign_in/log_in/whole_login.dart';
// ignore_for_file: avoid_print, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/change_provider.dart';


//import 'log_in/whole_login.dart';

class LoginChoice extends StatelessWidget {
  const LoginChoice({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top:15,bottom: 30,),
      //height: ,
      //color: Colors.orange,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              context.watch<Change>().string3,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            GestureDetector(
              onTap: ()=> context.read<Change>().cchange(),
              child:Text(
                context.watch<Change>().string4,
                style: const TextStyle(
                  fontSize:16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0B6732),
                ),
              ),
            ), 

          ],
        ),
      );
  }
}