import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../colors.dart';

class Parametre extends StatefulWidget {
  const Parametre({super.key});

  @override
  State<Parametre> createState() => _ParametreState();
}

class _ParametreState extends State<Parametre> {

 bool orgaIsShow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 0.07),
      body: SafeArea(
        child: ListView(
          children: [

            Container(
              decoration: BoxDecoration(
                border:  Border(
                top: BorderSide(width: 0.6, color: Colors.grey.withOpacity(0.7)),
                bottom: BorderSide(width: 0.6, color: Colors.grey.withOpacity(0.7)),
                )
              ),
              child: ExpansionTile(
                    title: const Text('Organisateur', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),),
                    leading: Image.asset("assets/icons/icons8-badge-d'employé-48.png",
                    height: 30,),
                    trailing: orgaIsShow == false? const Icon(FeatherIcons.chevronDown) : const Icon(FeatherIcons.chevronUp),
                    children: [
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Card(
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 0,
                      shadowColor: const Color.fromRGBO(0, 0, 0, 0.6),
                                      child: ListTile(
                      title: const Text('Vos évènements', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),),
                      tileColor: Colors.white,
                      leading: Image.asset("assets/icons/icons8-cartes-bancaires-48.png",
                      height: 30,),
                      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(8.0),),
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10.0),
                      onTap: () => Navigator.of(context).pushNamed('/EventUser'),
                                      ),
                                    ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Card(
                                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 0,
                      shadowColor: const Color.fromRGBO(0, 0, 0, 0.6),
                                      child: ListTile(
                      title: const Text('Creer un évènement', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),),
                      tileColor: Colors.white,
                      leading: Image.asset("assets/icons/icons8-cartes-bancaires-48.png",
                      height: 30,),
                      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(8.0),),
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10.0),
                      onTap: () => Navigator.of(context).pushNamed('/StepEvent'),
                                      ),
                                    ),
                    ),

                    const SizedBox(height: 15,)
                     
                    ],
                    onExpansionChanged: (bool expanded) {
                      setState(() {
                        orgaIsShow = expanded;
                      });
                    },
                  ),
            ),



            Container(
              decoration: BoxDecoration(
                border:  Border(
                //top: BorderSide(width: 0.6, color: Colors.grey.withOpacity(0.7)),
                bottom: BorderSide(width: 0.6, color: Colors.grey.withOpacity(0.7)),)
              ),
              child: ListTile(
                          title: const Text('Méthode de Payement', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),),
                          //tileColor: Colors.white,
                          leading: Image.asset("assets/icons/icons8-cartes-bancaires-48.png",
                          height: 30,),
                          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(8.0),),
                          dense: true,
                          contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15.0),
                          onTap: () => null,
                        ),
            ),


            Container(
              decoration: BoxDecoration(
                border:  Border(
                //top: BorderSide(width: 0.6, color: Colors.grey.withOpacity(0.7)),
                bottom: BorderSide(width: 0.6, color: Colors.grey.withOpacity(0.7)),)
              ),
              child: ListTile(
                    title: const Text('Votre Agenda', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),),
                    //tileColor: Colors.white,
                    leading: Image.asset("assets/icons/icons8-windows-calendar-48.png",
                    height: 30,),
                    shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(8.0),),
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15.0),
                    
                  ),
            ),


            Container(
              decoration: BoxDecoration(
                border:  Border(
                //top: BorderSide(width: 0.6, color: Colors.grey.withOpacity(0.7)),
                bottom: BorderSide(width: 0.6, color: Colors.grey.withOpacity(0.7)),)
              ),
              child: ListTile(
                    title: const Text('Vos Tickets', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),),
                    //tileColor: Colors.white,
                    leading: Image.asset("assets/icons/icons8-ticket-combi-48.png",
                    height: 30,),
                    trailing: const Icon(FeatherIcons.chevronDown),
                    shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(8.0),),
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15.0),
                    
                  ),
            ),


            Container(
              decoration: BoxDecoration(
                border:  Border(
                //top: BorderSide(width: 0.6, color: Colors.grey.withOpacity(0.7)),
                bottom: BorderSide(width: 0.6, color: Colors.grey.withOpacity(0.7)),)
              ),
              child: ListTile(
                    title: const Text('Vos Favoris', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),),
                    //tileColor: Colors.white,
                    leading: Image.asset("assets/icons/icons8-aime-rempli-48.png",
                    height: 30,),
                    shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(8.0),),
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15.0),
                    
                  ),
            ),


            Container(
              decoration: BoxDecoration(
                border:  Border(
                //top: BorderSide(width: 0.6, color: Colors.grey.withOpacity(0.7)),
                bottom: BorderSide(width: 0.6, color: Colors.grey.withOpacity(0.7)),)
              ),
              child: ListTile(
                    title: const Text('Nous Suivre', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),),
                    //tileColor: Colors.white,
                    leading: Image.asset("assets/icons/icons8-pouce-en-l'air-48.png",
                    height: 30,),
                    trailing: const Icon(FeatherIcons.chevronDown),
                    shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(8.0),),
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15.0),
                    
                  ),
            ),


            Container(
              decoration: BoxDecoration(
                border:  Border(
                //top: BorderSide(width: 0.6, color: Colors.grey.withOpacity(0.7)),
                bottom: BorderSide(width: 0.6, color: Colors.grey.withOpacity(0.7)),)
              ),
              child: ListTile(
                    title: const Text('Langue', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),),
                    //tileColor: Colors.white,
                    leading: Image.asset("assets/icons/icons8-globe-terrestre-48.png",
                    height: 30,),
                    shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(8.0),),
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15.0),
                    
                  ),
            ),


            Container(
              decoration: BoxDecoration(
                border:  Border(
                //top: BorderSide(width: 0.6, color: Colors.grey.withOpacity(0.7)),
                bottom: BorderSide(width: 0.6, color: Colors.grey.withOpacity(0.7)),)
              ),
              child: ListTile(
                    title: const Text('Paramètre du Compte', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),),
                    //tileColor: Colors.white,
                    leading: Image.asset("assets/icons/icons8-paramètres-48.png",
                    height: 30,),
                    shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(8.0),),
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15.0),
                    
                  ),
            ),


            Container(
              decoration: BoxDecoration(
                border:  Border(
                //top: BorderSide(width: 0.6, color: Colors.grey.withOpacity(0.7)),
                bottom: BorderSide(width: 0.6, color: Colors.grey.withOpacity(0.7)),)
              ),
              child: ListTile(
                    title: const Text('Conditions et confidentialité', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),),
                    //tileColor: Colors.white,
                    leading: Image.asset("assets/icons/icons8-bouclier-de-l'utilisateur-48.png",
                    height: 30,),
                    trailing: const Icon(FeatherIcons.chevronDown),
                    shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(8.0),),
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15.0),
                    
                  ),
            ),

            Container(
              decoration: BoxDecoration(
                border:  Border(
                //top: BorderSide(width: 0.6, color: Colors.grey.withOpacity(0.7)),
                bottom: BorderSide(width: 0.6, color: Colors.grey.withOpacity(0.7)),)
              ),
              child: ListTile(
                    title: const Text('Mode Sombre', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),),
                    //tileColor: Colors.white,
                    leading: Image.asset("assets/icons/icons8-noir-et-blanc-48.png",
                    height: 30,),
                    shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(8.0),),
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15.0),
                    
                  ),
            ),

            const SizedBox(height: 25,),
                 Padding(
                   padding: const EdgeInsets.all(20.0),
                   child: InkWell(
                                 onTap: null,
                                 child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(33, 158, 158, 158),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: const Center(
                      child: Text('Déconnexion',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                               
                      ), ),
                    ),
                                 ),
                   ),
                 )
          ],
        ),
      ),
    );
  }
}