import 'package:crud_app/firebase_options.dart';
import 'package:crud_app/pages/home.dart';
import 'package:crud_app/pages/log_in.dart';
import 'package:crud_app/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  runApp(MaterialApp(home: MyApp()));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Home();
  }
}
