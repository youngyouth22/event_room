import 'package:csc_picker/csc_picker.dart';
import 'package:event_room/providers/models/user.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../colors.dart';
import '../widgets/select_photo_options_screen.dart';
import '../widgets/title_form.dart';
import 'package:provider/provider.dart';

import 'dart:io';


class CreateUserProfile extends StatefulWidget {
  const CreateUserProfile({super.key});
  static const routeName = '/userCreat';

  @override
  State<CreateUserProfile> createState() => _CreateUserProfileState();
}
List <String> sex = ['homme', 'femme'];

class _CreateUserProfileState extends State<CreateUserProfile> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateController= TextEditingController();
  TextEditingController nomController= TextEditingController();
  TextEditingController prenomController= TextEditingController();
  TextEditingController emailController= TextEditingController();
  DateTime annee = DateTime.now();
  String currentsex = '';
  String  pays = '';
   String ville = '';
   String etat = '';
   File? _image = File('');

   Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      setState(() {
        _image = img;
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path,aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1));
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(18),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptionsScreen(
                onTap: _pickImage,
              ),
            );
          }),
    );
  }

  void validater(){
    if(_formKey.currentState!.validate()){
    _formKey.currentState?.save();
    Provider.of<UserC>(context, listen: false).nom = nomController.text;
    Provider.of<UserC>(context, listen: false).prenom = prenomController.text;
    Provider.of<UserC>(context, listen: false).email = emailController.text;
    Provider.of<UserC>(context, listen: false).dateNaissance = annee.toString();
    Provider.of<UserC>(context, listen: false).sex = currentsex;
    Provider.of<UserC>(context, listen: false).pays = pays;
    Provider.of<UserC>(context, listen: false).ville = ville;
    Provider.of<UserC>(context, listen: false).saveData(_image!);
    }
  }


GlobalKey<CSCPickerState> _cscPickerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Créer votre profil'),
        centerTitle: true,
        elevation: 0,
        titleTextStyle: const TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.bold
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
          child: 
          Padding(
        padding: const EdgeInsets.all(20),
        child:Form(
            key: _formKey,
            child: Column(
            children: [

              const SizedBox(height: 25,),
              Stack(children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    radius: 90,
                    backgroundImage: FileImage(_image ?? File('')),
                  ),
           Positioned(
          bottom: 0,
          right: 0,
          child: Opacity(opacity: 1,
            child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child:  IconButton(
                        onPressed: () => _showSelectPhotoOptions(context),
                        icon: Icon(FluentSystemIcons.ic_fluent_camera_add_filled,
                        color: ColorApp.secondaryColora2,
                         size: 25),
                      ),
                    ))
            )
              ],),


    ////////////////////////////////////////////////////////////////////////////////////////          
           const SizedBox(height: 25,),
           TitleForm(title: 'Nom'),
            TextFormField(
            controller: nomController,
             keyboardType: TextInputType.name,
             decoration: InputDecoration(
               hintText: "Entrer votre nom", 
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
             
            ),
        
        
            const SizedBox(height: 25,),
           TitleForm(title: 'Prénom'),
            TextFormField(
             controller: prenomController,
             keyboardType: TextInputType.name,
             decoration: InputDecoration(
               hintText: "Entrer votre prénom", 
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
            ),

             const SizedBox(height: 25,),
           TitleForm(title: 'Email'),
            TextFormField(
             controller: emailController,
             keyboardType: TextInputType.emailAddress,
             decoration: InputDecoration(
               hintText: "Entrer votre email", 
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
            ),
        
            const SizedBox(height: 25,),
           TitleForm(title: 'Date de naissance'),
            TextFormField(
                             controller: dateController,
                             keyboardType: TextInputType.datetime,
                             readOnly: true,
                             decoration: InputDecoration(
                               hintText: "Choisir votre date de naissance",
                               prefixIcon: const Icon(FluentSystemIcons.ic_fluent_calendar_filled),
                               suffixIcon: const Icon(FeatherIcons.chevronDown),
                               border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(8),
                                 borderSide: const BorderSide(
                                   width: 0.7,
                                   color: Color.fromARGB(50, 158, 158, 158),
                                 )
                               )
                             ),
                             onTap: () {
                              DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        
                        minTime: DateTime(1950,1,1),
                        maxTime: DateTime.now(),
                        
                        onChanged: (date) {
                      print('change $date in time zone ' +
                          date.timeZoneOffset.inHours.toString());
                          annee = date;
                    }, onConfirm: (date) {
                      print('confirm $date');
                      dateController.text = date.day.toString() + '/' + date.month.toString() + '/' + date.year.toString();
                    }, currentTime: DateTime.now(), locale: LocaleType.fr);
                             },
                            ),
        
        
        
              const SizedBox(height: 25,),
           TitleForm(title: 'Genre'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 160,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(
                        width: 1,
                        color: Colors.grey
                      )
                    ),
                    child: Row(
                      children: [
                        Radio(
                  value: sex[0],
                  groupValue: currentsex,
                  onChanged: (value) {
                    setState(() {
                      currentsex = value.toString();
                      
                    });
                    
                  },
                ),
        
                const Text('Homme', style: TextStyle(
                  fontSize: 16,
                ),)
                      ],
                    ),
                  ),
        
        
                  Container(
                    width: 160,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(
                        width: 1,
                        color: Colors.grey
                      )
                    ),
                    child: Row(
                      children: [
                        Radio(
                  value: sex[1],
                  groupValue: currentsex,
                  onChanged: (value) {
                    setState(() {
                      currentsex = value.toString();
                      
                    });
                    
                  },
                ),
        
                const Text('Femme', style: TextStyle(
                  fontSize: 16,
                ),)
                      ],
                    ),
                  )
                ],
              ),
        
              
              const SizedBox(height: 25,),
              TitleForm(title: 'Zone de résidence'),
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



          ////////////////////////////////////////////////////////////////////////////
          

          const SizedBox(height: 35,),
          InkWell(
                 onTap: ()  {
                            Navigator.of(context).pushNamed('/Home');
                            validater();
                            },
                       child: Container(
                       height: 50,
                       decoration: BoxDecoration(
                         color: ColorApp.secondaryColor,
                         borderRadius: BorderRadius.circular(8)
                       ),
                       child: const Center(
                         child: Text('Terminer',
                         style: TextStyle(
                           color: Colors.white,
                           fontSize: 15,
                           fontWeight: FontWeight.bold,
                                    
                         ), ),
                       ),
                                      ),
                                     ),
                    const SizedBox(height: 25,)
            ],
            
          )),
        ),
      ),
    );
  }
}