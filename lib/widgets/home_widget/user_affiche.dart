import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserAffiche extends StatelessWidget {
  final String image;
  final String nom;
  final String prenom;
  final String idUser;
  final VoidCallback? follow;

  UserAffiche(@required this.image, @required this.nom, @required this.prenom, @required this.idUser, @required this.follow);

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final currentUserId = currentUser!.uid;
    return Container(
      height: 200,
      width: 180,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
        spreadRadius: 1,
        blurRadius: 10,
        offset: Offset(0, 3),
        )
      ]),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey[300],
            backgroundImage: NetworkImage(image),
          ),

          const SizedBox(height: 18,),

          Container(
            child: Text('${nom} ${prenom}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black.withOpacity(0.7)
            ),),
          ),

          const SizedBox(height: 8,),
           
           if (currentUserId !=  idUser) OutlinedButton(
            onPressed: ()  {
               follow!.call();
              }, 
          child:  Text('Suivre', 
          style: TextStyle(
            color: Colors.grey,
          ),)
          ) else Column(
            
            children: const [
               SizedBox(height: 10,),
              Text('Vous', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black54),)]
            ),
          
        ],
      ),
    );
  }
}