import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class ListeBillets extends StatelessWidget {
  static const routeName = '/Listebillets';

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
    child: const Icon(FeatherIcons.plus),
    onPressed: () {Navigator.of(context).pushNamed('/AddBillet', arguments: routeArgs);}),
      appBar: AppBar(
        title: const Text("Gerer les billets"),
        elevation: 0,
        iconTheme: const IconThemeData(
            color: Colors.black87,
          ),
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(
          color: Colors.black87,
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),
      ),

      body: FutureBuilder<QuerySnapshot>(
  future: FirebaseFirestore.instance
      .collection('evenement')
      .doc(routeArgs)
      .collection('ticket')
      .get(),
  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        // Erreur de chargement de la sous-collection
        return Text('Erreur de chargement de la sous-collection');
      }

      if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
        // Sous-collection vide ou inexistante
        return Center(child: Text('Aucun billet pour cet événement'));
      }

      // Afficher la liste des billets
      return ListView.builder(
        itemCount: snapshot.data!.docs.length,
        itemBuilder: (BuildContext context, int index) {
          // Afficher les informations du billet
          DocumentSnapshot billet = snapshot.data!.docs[index];
          return ListTile(
            title: Text(billet['nom']),
            subtitle: Text(billet['quantiter']),
            trailing: Text('${billet['prix']} €'),
          );
        },
      );
    } else {
      // En cours de chargement de la sous-collection
      return Center(child: CircularProgressIndicator());
    }
  },
),

    );
  }
}