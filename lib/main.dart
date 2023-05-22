import 'dart:io';

import 'package:event_room/providers/models/billet.dart';
import 'package:event_room/providers/models/dates.dart';
import 'package:event_room/providers/models/evenement.dart';
import 'package:event_room/providers/auth.dart';
import 'package:event_room/providers/models/user.dart';
import 'package:event_room/providers/objets/evenements.dart';
import 'package:event_room/providers/objets/form_helper.dart';
import 'package:event_room/screens/add_date.dart';
import 'package:event_room/screens/auth_screen.dart';
import 'package:event_room/screens/confirm_code.dart';
import 'package:event_room/screens/event_user.dart';
import 'package:event_room/screens/form_evenement.dart';
import 'package:event_room/screens/scan_screen.dart';
import 'package:event_room/screens/select_organis.dart';
import 'package:event_room/screens/sreen_qr_show.dart';
import 'package:event_room/screens/step_event.dart';
import 'package:event_room/screens/user_create.dart';
import 'package:event_room/screens/event_infos.dart';
import 'package:event_room/widgets/bottom_nav.dart';
import 'package:event_room/widgets/eventUser/add_ticket.dart';
import 'package:event_room/widgets/eventUser/liste_billets.dart';
import 'package:event_room/widgets/eventUser/event_modif.dart';
import 'package:event_room/widgets/eventUser/show_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async{
  await WidgetsFlutterBinding.ensureInitialized();
  await FastCachedImageConfig.init(clearCacheAfter: const Duration(days: 7));
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Evenement(nom: '', categorie: '', photos: [], flyer: '', description: '', pays: '', ville: '', createur: '', nomPartenaires: [], prix: {}, heures: {}, date: '', nbrePlace: 0, datePublication: DateTime.now(), tags: [], form: '', confidential: '', isPlaceIllimite: false, isPresent: false, isonline: false, sexRestrict: '', estPasse: false, minAge: 0, isDateUnique: true, isminAge: false),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Evenements(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Dates(debut: {}, fin: {}),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => FormHelper(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => UserC(nom: '', prenom: '', email: '',number: '', sex: '', pays: '', ville: '', dateNaissance: '', photo: ''),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Billet(idEvenement: '', idUser: '', jour: '', heure: {}, lieux: '', typeEvent: '', img: '', prix: 0, isValide: true, quantite: 0),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme:  ThemeData(
          fontFamily: 'Helvetica',
        ),
        title: 'Flutter Demo',
        home: const LoginPage(),
        routes: {
            LoginPage.routeName: (ctx) => LoginPage(),
            ConfirmCode.routeName: (ctx) => ConfirmCode(),
            BottomNavigation.routeName: (ctx) => BottomNavigation(),
            FormAddEvent.routeName: (ctx) => FormAddEvent(),
            StepEvent.routeName: (ctx) => StepEvent(),
            SelectStaff.routeName: (ctx) => SelectStaff(),
            CreateUserProfile.routeName: (ctx) => CreateUserProfile(),
            EventInfos.routeName: (ctx) => EventInfos(),
            AddDate.routeName: (ctx) => AddDate(),
            EventUser.routeName: (ctx) => EventUser(),
            ShowOptions.routeName: (ctx) => ShowOptions(),
            SreenQrShow.routeName: (ctx) => SreenQrShow(),
            ScanScreen.routeName: (ctx) => ScanScreen(),
            ModifEvent.routeName: (ctx) => ModifEvent(),
            ListeBillets.routeName: (ctx) => ListeBillets(),
            AddTicket.routeName: (ctx) => AddTicket(),
          }
        
      ),
    );
  }
}
