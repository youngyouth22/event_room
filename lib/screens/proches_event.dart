import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_room/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import '../widgets/proche_affiche.dart';

class ProcheEvent extends StatelessWidget {
  const ProcheEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proche de vous'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(
        color: Colors.black.withOpacity(0.7),
        fontSize: 24,
        fontWeight: FontWeight.bold
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:  8.0),
            child: IconButton(onPressed: () => print('open map'), icon: Icon(FluentSystemIcons.ic_fluent_map_filled,
            color: Colors.black.withOpacity(0.7),
            size: 24 ,)),
          )
        ],
      ),
      body: StreamBuilder(stream: FirebaseFirestore.instance.collection('evenement').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            
            final evenement = snapshot.data?.docs;
            return ListView.builder(
              itemCount: evenement?.length,
            itemBuilder: ((context, index)  {
              final evenement2 = evenement?[index];
        final dates = evenement2?['heures'] as Map<String, dynamic>;
              return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
              child: Container(
                child: ProcheAffiche(image: evenement?[index]['flyer'],nom: evenement?[index]['nom'], ville: evenement?[index]['ville'], pays: evenement?[index]['pays'], categorie: evenement?[index]['categorie']),
                //Text(evenement?[index]['flyer']),
              ),
            );}
            
            ),
            );

          }
    )
    );
  }
}