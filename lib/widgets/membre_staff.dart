import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/models/user.dart';


class MembreStaff extends StatelessWidget {
  final String eventId;

  MembreStaff(@required this.eventId);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
        .collection('evenement')
        .doc(eventId)
        .snapshots(),
      builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      final data = snapshot.data!.data();
      if (data == null) {
        return const Text('No data found');
      }
      final partenaires = data['nomPartenaires'] as List<dynamic>;
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: partenaires.length,
        itemBuilder: (BuildContext context, int index) {
          final userId = partenaires[index] as String;
          return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(userId)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
              if (!snapshot.hasData) {
                return Container();
              }
              final data = snapshot.data!.data();
              if (data == null) {
                return Container();
              }
              final photo = data['photo'] as String;
              final nom = data['nom'] as String;
              final prenom = data['prenom'] as String;
              return //Text('$nom $prenom');
              Container(
                padding: EdgeInsets.only(right: 8),
                child: Column(
                  children: [
                    const SizedBox(height: 14,),
                      CircleAvatar(
                                               radius: 28,
                                               backgroundColor: Colors.grey[300],
                                               backgroundImage: NetworkImage(photo),
                                               ),
                    
                    const SizedBox(height: 6,),
              
                     Text('$nom ', style: TextStyle(color: Colors.black.withOpacity(0.7),fontWeight: FontWeight.bold),), 
              
                  ],
                ),
              );
            },
          );
        },
      );
      },
    ),
    );

  }
}