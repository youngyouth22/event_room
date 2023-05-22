import 'package:event_room/colors.dart';
import 'package:event_room/widgets/home_widget/popular_event.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:readmore/readmore.dart';
import 'package:rive/rive.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/models/evenement.dart';
import '../widgets/home_widget/diff_dates.dart';
import '../widgets/membre_staff.dart';

class EventInfos extends StatefulWidget {
  const EventInfos({super.key});
  static const routeName = '/Infos';

  @override
  State<EventInfos> createState() => _EventInfosState();
}

class _EventInfosState extends State<EventInfos> {

  FirebaseAuth? _auth;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
  }


StateMachineController getRiveController (Artboard artboard) {
  StateMachineController? controller = StateMachineController.fromArtboard(artboard, "State Machine 1");
  artboard.addController(controller!);
  return controller;
}

SMIBool? likepress;

  @override
  Widget build(BuildContext context) {
    final User? user = _auth?.currentUser;
    final String userId = user!.uid;
    final routeArgs = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Détails de l\'événement'),
      // ),
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('evenement')
            .doc(routeArgs)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Erreur: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('Chargement...'));
          }

          Map<String, dynamic> heures = snapshot.data!.get('heures')['Depart'];
          DateTime date = DateTime.parse(heures['date']);
          DateTime heure = DateTime.parse(heures['heure']);

          Map<String, dynamic> heuresfin = snapshot.data!.get('heures')['fin'];
          DateTime datefin = DateTime.parse(heuresfin['date']);
          DateTime heurefin = DateTime.parse(heuresfin['heure']);

          final data = snapshot.data!.data() as Map<String, dynamic>;
          final creatorId = data['createur'];
          List<dynamic> tagList = data['tags'];

          return StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(creatorId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            }
            final creator = snapshot.data!.data() as Map<String, dynamic>;
            
          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          child: Container(
                            width: double.infinity,
                            height: 400,
                            child: FastCachedImage(url: data['flyer'],
                        fadeInDuration: const Duration(seconds: 1),
                        fit: BoxFit.cover),
                          ),
                        ),

                       
                        
                      ],
                    ),
                    // Text(data['nom']),
                    // Text(data['description']),
                    // Text(data['categorie']),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      child: Column(
                        children: [

                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                    title: Text(data['nom'],
                           style: const TextStyle(fontSize: 24,
                                      fontWeight: FontWeight.bold
                                       ),),
                    subtitle: Text(data['categorie'], style: const TextStyle(
                                                     color: Color.fromARGB(221, 34, 33, 33),
                                                     fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                     overflow: TextOverflow.ellipsis
                                                  ),),
                    trailing: 
                    GestureDetector(
                      onTap: () {
                        likepress?.change(true);
                        // Future.delayed(Duration(seconds: 1), (){
                        //   likepress?.change(false);
                        // });

                      Provider.of<Evenement>(context, listen: false).likeEvent(
                        FirebaseFirestore.instance.collection('evenement').doc(routeArgs), 
                        FirebaseFirestore.instance.collection('likes').doc('${userId}_$routeArgs'), 
                        userId, 
                        routeArgs);
                      },
                      child: SizedBox(
                                 height: 40,
                                   width: 40,
                                   child: RiveAnimation.asset('assets/animations/heart.riv',
                                   artboard: "Like.svg",
                                   onInit: (artboard){
                                   StateMachineController controller = getRiveController(artboard);
                                   likepress = controller.findSMI("Like") as SMIBool;
                                  },
                                    ),
                              ),
                    ), 
                  ),

                  ListTile(
                    leading:  CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        radius: 25,
                        backgroundImage: NetworkImage(creator['photo']),
                      ),
                    title: Text("${creator['nom']} ${creator['prenom']}", 
                    style: const TextStyle(
                      fontWeight: FontWeight.bold
                    ),),
                    subtitle: const Text('Organisateur'),
                    trailing: OutlinedButton(onPressed: null, child: Text('Suivre')),
                  ),

                  /////////////////////////////////////////////////////////////////////////////////////
                  
                  if(data['isDateUnique'] == false)
                 Container(
                  width: double.infinity,
                  height: 140,
                   child: DiffDates(routeArgs),
                   ),

                  const SizedBox(height: 10,),
                  Container(
                    width: double.infinity,
                    child: Row(
                    children: [
                      Icon(FluentSystemIcons.ic_fluent_location_regular, color: ColorApp.secondaryColor.withOpacity(0.6), size: 24,),
                      const SizedBox(width: 6,),
                      Text('${data['pays']}, ${data['ville']}',style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.6)),),
                    ],
                  ),),

                  if(data['isDateUnique'])
                  Column(
                    children: [
                     const SizedBox(height: 5,),

                  Container(
                    width: double.infinity,
                    child: Row(
                    children: [
                      Icon(FluentSystemIcons.ic_fluent_calendar_month_regular, color: ColorApp.secondaryColor.withOpacity(0.6), size: 24,),
                      const SizedBox(width: 6,),
                      Text('${DateFormat('dd MMMM yyyy').format(date)} au ${DateFormat('dd MMMM yyyy').format(datefin)}',style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.6)),),
                    ],
                  ),),

                  const SizedBox(height: 5,),

                  Container(
                    width: double.infinity,
                    child: Row(
                    children: [
                      Icon(FluentSystemIcons.ic_fluent_clock_regular   , color: ColorApp.secondaryColor.withOpacity(0.6), size: 24,),
                      const SizedBox(width: 6,),
                      Text('${DateFormat('HH:mm').format(heure)} - ${DateFormat('HH:mm').format(heurefin)}',style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.6)),),
                    ],
                  ),),

                    ],
                  ),
                   
                  const SizedBox(height: 15,),
Container(
  width: double.infinity,
  child:   Wrap(
  
    spacing: 8.0, // Espace entre les chips
  
    crossAxisAlignment: WrapCrossAlignment.start,
  
    children: List<Widget>.generate(tagList.length, (int index) {
  
      return Chip(
        labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(221, 34, 33, 33),

        ),
        label: Text('#${tagList[index]}'),
  
        backgroundColor: Colors.grey[300],
  
      );
  
    }),),
),

Container(
  width: double.infinity,
  child: const Text('Description',
  style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  ),),
),

const SizedBox(height: 6,),

ReadMoreText(
  data['description'],
  trimLines: 4,
  colorClickableText: Colors.pink,
  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, height: 1.2, color: Colors.black.withOpacity(0.7)),
  trimMode: TrimMode.Line,
  trimCollapsedText: 'Voir plus',
  trimExpandedText: 'Voir moins',
  lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: ColorApp.secondaryColor),
  moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: ColorApp.secondaryColor),
),


const SizedBox(height: 30,),


if(data['nomPartenaires'].isNotEmpty) Column(
  children: [

    Container(
  width: double.infinity,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
       const Text('Membres du staff',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),),

      if(data['nomPartenaires'].length > 6)TextButton(onPressed: () => print('yooooo'), child: Text('Voir plus'))
    ],
  ),
),


        Container(
    
      width: double.infinity,
      height: 90,
    
        child: MembreStaff(routeArgs),
    
    ),

const SizedBox(height: 20,),
    
  ],
),

Container(
  width: double.infinity,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
       const Text('évènements similaire',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),),

      TextButton(onPressed: () => print('yooooo'), child: Text('Voir plus'))
    ],
  ),
),

Container(
    
      width: double.infinity,
    
        child: PopularEvent(),
    
    ),


                        ],
                      ),),
                      const SizedBox(height: 70,)
                    
                  ],
                ),
              ),

              Align(
               alignment: Alignment.bottomCenter,  
              child: 
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: 70,
                color: Colors.white,
                child: InkWell(
            onTap: () { 
            // Navigator.of(context).pushNamed('/confirmation');
              },
            
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                color: ColorApp.secondaryColor,
                borderRadius: BorderRadius.circular(15)
              ),
              child: const Center(
                child: Text('Acheter le billet',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
          
                ), ),
              ),
            ),
                   ),
              ))
            ],
          );
        },
      );
            }
      )
    );
  }
}