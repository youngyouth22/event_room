import 'package:event_room/providers/models/dates.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import 'package:event_room/providers/models/evenement.dart';

import '../colors.dart';
import '../widgets/title_form.dart';


class AddDate extends StatefulWidget {
  static const routeName = '/addDate';
  const AddDate({super.key});

  @override
  State<AddDate> createState() => _AddDateState();
}

class _AddDateState extends State<AddDate> {
    final _formKeyDate = GlobalKey<FormState>();
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
   if(_formKeyDate.currentState!.validate()){
    _formKeyDate.currentState?.save();
    Provider.of<Dates>(context, listen: false).debut = 
   {
  'date': annee.toString(),
  'heure': heure.toString(),};

  Provider.of<Dates>(context, listen: false).fin = 
   {
  'date': anneefin.toString(),
  'heure': heurefin.toString(),};

    
   }
   }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKeyDate,
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

               const SizedBox(height: 30,),
      

      InkWell(
                                    onTap: ()  {
                                      validater();
                                      Provider.of<Dates>(context, listen: false).addDate('7CtzpLZBVDVbMEgT1Aj3');
                                      },
                                      child: Container(
                       height: 50,
                       decoration: BoxDecoration(
                         color: ColorApp.secondaryColor,
                         borderRadius: BorderRadius.circular(8)
                       ),
                       child: const Center(
                         child: Text('Ajouter la date',
                         style: TextStyle(
                           color: Colors.white,
                           fontSize: 15,
                           fontWeight: FontWeight.bold,
                                    
                         ), ),
                       ),
                                      ),
                                     ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}