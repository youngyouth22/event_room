import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class ModifEvent extends StatelessWidget {
  static const routeName = '/Modifevent';
  const ModifEvent({super.key});

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Modifier l'évènement"),
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

      body: SingleChildScrollView(
        child: Column(children: [
          ListTile(
            title: Text("Gerer les billets", 
            style: TextStyle(
              fontSize: 18,
              color: Colors.black.withOpacity(0.7)
            ),),
            trailing: const Icon (FeatherIcons.chevronRight),
            onTap: () => Navigator.of(context).pushNamed('/Listebillets', arguments: routeArgs),
          ),
        ]),
      ),
    );
  }
}