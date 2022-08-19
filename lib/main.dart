// ignore_for_file: use_key_in_widget_constructors, import_of_legacy_library_into_null_safe
// @dart=2.9

import 'package:calculator/app/sign_in/sign_in_page.dart';
import 'package:calculator/providers/change_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Change())
      ],
      child: Myapp(),
    ),
  );
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return MaterialApp(
      title: 'Scrapcycle',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Inter-Thin', 
      ),
      home: SignInPage(), 
    );
  }
}
