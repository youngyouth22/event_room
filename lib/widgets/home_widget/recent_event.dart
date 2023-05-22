import 'dart:async';

import 'package:event_room/colors.dart';
import 'package:event_room/widgets/home_widget/recent_affiche.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecentEvent extends StatelessWidget {
  const RecentEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
       
      //color: Colors.red,
      child: StreamBuilder(stream: FirebaseFirestore.instance.collection('evenement').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final evenement = snapshot.data?.docs;
            return ListView.builder(
              itemCount: evenement?.length,
             shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              itemBuilder: ((context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                child: Container(
                  child: RecentAffiche(image: evenement?[index]['flyer'],nom: evenement?[index]['nom'], ville: evenement?[index]['ville'], pays: evenement?[index]['pays'], categorie: evenement?[index]['categorie']),
                  //Text(evenement?[index]['flyer']),
                ),
              )),
            );
          },
          
      ),
    );
  }
}