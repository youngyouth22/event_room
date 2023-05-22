import 'dart:async';

import 'package:event_room/colors.dart';
import 'package:event_room/providers/models/user.dart';
import 'package:event_room/widgets/home_widget/user_affiche.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'event_affiche.dart';

class UserFollow extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      width: MediaQuery.of(context).size.width ,
      //color: Colors.red,
      child: StreamBuilder(stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final users = snapshot.data?.docs;
            final currentUser = FirebaseAuth.instance.currentUser;
            final currentUserId = currentUser!.uid;

            return GridView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: users?.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 3/2.5,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
          ),
              itemBuilder: ((context, index) =>
                
                Container(
                child: GestureDetector(
                  //onTap: 
                  child: 
                  Column(
                    children: [
                      UserAffiche(users?[index]['photo'], users?[index]['nom'], users?[index]['prenom'], users![index].id, () {Provider.of<UserC>(context, listen: false).followUser(users[index].id);}),
          //           if (currentUserId !=  users![index].id) OutlinedButton(
          //   onPressed: () => Provider.of<UserC>(context, listen: false).followUser(users[index].id), 
          // child:  Text('Suivre')
          // ) else Column(
            
          //   children: const [
          //      SizedBox(height: 10,),
          //     Text('Vous', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),)]
          //   ),
                    ],
                  ),
                  ),
                //Text(users?[index]['flyer']),
          )
          ),
            );
          },
          
      ),
    );
  }
}