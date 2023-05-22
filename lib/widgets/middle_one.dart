import 'package:event_room/colors.dart';
import 'package:event_room/widgets/title_form.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import 'package:event_room/providers/objets/form_helper.dart';
import 'package:event_room/providers/models/evenement.dart';

class MiddleOne extends StatefulWidget {
  const MiddleOne({super.key});

  @override
  State<MiddleOne> createState() => _MiddleOneState();
}
List <String> date = ['unique', 'plusieurs'];

class _MiddleOneState extends State<MiddleOne> {
  final _formKey3 = GlobalKey<FormState>();
  String currentdate = date[0];
  TextEditingController dateController= TextEditingController();
  TextEditingController timeController= TextEditingController();
  TextEditingController dateControllerfin= TextEditingController();
  TextEditingController timeControllerfin= TextEditingController();
  bool isunique = true;
  bool ismultiple = false;
  DateTime annee = DateTime.now();
  DateTime heure = DateTime.now();
  DateTime anneefin = DateTime.now();
  DateTime heurefin = DateTime.now();
  
  void validater(){
   if(_formKey3.currentState!.validate()){
    _formKey3.currentState?.save();
    Provider.of<Evenement>(context, listen: false).isDateUnique = currentdate == date[0]? true: false;
    Provider.of<Evenement>(context, listen: false).heures = {
  'Depart': {
  'date': annee.toString(),
  'heure': heure.toString(),},
       
       'fin': {
      'date': anneefin.toString(),
      'heure': heurefin.toString(),
      } 
    };
    //Provider.of<Evenement>(context, listen: false).saveData();
   }
   
  }

  @override
  Widget build(BuildContext context) {
    double values = Provider.of<FormHelper>(context).values;
    return Column(
      children: [
         const Text('Entrez les dates de votre évènement',
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
      key:  _formKey3,
      child: Column(
      children: [
        ListTile(
              title: const Text('Date unique'),
              leading: Radio(
                value: date[0],
                groupValue: currentdate,
                onChanged: (value) {
                  setState(() {
                    currentdate = value.toString();
                    isunique = true;
                    ismultiple = false;
                  });
                  
                },
              ),
             ),

             ListTile(
              title: const Text('Plusieurs dates séparées'),
              leading: Radio(
                value: date[1],
                groupValue: currentdate,
                onChanged: (value) {
                  setState(() {
                    currentdate = value.toString();
                    isunique = false;
                    ismultiple = true;
                  });
                  
                },
                
              ),
             ),

             const SizedBox(height: 20,),

             Visibility(
            visible: isunique,  
            child: Column(
              children: [


                TitleForm(title: 'Date de début'),
               Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                    width: 1,
                    color: ColorApp.secondaryColora2,
                  )
                ),
                 child: Column(
                   children: [
                     TextFormField(
                           controller: dateController,
                           keyboardType: TextInputType.datetime,
                           readOnly: true,
                           decoration: InputDecoration(
                             hintText: "Début de l'évènement",
                             prefixIcon: Icon(FluentSystemIcons.ic_fluent_calendar_filled),
                             suffixIcon: Icon(FeatherIcons.chevronDown),
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
                      
                      minTime: DateTime.now(),
                      maxTime: DateTime(2035, 1, 1),
                      
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

                           const SizedBox(height: 10,),

       TextFormField(
        controller: timeController,
        keyboardType: TextInputType.datetime,
        readOnly: true,
        decoration: InputDecoration(
          hintText: "Date de début",
          prefixIcon: Icon(FluentSystemIcons.ic_fluent_clock_filled),
          suffixIcon: Icon(FeatherIcons.chevronDown),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 0.7,
              color: Color.fromARGB(50, 158, 158, 158),
            )
          )
        ),
        onTap: () {
          DatePicker.showTimePicker(context, showTitleActions: true,locale: LocaleType.fr,
                      onChanged: (date) {
                    print('change $date in time zone ' +
                        date.timeZoneOffset.inHours.toString());
                        heure = date;

                  }, onConfirm: (date) {
                    print('confirm $date');
                    timeController.text = date.hour.toString() + ':' + date.minute.toString();
                  }, currentTime: DateTime.now());
        },
       ),
                   ],
                 ),
               ),

          const SizedBox(height: 25,),
/////////////////////////////////////////////////////////////////////////


TitleForm(title: 'Date de fin'),
               Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                    width: 1,
                    color: ColorApp.secondaryColora2,
                  )
                ),
                 child: Column(
                   children: [
                     TextFormField(
                           controller: dateControllerfin,
                           keyboardType: TextInputType.datetime,
                           readOnly: true,
                           decoration: InputDecoration(
                             hintText: "Fin de l'évènement",
                             prefixIcon: Icon(FluentSystemIcons.ic_fluent_calendar_filled),
                             suffixIcon: Icon(FeatherIcons.chevronDown),
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
                      
                      minTime: DateTime.now(),
                      maxTime: DateTime(2035, 1, 1),
                      
                      onChanged: (date) {
                    print('change $date in time zone ' +
                        date.timeZoneOffset.inHours.toString());
                        anneefin = date;
                  }, onConfirm: (date) {
                    print('confirm $date');
                    dateControllerfin.text = date.day.toString() + '/' + date.month.toString() + '/' + date.year.toString();
                  }, currentTime: DateTime.now(), locale: LocaleType.fr);
                           },
                          ),

                           const SizedBox(height: 10,),

       TextFormField(
        controller: timeControllerfin,
        keyboardType: TextInputType.datetime,
        readOnly: true,
        decoration: InputDecoration(
          hintText: "Date de fin",
          prefixIcon: Icon(FluentSystemIcons.ic_fluent_clock_filled),
          suffixIcon: Icon(FeatherIcons.chevronDown),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 0.7,
              color: Color.fromARGB(50, 158, 158, 158),
            )
          )
        ),
        onTap: () {
          DatePicker.showTimePicker(context, showTitleActions: true,locale: LocaleType.fr,
                      onChanged: (date) {
                    print('change $date in time zone ' +
                        date.timeZoneOffset.inHours.toString());
                        heurefin = date;
                  }, onConfirm: (date) {
                    print('confirm $date');
                    timeControllerfin.text = date.hour.toString() + ':' + date.minute.toString();
                  }, currentTime: DateTime.now());
        },
       ),
                   ],
                 ),
               ),
      
              ],
            )
            ),


            Visibility(
              visible: ismultiple,
              child: Center(
                child: Column(
                  children: [
                    
                    Text('image ici'),
                  ],
                ),)),
            
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
                  onPressed: () {
                    
                  Provider.of<FormHelper>(context, listen: false).suivantmoin();
                  
                  }, 
                  child: const Text('Retour', style: TextStyle(
                   color: Colors.grey
                  ),)),
                )
      ],
    )
    )


      ],
    );
  }
}