// ignore_for_file: await_only_futures

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

import '../colors.dart';
import '../screens/form_evenement.dart';
import 'package:provider/provider.dart';
import 'package:event_room/providers/objets/form_helper.dart';
import 'package:event_room/providers/models/evenement.dart';


class PhotoSelect extends StatefulWidget {
  const PhotoSelect({super.key});

  @override
  State<PhotoSelect> createState() => _PhotoSelectState();
}

class _PhotoSelectState extends State<PhotoSelect> {

  FirebaseAuth? _auth;

 @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
  }
  

  File _image = File('');
  List <File> _images = [];

   void validater(){
    print(Provider.of<Evenement>(context, listen: false).nom);
    (Provider.of<Evenement>(context, listen: false).flyer + Provider.of<Evenement>(context, listen: false).nom + Provider.of<Evenement>(context, listen: false).date);
  }
  @override
  Widget build(BuildContext context) {
    final User? user = _auth?.currentUser;
    final String userId = user!.uid;
    double values = Provider.of<FormHelper>(context).values;
    return GestureDetector(
      onTap: () async {
        final files = await imageHelper.pickImage();
        if (files.isNotEmpty){
          final croppedFile = await imageHelper.crop(file: files.first,CropStyle: CropStyle.rectangle);
       
       if(croppedFile != null){
          setState(() {
            _image = File(croppedFile.path);
          });
        }
        }
        
      },
      child: Container(
        child: Column(
          children: [
            const Text('Selectionnez des affiches pour votre evènement',
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
       
       ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Stack(
       children: [
        if(_image.path.isEmpty)
         Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
          color: Colors.grey[300],),
          //child:Image.file( _image, fit: BoxFit.cover),
         )else
         Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
          color: Colors.grey[300],),
          child:Image.file( _image, fit: BoxFit.cover),
         ),
        
         Positioned(
          top: 65,
          left: 65,
          child: Opacity(opacity: 0.2,
            child: Image.asset("assets/icons/icons8-ajouter-une-image-96.png", width: 70,)))
       ],
       )),

       const SizedBox(height: 25,),

       Wrap(
          spacing: 4,
          runSpacing: 4,
          children: _images
          .map((e) => Image.file(
            e,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          ).toList()
       ),

       const SizedBox(height: 8,),
       TextButton(onPressed: () async{
          final files = await imageHelper.pickImage(multiple: true);
          setState(() {
            _images = files.map((e) => File(e.path)).toList();
          });
       }, 
       child: Text('Ajoutez des photos(Optionel)')),


       //////////////////////////////////////////////////////////////////////////////////
              const SizedBox(height: 15,),
                   Visibility(
                    visible: values ==100?false: true ,
                     child: Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 20),
                       child: InkWell(
                                      onTap: () => Provider.of<FormHelper>(context, listen: false).suivantPlus(),
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

                   Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 20),
                       child: InkWell(
                                      onTap: () async {
                                        validater();
                                       await Provider.of<Evenement>(context, listen: false).saveData(_image, userId, Provider.of<Evenement>(context, listen: false).nomPartenaires2 ).
                                       then((value) => Provider.of<Evenement>(context, listen: false).isDateUnique ==true ? Navigator.pop(context): Navigator.of(context).pushNamed('/addDate'));
                                        },
                                      child: Container(
                       height: 50,
                       decoration: BoxDecoration(
                         color: ColorApp.secondaryColor,
                         borderRadius: BorderRadius.circular(8)
                       ),
                       child: const Center(
                         child: Text('Creer un évènement',
                         style: TextStyle(
                           color: Colors.white,
                           fontSize: 15,
                           fontWeight: FontWeight.bold,
                                    
                         ), ),
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
    );
  }
}
