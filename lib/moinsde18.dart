
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:purgenie/client.dart';
import 'package:purgenie/constant.dart';
import 'package:purgenie/databasemodel.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MoinsDe18 extends StatefulWidget{

  MoinsDe18({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MoinsDe18State createState() => _MoinsDe18State();

}

class _MoinsDe18State extends State<MoinsDe18> {

  DatabaseModel _databaseModel;

  List<Client> clients;

  @override
  void initState(){
    super.initState();
    getClients();
  }

  void getClients(){
    _databaseModel = DatabaseModel();
    _databaseModel
        .clientDeMoinsDe18()
        .then((futclients) {
      if(futclients.length > 0){
        setState(() {
          clients = futclients;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(appName),
        leading: Container(),
      ),
      body: clients != null
          ? ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: clients.length,
          itemBuilder: (BuildContext context, int index) {
            return cardClient(size, clients[index]);
          }
      )
          : Center(
        child: Text(
          "Aucun client",
          style: TextStyle(
              fontSize: 35
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

  Widget cardClient(Size size,Client client){
    return Container(
      height: size.width*0.4,
      width: size.width,
      child: Card(
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
        ),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: size.width*0.05,
                ),
                Icon(
                    Icons.person,
                    color:
                    client.genre == listeGenre[0]
                        ? Colors.blue
                        : Colors.red
                    ,
                    size: 100
                ),
                SizedBox(
                  width: size.width*0.15,
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          "  ${client.nom} ${client.prenom}",
                          style: TextStyle(
                              fontSize: 28
                          ),
                        ),
                        SizedBox(
                          height: size.height*0.02,
                        ),
                        Text(
                          "  ${client.age} ans",
                          style: TextStyle(
                              fontSize: 25,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(
                          height: size.height*0.02,
                        ),
                        Text(
                          "  ${client.pays}",
                          style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }



}