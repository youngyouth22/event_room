import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class Participe extends StatelessWidget {
  const Participe({super.key});

   @override
  Widget build(BuildContext context) {
  final currentUser = FirebaseAuth.instance.currentUser;
  final currentUserId = currentUser!.uid;
    return FutureBuilder<DocumentSnapshot>(
  future: FirebaseFirestore.instance.collection('users').doc(currentUserId).get(),
  builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasData && snapshot.data!.exists) {
        List<dynamic> listEvent = snapshot.data!.get('eventParticipate');
        if (listEvent.isEmpty) {
          return const Center(child: Text('Vous ne participez á aucun événement'));
        }
        return ListView.builder(
          itemCount: listEvent.length,
          itemBuilder: (BuildContext context, int index) {
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance.collection('evenement').doc(listEvent[index]).get(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData && snapshot.data!.exists) {
                    Map<String, dynamic>? event = snapshot.data!.data() as Map<String, dynamic>?;
                    return ListTile(
                      title: Text(event!['nom'],
                      style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),),
                      subtitle: Text('3256 Vues'),
                      trailing: const Icon(FeatherIcons.chevronRight),
                      leading: Container(
                        height: 60,
                        width: 60,
                        child: FastCachedImage(url:event['flyer'],
                        fadeInDuration: const Duration(seconds: 1),
                      fit: BoxFit.cover),
                      ),
                      // autres champs à afficher
                    );
                  } else {
                    return Text('L\'événement n\'existe plus');
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            );
          },
        );
      } else {
        return Text('L\'utilisateur n\'existe pas');
      }
    } else {
      return Center(child: CircularProgressIndicator());
    }
  },
);

    
  }
}