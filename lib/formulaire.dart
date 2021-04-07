
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:purgenie/client.dart';
import 'package:purgenie/constant.dart';
import 'package:purgenie/databasemodel.dart';
import 'package:purgenie/listeclient.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Formulaire extends StatefulWidget{

  Formulaire({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FormulaireState createState() => _FormulaireState();

}

class _FormulaireState extends State<Formulaire> {

  TextEditingController _nom;
  TextEditingController _prenom;
  TextEditingController _age;

  String dropdownValueOfGender = listeGenre[0];
  String dropdownValueOfCountry = listePays[0];

  DatabaseModel _databaseModel;

  @override
  void initState(){
    super.initState();
    _nom = TextEditingController();
    _prenom = TextEditingController();
    _age = TextEditingController();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
            child: Container(
              height: size.height*0.7,
              child: Card(
                elevation: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Container(
                      width: size.width*0.8,
                      child: input("Nom", Icons.person, TextInputType.text, _nom),
                    ),
                    Container(
                      width: size.width*0.8,
                      child: input("Prenom", Icons.person, TextInputType.text, _prenom),
                    ),
                    Container(
                      width: size.width*0.8,
                      child: input("Age", Icons.person, TextInputType.number, _age),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: size.width*0.04,
                        ),
                        Text("Genre"),
                        SizedBox(
                          width: size.width*0.16,
                        ),
                        Container(
                          width: size.width*0.45,
                          child: DropdownButton<String>(
                            value: dropdownValueOfGender,
                            icon: const Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            underline: Container(
                              height: 2,
                              color: Colors.grey,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValueOfGender = newValue;
                              });
                            },
                            items: listeGenre
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: size.width*0.04,
                        ),
                        Text("Pays"),
                        SizedBox(
                          width: size.width*0.16,
                        ),
                        Container(
                          width: size.width*0.45,
                          child: DropdownButton<String>(
                            value: dropdownValueOfCountry,
                            icon: const Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            underline: Container(
                              height: 2,
                              color: Colors.grey,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValueOfCountry = newValue;
                              });
                            },
                            items: listePays
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 50.0,
                    ),
                    Container(
                      width: size.width*0.5,
                      child: RaisedButton(
                        child: Text("Enregistrer"),
                        onPressed: () {
                          traitement(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        tooltip: 'Retour',
        child: Icon(Icons.arrow_back),
      ),
    );
  }

  TextField input(String label, IconData iconData, TextInputType textInputType, TextEditingController editingController) {
    return TextField(
      decoration: InputDecoration(
        icon: Icon(iconData),
        labelText: label,
      ),
      keyboardType: textInputType,
      controller: editingController,
    );
  }

  void traitement(BuildContext context){
    if(_nom.text != "" && _prenom.text != "" && _age.text != ""){
      String nom = _nom.text;
      String prenom = _prenom.text;
      int age = int.parse(_age.text);
      String genre = dropdownValueOfGender;
      String pays = dropdownValueOfCountry;

      Client nouveauClient = Client();

      nouveauClient.nom = nom;
      nouveauClient.prenom = prenom;
      nouveauClient.age = age;
      nouveauClient.genre = genre;
      nouveauClient.pays = pays;
      nouveauClient.createdAt = DateTime.now().toString();

      _databaseModel = DatabaseModel();

      _databaseModel
          .addclient(nouveauClient)
          .then((value) => {
          _openPopupSuccess(context)
      });

    } else {
      String message = "Champs Obligatoires";
      _openPopupDanger(context, message);
    }
  }

  Widget select(context, String label, String dropdownValue,List<String> liste){
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.person,
          color: Colors.grey,
        ),
        SizedBox(
          width: size.width*0.04,
        ),
        Text(label),
        SizedBox(
          width: size.width*0.16,
        ),
        Container(
          width: size.width*0.45,
          child: DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            underline: Container(
              height: 2,
              color: Colors.grey,
            ),
            onChanged: (String newValue) {
              setState(() {
                dropdownValue = newValue;
              });
            },
            items: liste
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  _openPopupSuccess(context) {
    Size size = MediaQuery.of(context).size;
    Alert(
        context: context,
        title: "Confirmation",
        content: Column(
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  Container(
                    height: size.width*0.5,
                    width: size.width*0.5,
                    child: Icon(
                      Icons.sentiment_very_satisfied,
                      color: Colors.green,
                      size: 100.0,
                    ),
                  ),
                  Container(
                    width: size.width*0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Enregistrement effectué...")
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              Navigator.pop(context);
              initialiserFormulaire();
            },
            child: Text(
              "Consulter",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            color: Colors.green,
          )
        ]).show();
  }

  _openPopupDanger(context, String message) {
    Size size = MediaQuery.of(context).size;
    Alert(
        context: context,
        title: "Erreur",
        content: Column(
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  Container(
                    height: size.width*0.5,
                    width: size.width*0.5,
                    child: Icon(
                      Icons.sentiment_very_dissatisfied,
                      color: Colors.red,
                      size: 100.0,
                    ),
                  ),
                  Container(
                    width: size.width*0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("$message...")
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "J'ai compris",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            color: Colors.red,
          )
        ]).show();
  }

  void initialiserFormulaire(){
    setState(() {
      _nom.text = "";
      _prenom.text = "";
      _age.text = "";
      dropdownValueOfGender = listeGenre[0];
      dropdownValueOfCountry = listePays[0];
    });
  }

}