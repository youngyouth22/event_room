import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:event_room/colors.dart';
import 'package:event_room/widgets/select_user.dart';
import 'package:event_room/widgets/title_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import 'package:event_room/providers/objets/form_helper.dart';
import 'package:event_room/providers/models/evenement.dart';


class SegondOne extends StatefulWidget {
  const SegondOne({super.key});

  @override
  State<SegondOne> createState() => _SegondOneState();
}

List <String> confidential = ['public', 'private', 'selectif'];

List <String> sex = ['sexes', 'homme', 'femme'];

class _SegondOneState extends State<SegondOne> {
  final _formKey2 = GlobalKey<FormState>();
  final  _minAgeController = TextEditingController();
  double myAge = 0;
  final _nbrPlaceController = TextEditingController();
  int nbreplace = 0;
  final _formController = TextEditingController();
  bool isAgeChecked = false;
  bool isPlaceChecked = true;
  bool isphysic = false;
  bool isonline = false;
  String currentConfi = confidential[0];
  String currentsex = sex[0];
  bool selectif = false;

 
//   var _eventCreat = Evenement(nom: '', categorie: '', photos: [], flyer: '', description: '', pays: '', ville: '', createur: '', nomPartenaires: {}, prix: {}, heures: {}, date: '', nbrePlace: 0, datePublication: DateTime.now(), tags: [], form: '', confidential: '', isPlaceIllimite: false, isPresent: false, isonline: false, sexRestrict: '',estAime: false, estPasse: false, minAge: 0);

// void validater(){
//    if(_formKey2.currentState!.validate()){
//     _eventCreat = Evenement(nom: _eventCreat.nom, categorie: _eventCreat.categorie, photos: _eventCreat.photos, flyer: _eventCreat.flyer, description: _eventCreat.description, pays: _eventCreat.pays, ville: _eventCreat.ville, createur: _eventCreat.createur, nomPartenaires: _eventCreat.nomPartenaires, prix: _eventCreat.prix, heures: _eventCreat.heures, date: _eventCreat.date, nbrePlace: _eventCreat.nbrePlace, datePublication: _eventCreat.datePublication, tags: _eventCreat.tags, confidential: _eventCreat.confidential, form: _eventCreat.form, sexRestrict: _eventCreat.sexRestrict, minAge: _eventCreat.minAge, isPlaceIllimite: _eventCreat.isPlaceIllimite, isPresent: _eventCreat.isPresent, isonline: _eventCreat.isonline);
//     print(_eventCreat.nom + _eventCreat.categorie + _eventCreat.tags.toString() + _eventCreat.ville);
//     _formKey2.currentState!.save();
//    }
//  }


void validater(){
   try {
  myAge = double.parse(_minAgeController.text);
} catch (e) {
  myAge = 0;
}

 try {
  nbreplace = int.parse(_nbrPlaceController.text);
} catch (e) {
  nbreplace = 0;
}
if(_formKey2.currentState!.validate()){
  _formKey2.currentState?.save();
  Provider.of<Evenement>(context, listen: false).nomPartenaires;
  Provider.of<Evenement>(context, listen: false).isminAge = isAgeChecked;
  Provider.of<Evenement>(context, listen: false).minAge = isAgeChecked == true? myAge: 0;
  Provider.of<Evenement>(context, listen: false).isPlaceIllimite = isPlaceChecked;
  Provider.of<Evenement>(context, listen: false).nbrePlace = isPlaceChecked == false ? nbreplace : 10000000000000000;
  Provider.of<Evenement>(context, listen: false).isonline = isonline;
  Provider.of<Evenement>(context, listen: false).isPresent = isphysic;
  Provider.of<Evenement>(context, listen: false).sexRestrict = currentsex;
  Provider.of<Evenement>(context, listen: false).confidential = currentConfi;
  Provider.of<Evenement>(context, listen: false).form= currentConfi == 'selectif'? _formController.text: '';
   //Provider.of<Evenement>(context, listen: false).saveData();
}
}


TextEditingController typeBilletController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double values = Provider.of<FormHelper>(context).values;
    return Column(
      children: [
         const Text('Entrez les informations supplémentaires',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w600,
          height: 1.5,
        ),),

       const SizedBox(height: 14,),

          const Text('Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.',
    style: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      height: 1.5,
      color: Colors.black54
    ),),
    const SizedBox(height: 40,),

    Form(
      key: _formKey2,
      child: Column(children: [
      TitleForm(title: 'Staff (Optionel)'),
      Row(
        children: [



          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed('/SelectStaff'),
                child: Row(
                  children: [
                    //SelectUser(),
                    Stack(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(104, 158, 158, 158),
                            shape: BoxShape.circle
                          ),
                        ),
                        Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: const Icon(FeatherIcons.plus,
                          color: Colors.grey,
                           size: 14),
                        )
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
             
            ],
          )
          ],
      ),

          ///////////////////////////////////////////////////////////////////////
       const SizedBox(height: 25,), 
      TitleForm(title: "Restriction d'âge"),
      Container(
        width: double.infinity,
        alignment: Alignment.centerLeft,
        child: 
        Row(
          children: [
            Checkbox(value: isAgeChecked,
            activeColor: ColorApp.secondaryColor,
             onChanged: (newBool){
              setState(() {
                isAgeChecked = newBool!;
              });
             }),

             Text('Avoir un certain âge'),

             
          ],
        ),
      ),
      Visibility(
              visible: isAgeChecked,
              child: TextFormField(
          controller: _minAgeController,
         keyboardType: TextInputType.number,
         decoration: InputDecoration(
           hintText: "Quel est l'âge minimun", 
           border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(8),
             borderSide: const BorderSide(
               width: 0.7,
               color: Color.fromARGB(50, 158, 158, 158),
             )
           )
         ),
        ),
               ),

                const SizedBox(height: 25,), 
      TitleForm(title: "Nombre de place"),
      Container(
        width: double.infinity,
        alignment: Alignment.centerLeft,
        child: 
        Row(
          children: [
            Checkbox(value: isPlaceChecked,
            activeColor: ColorApp.secondaryColor,
             onChanged: (newBool){
              setState(() {
                isPlaceChecked = newBool!;
              });
             }),

             Text('Place illimitée'),

             
          ],
        ),
      ),
      Visibility(
              visible: isPlaceChecked==false,
              child: TextFormField(
         controller: _nbrPlaceController,
         keyboardType: TextInputType.number,
         decoration: InputDecoration(
           hintText: "Entrer le nombre de place", 
           border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(8),
             borderSide: const BorderSide(
               width: 0.7,
               color: Color.fromARGB(50, 158, 158, 158),
             )
           )
         ),
        ),
               ),

      const SizedBox(height: 25,),
      TitleForm(title: 'Votre évènement se fera'),
      Container(
        width: double.infinity,
        alignment: Alignment.centerLeft,
        child: 
        Row(
          children: [
            Checkbox(value: isphysic,
            activeColor: ColorApp.secondaryColor,
             onChanged: (newBool){
              setState(() {
                isphysic = newBool!;
              });
             }),

             Text('En présentiel'),

             

             
          ],
        ),
      ),

      Container(
        width: double.infinity,
        alignment: Alignment.centerLeft,
        child: 
        Row(
          children: [
            Checkbox(value: isonline,
            activeColor: ColorApp.secondaryColor,
             onChanged: (newBool){
              setState(() {
                isonline = newBool!;
              });
             }),

             Text('En ligne'),

             
          ],
        ),
      ),
       
      const SizedBox(height: 25,),
      TitleForm(title: 'Restriction de sexe'),
       ListTile(
              title: const Text('Tous les sexes'),
              leading: Radio(
                value: sex[0],
                groupValue: currentsex,
                onChanged: (value) {
                  setState(() {
                    currentsex = value.toString();
                  });
                  
                },
              ),
             ),

             ListTile(
              title: const Text('Hommes'),
              leading: Radio(
                value: sex[1],
                groupValue: currentsex,
                onChanged: (value) {
                  setState(() {
                    currentsex = value.toString();
                  });
                  
                },
                
              ),
             ),

             ListTile(
              title: const Text('Femmes'),
              leading: Radio(
                value: sex[2],
                groupValue: currentsex,
                onChanged: (value) {
                  setState(() {
                    currentsex = value.toString();
                  });
                  
                },
              ),
             ),


      const SizedBox(height: 25,),
      TitleForm(title: 'Confidentialité'),
       ListTile(
              title: const Text('Évènement public'),
              leading: Radio(
                value: confidential[0],
                groupValue: currentConfi,
                onChanged: (value) {
                  setState(() {
                    currentConfi = value.toString();
                  });
                  if(currentConfi == 'public'){
                    setState(() {
                      selectif = false;
                    });
                  }
                },
              ),
             ),

             ListTile(
              title: const Text('Évènement privé'),
              leading: Radio(
                value: confidential[1],
                groupValue: currentConfi,
                onChanged: (value) {
                  setState(() {
                    currentConfi = value.toString();
                  });
                  if(currentConfi == 'private'){
                    setState(() {
                      selectif = false;
                    });
                  }
                },
                
              ),
             ),

             ListTile(
              title: const Text('Évènement sélectif'),
              leading: Radio(
                value: confidential[2],
                groupValue: currentConfi,
                onChanged: (value) {
                  setState(() {
                    currentConfi = value.toString();
                  });
                  if(currentConfi == 'selectif'){
                    setState(() {
                      selectif = true;
                    });
                  }
                },
              ),
             ),

            Visibility(
              visible: selectif,
              child: TextFormField(
         controller: _formController,
         keyboardType: TextInputType.url,
         decoration: InputDecoration(
           hintText: "Entrer le lien de votre formulaire", 
           border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(8),
             borderSide: const BorderSide(
               width: 0.7,
               color: Color.fromARGB(50, 158, 158, 158),
             )
           )
         ),
        ),
               ), 

               //////////////////////////////////////////////////////////////////////////////////
              const SizedBox(height: 15,),
                   Visibility(
                    visible: values ==100?false: true ,
                     child: Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 20),
                       child: InkWell(
                                      onTap: ()  {
                                       Provider.of<FormHelper>(context, listen: false).suivantPlus();
                                        validater();
                                        },
                                      child: Container(
                       height: 50,
                       decoration: BoxDecoration(
                         color: ColorApp.secondaryColor,
                         borderRadius: BorderRadius.circular(8)
                       ),
                       child: const Center(
                         child: Text('Suivant',
                         style: TextStyle(
                           color: Colors.white,
                           fontSize: 15,
                           fontWeight: FontWeight.bold,
                                    
                         ), ),
                       ),
                                      ),
                                     ),
                     ),
                   ),

                Visibility(
                  visible: values ==25?false: true ,
                  child: TextButton(
                  onPressed: () => Provider.of<FormHelper>(context, listen: false).suivantmoin(), 
                  child: const Text('Retour', style: TextStyle(
                   color: Colors.grey
                  ),)),
                )

    ],))
      ],
    );
  }
}