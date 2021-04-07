class Client {

  int id;
  String nom;
  String prenom;
  String genre;
  int age;
  String pays;
  String createdAt;

  Client();

  void fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.nom = map['nom'];
    this.prenom = map['prenom'];
    this.genre = map['genre'];
    this.age = map['age'];
    this.pays = map['pays'];
    this.createdAt = map['createdAt'].toString();
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'nom': this.nom,
      'prenom': this.prenom,
      'genre': this.genre,
      'age': this.age,
      'pays': this.pays,
      'createdAt': this.createdAt,
    };
    if(id != null) {
      map['id'] = this.id;
    }
    return map;
  }
}