import 'dart:async';

import 'package:event_room/colors.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'event_affiche.dart';

class Caca extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      width: MediaQuery.of(context).size.width ,
      //color: Colors.red,
      child: StreamBuilder(stream: FirebaseFirestore.instance.collection('evenement').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final evenement = snapshot.data?.docs;
            return GridView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: evenement?.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 3/2.5,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
          ),
              itemBuilder: ((context, index) => Container(
                child: EventAffiche(evenement?[index]['flyer'], evenement?[index]['nom'], evenement?[index]['ville'], evenement?[index]['pays']),
                //Text(evenement?[index]['flyer']),
              )),
            );
          },
          
      ),
    );
  }
}