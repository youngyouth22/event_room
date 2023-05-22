import 'package:event_room/providers/auth.dart';
import 'package:event_room/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

import 'package:uuid/uuid.dart';

class UserC with ChangeNotifier {
  String nom;
  String prenom;
  String email;
  String number;
  String sex;
  String pays;
  String ville;
  String dateNaissance;
  String photo;
  List<String>? eventOrganise;
  List<String>? eventParticipate;
  List<String>? followers;
  List<String>? followings;
  int point;
  UserCredential? authResult;


  UserC({required this.nom, required this.prenom, required this.email,required this.number, required this.sex, required this.pays, required this.ville, required this.dateNaissance, required this.photo, this.eventOrganise, this.eventParticipate, this.followers, this.followings,this.point = 0, this.authResult});
  
  final _firestore = FirebaseFirestore.instance.collection('users').doc(Auth.authResult?.user?.uid );

  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'number': number,
       'sex': sex,
      'pays': pays,
      'ville': ville,
      'dateNaissance': dateNaissance,
      'eventOrganise' : eventOrganise,
      'eventParticipate': eventParticipate,
      'photo': photo,
      'point': point,
      'followers': followers,
      'followings': followings
    };
    }
     
     void saveData(File profile) async {

  final uuid = Uuid();
  final timestamp = DateTime.now().millisecondsSinceEpoch;
  final fileName = '$timestamp-${uuid.v4()}';
  final profileUpload = FirebaseStorage.instance.ref().child('user_image_profile').child( '$fileName.jpg');
  await profileUpload.putFile(profile);

  final profileurl = await profileUpload.getDownloadURL();
    final user = UserC(nom: nom, prenom: prenom, email: email, number: number, sex: sex,pays: pays, ville: ville, dateNaissance: dateNaissance, eventOrganise: eventOrganise, eventParticipate: eventParticipate, photo: profileurl, followers: followers, followings: followings);
    await Auth.firestore.set(user.toJson());
     }

     // Suivre un utilisateur
Future<void> followUser(String userId) async {
  final currentUser = FirebaseAuth.instance.currentUser;
  final currentUserId = currentUser!.uid;

  if (currentUserId == userId) {
    print('Vous ne pouvez pas vous suivre vous-même.');
    return;
  }
  
  // Ajouter l'id de l'utilisateur suivi à la liste followers
  await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .update({'followers': FieldValue.arrayUnion([currentUserId])});
  
  // Ajouter l'id de l'utilisateur qui suit à la liste following
  await FirebaseFirestore.instance
      .collection('users')
      .doc(currentUserId)
      .update({'followings': FieldValue.arrayUnion([userId])});
}

// Ne plus suivre un utilisateur
Future<void> unfollowUser(String userId) async {
  final currentUser = FirebaseAuth.instance.currentUser;
  final currentUserId = currentUser!.uid;

  // Supprimer l'id de l'utilisateur suivi de la liste followers
  await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .update({'followers': FieldValue.arrayRemove([currentUserId])});

  // Supprimer l'id de l'utilisateur qui suit de la liste following
  await FirebaseFirestore.instance
      .collection('users')
      .doc(currentUserId)
      .update({'followings': FieldValue.arrayRemove([userId])});
}


factory UserC.fromSnapshot(DocumentSnapshot snapshot) {
    return UserC(nom: snapshot['nom'], 
    prenom: snapshot['prenom'], 
    email: snapshot['email'],
    number: snapshot['number'], 
    sex: snapshot['sex'], 
    pays: snapshot['pays'], 
    ville: snapshot['ville'],
    dateNaissance: snapshot['dateNaissance'], 
    photo: snapshot['photo']);
}

}