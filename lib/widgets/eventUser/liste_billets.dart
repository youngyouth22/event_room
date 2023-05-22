import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class ListeBillets extends StatelessWidget {
  static const routeName = '/Listebillets';
   final _formKey = GlobalKey<FormState>();
  TextEditingController nomController= TextEditingController();
  TextEditingController quantite= TextEditingController();
   void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => buildsheet(),
    );
  }

  Widget makeDismissible({required Widget child}) => Builder(
    builder: (context) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(onTap: () {}, child: child,),
      );
    }
  );

  Widget buildsheet () => makeDismissible(
    child: DraggableScrollableSheet(
      initialChildSize: 0.9,
      maxChildSize: 0.9,
        builder: (_, controller) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))
          ),
          child: ListView(
            controller: controller,
            children: [
              Center(child: 
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Ajouter un billet',style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.8)
                  ),
                ),
              ),),
              
              const SizedBox(height: 8,),

             Form(
            key: _formKey,
            child: Column(
            children: [
     
      const SizedBox(height: 15,),
          
            TextFormField(
            controller: nomController,
             keyboardType: TextInputType.name,
             decoration: const InputDecoration(
              hintText: "Entrer votre nom",
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 18
                ),
              label: Text('nom du billet'), 
               
             ),
             validator: (value){
                        if(value ==null || value.isEmpty){
                          return 'Veuillez entrez le nom de votre évènement';
                        }
                        return null;
                      },
             
            ),

            const SizedBox(height: 15,),

            TextFormField(
            controller: quantite,
             keyboardType: TextInputType.number,
             decoration: const InputDecoration(
              hintText: "0",
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 18
                ),
              label: Text('Quantité'), 
               
             ),
             validator: (value){
                        if(value ==null || value.isEmpty){
                          return 'Veuillez entrez le nom de votre évènement';
                        }
                        return null;
                      },
             
            ),
            ],
            
          )),

            ],
          ),
        )
    ),
  );


  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
    child: const Icon(FeatherIcons.plus),
    onPressed: () {_showBottomSheet(context);}),
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