import 'package:csc_picker/csc_picker.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:event_room/widgets/title_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:listtextfield/listtextfield.dart';
import 'dart:core';
import '../colors.dart';
import 'package:provider/provider.dart';
import 'package:event_room/providers/objets/form_helper.dart';
import 'package:event_room/providers/models/evenement.dart';

class FirstOne extends StatefulWidget {
   
      final VoidCallback?  suivant;
      final VoidCallback? back;

      FirstOne( {this.suivant, this.back});

  @override
  State<FirstOne> createState() => _FirstOneState();
}

class _FirstOneState extends State<FirstOne> {

 FirebaseAuth? _auth;

 @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
  }
  

  void onTextFieldTap() {
  DropDownState(
      DropDown(
        bottomSheetTitle: const Text(
          'Type de votre évènement',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        submitButtonChild: const Text(
          'Done',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        data:  [
          SelectedListItem(name: 'Concerts'),
          SelectedListItem(name: 'Festivals'),
          SelectedListItem(name: 'Spectacles de théâtre'),
          SelectedListItem(name: 'Spectacles de danse'),
          SelectedListItem(name: 'Comédies musicales'),
          SelectedListItem(name: 'Opéras'),
          SelectedListItem(name: 'Spectacles de cirque'),
          SelectedListItem(name: 'Spectacles pour enfants'),
          SelectedListItem(name: 'Conférences'),
          SelectedListItem(name: 'Salons professionnels'),
          SelectedListItem(name: 'Foires commerciales'),
          SelectedListItem(name: 'Événements sportifs'),
          SelectedListItem(name: 'Tournois de jeux vidéo'),
          SelectedListItem(name: 'Événements de bienfaisance'),
          SelectedListItem(name: 'Événements culinaires et gastronomiques'),
          SelectedListItem(name: 'Événements de mode et de beauté'),
          SelectedListItem(name: "Expositions d'art"),
          SelectedListItem(name: 'Festivals de cinéma'),
          SelectedListItem(name: 'Salons du livre'),
          SelectedListItem(name: 'Événements scientifiques et technologiques'),
          SelectedListItem(name: 'Événements religieux'),
          SelectedListItem(name: 'Événements éducatifs'),
          SelectedListItem(name: 'Événements caritatifs'),
          SelectedListItem(name: 'Autres'),
 
        ],
        selectedItems: (List<dynamic> selectedList) {
          // List<String> list = [];
          String choosed = '';
           for(var item in selectedList) {
              if(item is SelectedListItem) {
                //list.add(item.name);
                choosed = item.name;
              }
           }
          
          // showSnackBar(choosed);
          chooseCategoryController.text = choosed;
        },
        enableMultipleSelection: false,
      ),
    ).showModal(context);
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  TextEditingController chooseCategoryController = TextEditingController();
  final _formKey1 = GlobalKey<FormState>();
  final _controllerTag = ListTextEditingController(',');
  final _name = TextEditingController();
  final _description = TextEditingController();
   String  pays = '';
   String ville = '';
   String etat = '';
   var _editEvent = Evenement(nom: '', categorie: '', photos: [], flyer: '', description: '', pays: '', ville: '', createur: '', nomPartenaires: [], prix: {}, heures: {}, date: '', nbrePlace: 0, datePublication: DateTime.now(), tags: [], form: '', confidential: '', isPlaceIllimite: false, isPresent: false, isonline: false, sexRestrict: '', estPasse: false, minAge: 0, isDateUnique: true, isminAge: false);

  @override
 void dispose(){
   _name.dispose();
   _description.dispose();
   //chooseCategoryController.dispose();
   _controllerTag.dispose();
   super.dispose();
 }
 

 void validater(){
   if(_formKey1.currentState!.validate()){
    _formKey1.currentState?.save();
    Provider.of<Evenement>(context, listen: false).nom = _editEvent.nom;
    Provider.of<Evenement>(context, listen: false).categorie = chooseCategoryController.text;
    Provider.of<Evenement>(context, listen: false).description = _description.text;
    Provider.of<Evenement>(context, listen: false).tags = _controllerTag.items.toList();
    Provider.of<Evenement>(context, listen: false).pays = pays;
    Provider.of<Evenement>(context, listen: false).ville = ville;

    print(Provider.of<Evenement>(context, listen: false).tags);

   }
 }
GlobalKey<CSCPickerState> _cscPickerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final User? user = _auth?.currentUser;
    final String userId = user!.uid;
    double values = Provider.of<FormHelper>(context).values;
    return Column(
      children: [
        const Text('Entrez les informations sur votre Évènement',
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
     key: _formKey1, 
    child:
    Column(
      children: [
       const SizedBox(height: 0,),
       TitleForm(title: 'Nom'),
        TextFormField(
          controller: _name,
         keyboardType: TextInputType.name,
         decoration: InputDecoration(
           hintText: "Nom de l'évènement", 
           border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(8),
             borderSide: const BorderSide(
               width: 0.7,
               color: Color.fromARGB(50, 158, 158, 158),
             )
           )
         ),
         validator: (value){
                    if(value ==null || value.isEmpty){
                      return 'Veuillez entrez le nom de votre évènement';
                    }
                    return null;
                  },
        onSaved: (value) {
        _editEvent = Evenement(nom: value!, categorie: _editEvent.categorie, photos: _editEvent.photos, flyer: _editEvent.flyer, description: _editEvent.description, pays: _editEvent.pays, ville: _editEvent.ville, createur: _editEvent.createur, nomPartenaires: _editEvent.nomPartenaires, prix: _editEvent.prix, heures: _editEvent.heures, date: _editEvent.date, nbrePlace: _editEvent.nbrePlace, datePublication: _editEvent.datePublication, tags: _editEvent.tags, form: _editEvent.form, confidential: _editEvent.confidential, isPlaceIllimite: _editEvent.isPlaceIllimite, isPresent: _editEvent.isPresent, isonline: _editEvent.isonline, sexRestrict: _editEvent.sexRestrict, estPasse: _editEvent.estPasse, minAge: _editEvent.minAge, isDateUnique: _editEvent.isDateUnique, isminAge: _editEvent.isminAge);

        },
         
        ),
        const SizedBox(height: 25,),

        TitleForm(title: ' Catégorie'),
        TextFormField(
         readOnly: true,
         controller: chooseCategoryController,
         keyboardType: TextInputType.name,
         decoration: InputDecoration(suffixIcon: const Icon(FeatherIcons.chevronDown),
           hintText: "Catégories de votre évènement", 
           border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(8),
             borderSide: const BorderSide(
               width: 0.7,
               color: Color.fromARGB(50, 158, 158, 158),
             )
           )
         ),
         validator: (chooseCategoryController){
                    if(chooseCategoryController ==null || chooseCategoryController.isEmpty){
                      return 'Veuillez choisir un catégorie';
                    }
                    return null;
                  },
          onTap: onTextFieldTap,
          
        ),
        
        const SizedBox(height: 25,),
        TitleForm(title: 'Description'),
        TextFormField(
         controller: _description,
         keyboardType: TextInputType.multiline,
         maxLines: 10,
         maxLength: 1000,
         decoration: InputDecoration(
           hintText: "Entrez une brève description",
           border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(8),
             borderSide: const BorderSide(
               width: 0.7,
               color: Color.fromARGB(50, 158, 158, 158),
             )
           )
         ),
         validator: (value){
                    if(value ==null || value.isEmpty){
                      return 'Veuillez entrez une brève description de  votre évènement';
                    }
                    return null;
                  },

         
        ),
        const SizedBox(height: 25,),
         
         /////////////////////////////////////////////////////////////////////////////////////
        TitleForm(title: 'Tags (Optionel)'),
        ListTextField(
                controller: _controllerTag, 
                itemBuilder: (_, value){
                    // Build how items in the list should appear
                    return Chip(
                    label: Text(value),
                    onDeleted: () => _controllerTag.removeItem(value),
                    );
                },
                decoration: const BoxDecoration(border: Border(bottom: BorderSide(
                  color: Color.fromARGB(50, 158, 158, 158),
                  width: 0.7
                ),)),
           
        ),
        const SizedBox(height: 25,),
        

        TitleForm(title: 'Lieu'),
        CSCPicker(flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,
          key: _cscPickerKey,
         onCountryChanged: (country) {
          setState(() {
           pays = country;
          });
            
         },
         onStateChanged: (state) {
          setState(() {
            etat = state ==null? pays: state;
          });
          },
         onCityChanged: (city) {
          setState(() {
            ville = city ==null? etat: city;
          });
         },
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
                                      Provider.of<Evenement>(context, listen: false).createur = userId;
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
      ],
    ),

    
    ),
    
      ],
    );
  }
}