import 'package:flutter/material.dart';
import 'package:purgenie/accueil.dart';
import 'package:purgenie/formulaire.dart';
import 'package:purgenie/constant.dart';
import 'package:purgenie/welcome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: Welcome(),
    );
  }
}

