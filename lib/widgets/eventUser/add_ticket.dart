import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../colors.dart';
import '../title_form.dart';

class AddTicket extends StatefulWidget {
  static const routeName = '/AddBillet';
  const AddTicket({super.key});

  @override
  State<AddTicket> createState() => _AddTicketState();
}

class _AddTicketState extends State<AddTicket> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nomController= TextEditingController();
  TextEditingController quantite= TextEditingController();

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(appBar: AppBar(
        title: Text('Ajouter un billet'),
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: ColorApp.secondaryColor,
        elevation: 0,
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 4),
            child: IconButton(onPressed: null, 
              icon: const Icon(
              FeatherIcons.check,
              color: Colors.white,
            )),
          )
        ],
      ),
      body: SingleChildScrollView(
          child: 
          Padding(
        padding: const EdgeInsets.all(20),
        child:Form(
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
        ),
      ),
      );
  }
}