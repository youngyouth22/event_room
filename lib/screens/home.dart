import 'package:event_room/colors.dart';
import 'package:event_room/providers/models/evenement.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

import '../widgets/home_widget/categorie_chip.dart';
import '../widgets/home_widget/recent_event.dart';
import '../widgets/home_widget/popular_event.dart';
import '../widgets/home_widget/user_follow.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        shadowColor: Colors.grey.withOpacity(0.8),
        title: Text('Event Room',
        style: TextStyle(
          color: ColorApp.secondaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 24
        ),),
        actionsIconTheme: IconThemeData(
          color: Colors.black,
        ),
        automaticallyImplyLeading: false,
        actions: [
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.withOpacity(0.2)),
            child: IconButton(onPressed: null, icon: Icon(FontAwesome5.search,
            color: Colors.black,
            weight: 36,
            size: 18,)),
          ),
          const SizedBox(width: 8,),
          Container(
             width: 35,
            height: 35,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.withOpacity(0.2)),
            child: IconButton(onPressed: null, icon: Icon(FluentSystemIcons.ic_fluent_alert_filled,
            color: Colors.black,
            weight: 36,
            size: 20,)),
          ),

          const SizedBox(width: 14,),
        ],
      ),
      body: ListView(
          children: [
            const SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Container(
                width: double.infinity,
                //color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Évènements populaire',
                    style: TextStyle(
                     fontSize: 16,
                     fontWeight: FontWeight.bold,
                    ),),
            
                    TextButton(onPressed: () => print('yooooo'), child: Text('Voir plus'))
                  ],
                ),
              ),
            ),
            PopularEvent(),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            //   child:Container(
            //   width: double.infinity,
            //   child: const Text('Évènement Récent',
            //           style: TextStyle(
            //            fontSize: 16,
            //            fontWeight: FontWeight.bold,
            //           ),),
            // ),),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Container(
                width: double.infinity,
                //color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Organisateurs populaire',
                    style: TextStyle(
                     fontSize: 16,
                     fontWeight: FontWeight.bold,
                    ),),
            
                    TextButton(onPressed: () => print('yooooo'), child: Text('Voir plus'))
                  ],
                ),
              ),
            ),

            UserFollow(),
            
            const SizedBox(height: 10,),
            CategorieChips(),
           RecentEvent()
            
          ],
        ),
          
    );
  }
}