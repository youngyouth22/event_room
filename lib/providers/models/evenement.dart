import 'dart:async';
import 'dart:io';
import 'package:event_room/providers/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Evenement with ChangeNotifier{
   String nom;
   String categorie;
   List<String> tags;
   List<String> photos; // max 5
   String flyer;
   String description;
   String pays;
   String ville;
   String createur;// id de l'utilisateur
   List<String> nomPartenaires;
   Map<String, dynamic> prix;
   Map<String, Map<String,dynamic>> heures;
   String date;
   int nbrePlace;
   DateTime datePublication;
   double minAge;
   String sexRestrict;
   String confidential;
   String form;
   int nbreLike;
  bool estPasse;
  //bool estAime;
  int nbreStars;
  bool? isminAge;
  bool isPlaceIllimite;
  bool isonline;
  bool isPresent;
  bool isDateUnique;

   Evenement({
    required this.nom,
    required this.categorie,
    required this.photos,
    required this.flyer,
    required this.tags,
    required this.description,
    required this.pays,
    required this.ville,
    required this.createur,
    required this.nomPartenaires,
    required this.prix,
    required this.heures,
    required this.date,
    required this.nbrePlace,
    required this.datePublication,
    required this.confidential,
    required this.form,
    this.nbreLike = 0,
    required this.sexRestrict,
    required this.minAge,
    required this.isPlaceIllimite,
    required this.isPresent,
    required this.isonline,
    //this.estAime = false,
    this.estPasse = false,
    this.nbreStars = 0,
    this.isminAge = false,
    required this.isDateUnique,
   });

  //   void toggleEstAimeStatut(){
  //   estAime = ! estAime;
  //   notifyListeners();
  // }

final _firestore = FirebaseFirestore.instance.collection('evenement');

 Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'categorie': categorie,
      'photos': photos,
      'flyer': flyer,
      'tags': tags,
      'description': description,
      'pays': pays,
      'ville': ville,
      'createur': createur,
      'nomPartenaires': nomPartenaires,
      'prix': prix,
      'heures': heures,
      'date': date,
      'nbrePlace': nbrePlace,
      'datePublication': datePublication,
      'confidential': confidential,
      'form': form,
      'nbreLike': nbreLike,
      'sexRestrict': sexRestrict,
      'isminAge': isminAge,
      'minAge': minAge,
      'isPlaceIllimite': isPlaceIllimite,
      'isPresent': isPresent,
      'isonline': isonline,
      //'estAime': estAime,
      'estPasse': estPasse,
      'nbreStars': nbreStars,
      'isDateUnique': isDateUnique,
      
    };
  }

  

Future <void> saveData(File flyer22, String userId, List<String>idStaff) async {
  final uuid = Uuid();
  final timestamp = DateTime.now().millisecondsSinceEpoch;
  final fileName = '$timestamp-${uuid.v4()}';
  final flyerUpload = FirebaseStorage.instance.ref().child('flyer_evenement').child( '$fileName.jpg');
  await flyerUpload.putFile(flyer22);

  final flyerurl = await flyerUpload.getDownloadURL();

  final evenement = Evenement(nom: nom, categorie: categorie, photos: photos, flyer: flyerurl, description: description, pays: pays, ville: ville, createur: createur, nomPartenaires: nomPartenaires, prix: prix, heures: heures, date: date, nbrePlace: nbrePlace, datePublication: datePublication, confidential: confidential, form: form, sexRestrict: sexRestrict, minAge: minAge, isPlaceIllimite: isPlaceIllimite, isPresent: isPresent, isonline: isonline, isDateUnique: isDateUnique, isminAge: isminAge, tags: tags,);
  final eventRef = await _firestore.add(evenement.toJson());

  String eventId = eventRef.id;

  FirebaseFirestore.instance.collection('users').doc(userId).update({
  'eventOrganise': FieldValue.arrayUnion([eventId]),
});

for (String idStaff in idStaff){
    FirebaseFirestore.instance.collection('users').doc(idStaff).update({
  'eventParticipate': FieldValue.arrayUnion([eventId]),
}).then((_) {
    print('L\'ID de l\'événement a été ajouté au champ "participant" du document utilisateur $idStaff.');
  }).catchError((error) {
    print('Une erreur s\'est produite lors de la mise à jour du champ "participant" du document utilisateur $idStaff : $error');
  });
}

}

void likeEvent(DocumentReference eventRef, DocumentReference likeRef, String userId, String eventId) async {
  // Vérifier si l'utilisateur a déjà aimé l'événement
DocumentSnapshot likeSnapshot = await likeRef.get();
if (likeSnapshot.exists) {
  // L'utilisateur a déjà aimé l'événement, donc supprimer le document "like"
  await likeRef.delete();
  // Mettre à jour le nombre de likes de l'événement dans la collection "events"
  await eventRef.update({'nbreLike': FieldValue.increment(-1)});
} else {
  // L'utilisateur n'a pas encore aimé l'événement, donc ajouter le document "like"
  await likeRef.set({
    'userId': userId,
    'eventId': eventId,
  });
  // Mettre à jour le nombre de likes de l'événement dans la collection "events"
  await eventRef.update({'nbreLike': FieldValue.increment(1)});
}

}

StreamController<List<String>> _controller = StreamController<List<String>>.broadcast();

List<String> get nomPartenaires2 => nomPartenaires;

void addUser(String userId) {
    if (!nomPartenaires.contains(userId)) {
      nomPartenaires.add(userId);
      notifyListeners();
    }
  }

  void removeUser(String userId) {
    nomPartenaires.remove(userId);
    _controller.add(nomPartenaires);
    notifyListeners();
  }

  Stream<List<UserC>> getUserStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .where(FieldPath.documentId, whereIn: nomPartenaires)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => UserC.fromSnapshot(doc)).toList());
  }
} 