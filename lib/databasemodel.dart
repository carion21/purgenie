import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:purgenie/client.dart';

class DatabaseModel {

  Database _database;

  Future<Database> get database async {
    if(_database != null) {
      return _database;
    } else {
      //create();
      print("okeeeeeeeee ça passe");
      Directory directory = await getApplicationDocumentsDirectory();
      String databaseDirectory = join(directory.path, 'database.db');
      //print(database_directory);
      var bdd = await openDatabase(databaseDirectory, version: 1, onCreate: _onCreate);
      //print(bdd);
      return bdd;
    }
  }

  Future create() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String databaseDirectory = join(directory.path, 'database.db');
    print(databaseDirectory);
    var bdd = await openDatabase(databaseDirectory, version: 1, onCreate: _onCreate);
    print(bdd);
    return bdd;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE client (
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      nom varchar(255) NOT NULL,
      prenom varchar(255) NOT NULL,
      genre TEXT NOT NULL,
      age INTEGER NOT NULL,
      pays varchar(255) NOT NULL,
      createdAt datetime NOT NULL)
    ''');
  }

  Future<Client> addclient(Client Client) async {
    Database maDatabase = await database;
    Client.id = await maDatabase.insert('client', Client.toMap());
    return Client;
  }

  Future<int> delete(String table, String champ, String valeurChamp) async {
    Database maDatabase = await database;
    return await maDatabase.delete(table, where: '$champ = ?', whereArgs: [valeurChamp]);
  }

  Future<int> deleteAll(String table) async {
    Database maDatabase = await database;
    return await maDatabase.delete(table);
  }

  Future<List<Client>> searchclient(String champ, valeurChamp) async {
    Database maDatabase = await database;
    var sql = "SELECT * FROM client WHERE $champ = '$valeurChamp' ";

    List<Map<String, dynamic>> resultat = await maDatabase.rawQuery(sql);

    if(resultat.length != 0){
      List<Client> clients = [];
      resultat.forEach((map) {
        Client client = new Client();
        client.fromMap(map);
        clients.add(client);
      });
      return clients;
    } else {
      return null;
    }
  }

  Future<List<Client>> clientDeMoinsDe18() async {
    Database maDatabase = await database;
    var sql = "SELECT * FROM client WHERE age <= 18 ";

    List<Map<String, dynamic>> resultat = await maDatabase.rawQuery(sql);

    if(resultat.length != 0){
      List<Client> clients = [];
      resultat.forEach((map) {
        Client client = new Client();
        client.fromMap(map);
        clients.add(client);
      });
      return clients;
    } else {
      return null;
    }
  }

  Future<List<Client>> clientDePlusDe18() async {
    Database maDatabase = await database;
    var sql = "SELECT * FROM client WHERE age > 18 ";

    List<Map<String, dynamic>> resultat = await maDatabase.rawQuery(sql);

    if(resultat.length != 0){
      List<Client> clients = [];
      resultat.forEach((map) {
        Client client = new Client();
        client.fromMap(map);
        clients.add(client);
      });
      return clients;
    } else {
      return null;
    }
  }


  Future<List<Client>> allclient() async {
    Database maDatabase = await database;
    var sql = "SELECT * FROM client";
    List<Map<String, dynamic>> resultat = await maDatabase.rawQuery(sql);
    List<Client> clients = [];
    resultat.forEach((map) {
      Client client = new Client();
      client.fromMap(map);
      clients.add(client);
    });

    return clients;
  }

}