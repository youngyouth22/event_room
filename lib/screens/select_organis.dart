import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../providers/models/evenement.dart';
import '../widgets/select_user.dart';

class SelectStaff extends StatefulWidget {
  const SelectStaff({super.key});
  static const routeName = '/SelectStaff';

  @override
  State<SelectStaff> createState() => _SelectStaffState();
}

class _SelectStaffState extends State<SelectStaff> {

  FirebaseAuth? _auth;

 @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
  }
 
  @override
  Widget build(BuildContext context) {
    final User? user = _auth?.currentUser;
    final String userId = user!.uid;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
         iconTheme: const IconThemeData(
          color: Colors.black87,
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }

          , child: const Text('Ok',
          style: TextStyle(
            fontSize: 16,
          ),))
        ],
          title: const Text('Ajouter des organisateurs', style: TextStyle(
            color: Colors.black87, 

          ),),
          centerTitle: true,
          
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
            children: [
              Container(
                height: 150,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Column(
                  children:  [
                    const Text('Membres selectionnés', style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold
                    ),),

                     const SizedBox(height: 12,),

                    if (Provider.of<Evenement>(context, listen: false).nomPartenaires.isEmpty) 
                        Text('Aucun Membre(s) selectionné(s)') 
                    else 
                       SelectUser(),
                  ],
                ),
                ////////////////////////////////////////////////////////////////////////////////
              ),

              const SizedBox(height: 30,),
      
      
              Expanded(
                child: StreamBuilder<DocumentSnapshot>(
    stream: FirebaseFirestore.instance.collection('users').doc(userId).snapshots(),
    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      Map<String, dynamic>? userData = snapshot.data?.data() as Map<String, dynamic>;
      List<dynamic> followings = userData['followings'] ?? [];
      
      return followings.isEmpty
          ? const Center(child: Text('Aucun utilisateur suivi'))
          : NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overScroll) {
                  overScroll.disallowIndicator();
                  return true;
                },
            child: ListView.builder(
                itemCount: followings.length,
                itemBuilder: (BuildContext context, int index) {
                  return StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance.collection('users').doc(followings[index]).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      Map<String, dynamic>? followedUserData = snapshot.data?.data() as Map<String, dynamic>;
                      String documentId = snapshot.data!.id;
                      return ListTile(
                        onTap: () {
                          if (!Provider.of<Evenement>(context, listen: false).nomPartenaires.contains(documentId))
                           {
                            
                              Provider.of<Evenement>(context, listen: false).addUser(documentId);
                            
                           } 
                           print(Provider.of<Evenement>(context, listen: false).nomPartenaires);
                        },
                                contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                title: Text('${followedUserData['nom']} ${followedUserData['prenom']}', style: const TextStyle(fontWeight: FontWeight.bold),),
                                subtitle: Text('0 évènement'),
                                leading: CircleAvatar(
                                         radius: 28,
                                         backgroundColor: Colors.grey[300],
                                         backgroundImage: NetworkImage(followedUserData['photo']),
                                         ),
                            );
                    },
                  );
                },
              ),
          );
    },
  ),

              )
            ],
          ),
      ),
    );
  }
}