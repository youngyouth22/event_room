import 'dart:io';

import 'package:event_room/colors.dart';
import 'package:event_room/helpers/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import '../widgets/title_form.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:textfield_tags/textfield_tags.dart';

class FormAddEvent extends StatefulWidget {
  const FormAddEvent({super.key});
  static const routeName = '/AddEvent';

  @override
  State<FormAddEvent> createState() => _FormAddEventState();
}

class _FormAddEventState extends State<FormAddEvent> {

  List<Step> stepList()=>[
    Step( state: _currentStepIndex <= 0?StepState.indexed: StepState.complete ,isActive: _currentStepIndex>=0, title: const Text('Infos'), content: const Center(child: FirstOne(),)),
    Step( state: _currentStepIndex <= 1?StepState.indexed: StepState.complete ,isActive: _currentStepIndex>=1, title: const  Text('Contact'), content: const Center(child: Price(),)),
    Step( state: _currentStepIndex <= 2?StepState.indexed: StepState.complete ,isActive: _currentStepIndex>=2, title: const Text('Photos'), content: const Center(child: PhotoSelect(),)),
  ];

  int _currentStepIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black87,
        ),
          title: const Text('Ajouter un évènement', style: TextStyle(
            color: Colors.black87, 
          ),),
          centerTitle: true,
          actions: const [
          IconButton(onPressed: null, icon: Icon(FeatherIcons.moreVertical))
          ],
      ),
      body: 
        Theme(
          data: ThemeData(
                  accentColor: ColorApp.pripmaryColor,
                  //primarySwatch: ColorApp.pripmaryColor,
                  colorScheme: ColorScheme.light(
                    primary: ColorApp.secondaryColor
                  )
                ),
          child: Stepper(
            controlsBuilder: (BuildContext context, 
            ControlsDetails controls) {
              return Column(children: [
                 const SizedBox(height: 15,),
                  InkWell(
                onTap: controls.onStepContinue,
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

               TextButton(onPressed: controls.onStepCancel, 
               child: const Text('Retour', style: TextStyle(
                color: Colors.grey
               ),))
              ],);
            },
            type: StepperType.horizontal,
            elevation: 0.4,
            currentStep: _currentStepIndex,
            steps: stepList(),
            onStepContinue: (){
             if(_currentStepIndex <(stepList().length-1)){
              _currentStepIndex +=1;
             }
        
             setState(() {
               
             });
            },
        
            onStepCancel: (){
             if(_currentStepIndex == 0){
              return;
             }
             _currentStepIndex -=1;
             setState(() {
               
             });
            },
            ),
        ),

     
    );
  }
}


class FirstOne extends StatefulWidget {
  const FirstOne({super.key});

  @override
  State<FirstOne> createState() => _FirstOneState();
}

class _FirstOneState extends State<FirstOne> {
  

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
          SelectedListItem(name: 'dance'),
          SelectedListItem(name: 'Music'),
 
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




  @override
  Widget build(BuildContext context) {
    return Container(child: 
   Column(
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
   Form(child:
   Column(
     children: [
      const SizedBox(height: 0,),
      TitleForm(title: 'Nom'),
       TextFormField(
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
         onTap: onTextFieldTap,
       ),
       
       const SizedBox(height: 25,),
       TitleForm(title: 'Description'),
       TextFormField(
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
       ),
       const SizedBox(height: 25,),
        
        /////////////////////////////////////////////////////////////////////////////////////
       TitleForm(title: 'Tags (Optionel)'),
       const SizedBox(height: 25,),
       

       TitleForm(title: 'Lieux'),
       CSCPicker(
        onCountryChanged: (country) {},
        onStateChanged: (state) {  },
        onCityChanged: (city) {},
       ),
     ],
   ),
   )
     ],
   ),

 
   );
  }
}


final imageHelper = ImageHelper();
class PhotoSelect extends StatefulWidget {
  const PhotoSelect({super.key});

  @override
  State<PhotoSelect> createState() => _PhotoSelectState();
}

class _PhotoSelectState extends State<PhotoSelect> {
  File? _image;
  List <File> _images = [];
  @override
  Widget build(BuildContext context) {
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
    
         SizedBox(height: 14,),
    
           const Text('Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.',
       style: TextStyle(
       fontSize: 15,
       fontWeight: FontWeight.w400,
       height: 1.5,
       color: Colors.black54
       ),),
       const SizedBox(height: 40,),
       
       ClipRRect(child: Stack(
       children: [
         Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
          color: Colors.grey[300],),
          child: _image !=null ?Image.file( _image!, fit: BoxFit.cover):null,
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
       child: Text('Ajoutez des photos(Optionel)'))
          ],
        ),
      ),
    );
  }
}


class Price extends StatefulWidget {
  const Price({super.key});

  @override
  State<Price> createState() => _PriceState();
}

class _PriceState extends State<Price> {

  void selectNumberTicket(){
    DropDownState(
      DropDown(
        isSearchVisible: false,
        bottomSheetTitle: const Text(
          'Type de billets',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        submitButtonChild: const Text(
          'Ok',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        data:  [
          SelectedListItem(
      name: 'Gratuit',
      value: "gratuit",
      isSelected: false,
    ),
    SelectedListItem(
      name: 'Normal',
      value: "normal",
      isSelected: false,
    ),
    SelectedListItem(
      name: 'Standard',
      value: "standard",
      isSelected: false,
    ),

    SelectedListItem(
      name: 'V.I.P',
      value: "vip",
      isSelected: false,
    ),
        ],
        selectedItems: (List<dynamic> selectedList) {
          List<String> list = [];
          for(var item in selectedList) {
            if(item is SelectedListItem) {
              list.add(item.name);
            }
          }
          // showSnackBar(list.toString());
          typeBilletController.text = list.toString();
        },
        enableMultipleSelection: true,
      ),
    ).showModal(context);
  }

TextEditingController typeBilletController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Text('Entrez plus de détail pour votre évènement',
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

       Form(child: Column(
        children: [
            TitleForm(title: 'Type de billets'),
       TextFormField(
        readOnly: true,
        controller: typeBilletController,
        
        keyboardType: TextInputType.name,
        decoration: InputDecoration(suffixIcon: const Icon(FeatherIcons.chevronDown),
          hintText: "Type de billets", 
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 0.7,
              color: Color.fromARGB(50, 158, 158, 158),
            )
          )
        ),
         onTap: selectNumberTicket,
       ),
        ],
       ))
        ],
      ),
    );
  }
}