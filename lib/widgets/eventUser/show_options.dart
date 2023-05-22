import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_room/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

class ShowOptions extends StatelessWidget {
  static const routeName = '/ShowOptions';
  const ShowOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final eventId = routeArgs['id'];
    final eventName = routeArgs['nom'];

    return Scaffold(
      appBar: AppBar(
        title: Text(eventName!),
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: ColorApp.secondaryColor,
        elevation: 0,
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 4),
            child: IconButton(onPressed: () => Navigator.of(context).pushNamed('/Sreenqr'), 
              icon: Icon(
              FontAwesome5.qrcode,
              color: Colors.white,
            )),
          )
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 10,),
          ListTile(
            leading: const Icon(FeatherIcons.eye),
            title: Text("Aperçu de l'évènement", 
            style: TextStyle(
              fontSize: 18,
              color: Colors.black.withOpacity(0.7)
            ),),
            trailing: const Icon (FeatherIcons.chevronRight),
          ),
          const Divider(),

          ListTile(
            leading: const Icon(FeatherIcons.edit),
            title: Text("Modifier l'évènement", 
            style: TextStyle(
              fontSize: 18,
              color: Colors.black.withOpacity(0.7)
            ),),
            trailing: const Icon (FeatherIcons.chevronRight),
            onTap: () => Navigator.of(context).pushNamed('/Modifevent', arguments: eventId),
          ),
          const Divider(),

          ListTile(
            leading: const Icon(FeatherIcons.link),
            title: Text("Ajouter un lien de participation", 
            style: TextStyle(
              fontSize: 18,
              color: Colors.black.withOpacity(0.7)
            ),),
            trailing: const Icon (FeatherIcons.chevronRight),
          ),
          const Divider(),

          ListTile(
            leading: const Icon(FeatherIcons.userPlus),
            title: Text("Ajouter des invité(e)s", 
            style: TextStyle(
              fontSize: 18,
              color: Colors.black.withOpacity(0.7)
            ),),
            trailing: const Icon (FeatherIcons.chevronRight),
          ),
          const Divider(),

          ListTile(
            leading: const Icon(FeatherIcons.clipboard),
            title: Text("Liste des invité(e)s", 
            style: TextStyle(
              fontSize: 18,
              color: Colors.black.withOpacity(0.7)
            ),),
            trailing: const Icon (FeatherIcons.chevronRight),
          ),
          const Divider(),

          ListTile(
            leading: const Icon(FeatherIcons.trendingUp),
            title: Text("Statistique", 
            style: TextStyle(
              fontSize: 18,
              color: Colors.black.withOpacity(0.7)
            ),),
            trailing: const Icon (FeatherIcons.chevronRight),
          ),
          const Divider(),

          ListTile(
            leading: const Icon(FeatherIcons.rotateCw),
            title: Text("Renvoyer l'évènement", 
            style: TextStyle(
              fontSize: 18,
              color: Colors.black.withOpacity(0.7)
            ),),
            trailing: const Icon (FeatherIcons.chevronRight),
          ),
          const Divider(),

          ListTile(
            leading: const Icon(FeatherIcons.xSquare),
            title: Text("Annuler l'évènement", 
            style: TextStyle(
              fontSize: 18,
              color: Colors.black.withOpacity(0.7)
            ),),
            trailing: const Icon (FeatherIcons.chevronRight),
          ),

        ],
      ));
  }
}