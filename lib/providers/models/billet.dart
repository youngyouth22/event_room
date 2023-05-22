import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Billet with ChangeNotifier {

  String idEvenement;
  String idUser;
  String jour;
  Map heure;
  String lieux;
  String typeEvent;
  String img;
  double prix;
  int quantite;
  bool isValide;

  Billet({
    required this.idEvenement,
    required this.idUser,
    required this.jour,
    required this.heure,
    required this.lieux,
    required this.typeEvent,
    required this.img,
    required this.prix,
    required this.quantite,
    required this.isValide
  });

  // Ajouter un billet à la sous-collection "billets" d'un événement
void ajouterBillet(String idEvent) async {
  DocumentReference evenementRef = FirebaseFirestore.instance.collection('evenements').doc(idEvent);
  await evenementRef.collection('billet').add({
    'idEvenement': idEvenement,
    'idUser': idUser,
    'jour': jour,
    'heure': heure,
    'lieux' : lieux,
    'typeEvent': typeEvent,
    'img': img,
    'prix': prix,
    'isValide': isValide,
  });
}


}