import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Dates with ChangeNotifier {
   Map debut;
   Map fin;

   Dates(
     {required this.debut,
     required this.fin,}
   );

  void addDate(String evenementId) async{
var eventRef = FirebaseFirestore.instance.collection('evenement').doc(evenementId);

// Ajouter une nouvelle date à la sous-collection "dates"
eventRef.collection('dates').add({
    "debut": debut,
    "fin": fin,
}).then((docRef) {
    // La date a été ajoutée avec succès
    print("La date a été ajoutée avec succès avec l'ID : ${docRef.id}");
}).catchError((error) {
    // Une erreur s'est produite lors de l'ajout de la date
    print("Une erreur s'est produite lors de l'ajout de la date : ${error.toString()}");
});

var datesRef = eventRef.collection('dates');

// Récupérer tous les documents de la sous-collection "dates"
datesRef.get().then((querySnapshot) {
    querySnapshot.docs.forEach((doc) {
        // Afficher les données du document
        print(doc.data());
    });
}).catchError((error) {
    // Une erreur s'est produite lors de la récupération des documents de la sous-collection "dates"
    print("Une erreur s'est produite lors de la récupération des documents de la sous-collection 'dates' : ${error.toString()}");
});







  }

}