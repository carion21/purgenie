
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:purgenie/client.dart';
import 'package:purgenie/constant.dart';
import 'package:purgenie/databasemodel.dart';
import 'package:purgenie/listeselonpays.dart';
import 'package:purgenie/moinsde18.dart';
import 'package:purgenie/plusde18.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ListeClient extends StatefulWidget{

  ListeClient({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ListeClientState createState() => _ListeClientState();

}

class _ListeClientState extends State<ListeClient> {

  DatabaseModel _databaseModel;

  @override
  void initState(){
    super.initState();
  }

  String dropdownValueOfCountry = listePays.first;



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
          child: Container(
            height: size.width*0.8,
            width: size.width*0.8,
            child: Column(
              children: [
                RaisedButton(
                  child: Text(
                    "Clients de moins de 18ans"
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => new MoinsDe18()
                        )
                    );
                  },
                ),
                RaisedButton(
                  child: Text(
                      "Clients de plus de 18ans"
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => new PlusDe18()
                        )
                    );
                  },
                ),
                Row(
                    children: <Widget>[
                      Expanded(
                          child: Divider(
                            color: Colors.grey,
                            height: 100,
                          )
                      )
                    ]
                ),

                SizedBox(
                  //height: size.width*0.1,
                ),

                Container(
                  width: size.width*0.8,
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
                      print(dropdownValueOfCountry);
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

                Container(
                  width: size.width*0.5,
                  child: RaisedButton(
                    child: Text("Rechercher"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) => new ListeSelonPays(pays: dropdownValueOfCountry,)
                          )
                      );
                    },
                  ),
                )

              ],
            ),
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


}