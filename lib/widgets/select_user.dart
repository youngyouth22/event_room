import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../providers/models/evenement.dart';


class SelectUser extends StatelessWidget {
  const SelectUser({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> userIds = [];
    final eventProvider = Provider.of<Evenement>(context);
    userIds = eventProvider.nomPartenaires2;
    return Expanded(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').where(FieldPath.documentId, whereIn: userIds).snapshots(),
          
        builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final documents = snapshot.data;
          //String documentId = snapshot.data!.index;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 3/2.5,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
          ),
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final userData = snapshot.data!.docs[index].data() as Map;
            final userId = snapshot.data!.docs[index].id;
              return Column(
                children : [
                 Stack(
                   children: [
                     CircleAvatar(
                                             radius: 28,
                                             backgroundColor: Colors.grey[300],
                                             backgroundImage: NetworkImage(userData['photo']),
                                             ),

                    Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => Provider.of<Evenement>(context, listen: false).removeUser(userId),
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: const Icon(FeatherIcons.x,
                        color: Colors.grey,
                         size: 14),
                      ),
                    )
                    ),
                   ],
                 ),
                const SizedBox(height: 8,),
                 Text(userData['nom']),]
                // autres informations de l'utilisateur
              );
            },
          );
        }
        },
      
      ),
    );

  }
}