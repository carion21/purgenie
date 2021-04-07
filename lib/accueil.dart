import 'package:flutter/material.dart';
import 'package:purgenie/constant.dart';
import 'package:purgenie/formulaire.dart';
import 'package:purgenie/listeclient.dart';

class Accueil extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AccueilState();
  }
}

class _AccueilState extends State<Accueil> {

  int _currentIndex = 0;

  final List<Widget> _children = [
    Formulaire(),
    ListeClient()
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appName),
        leading: Container(),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.person_add),
            label: 'Nouveau Client',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.group),
            label: 'Liste Client',
          ),
        ],
      ),
    );
  }
}