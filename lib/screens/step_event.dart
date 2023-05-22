import 'package:event_room/colors.dart';
import 'package:event_room/widgets/lastone.dart';
import 'package:event_room/widgets/firstone.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:ai_progress/ai_progress.dart';

import '../widgets/middle_one.dart';
import '../widgets/segond.dart';
import 'package:provider/provider.dart';
import 'package:event_room/providers/objets/form_helper.dart';

class StepEvent extends StatefulWidget {
  const StepEvent({super.key});
  static const routeName = '/StepEvent';
  @override
  State<StepEvent> createState() => _StepEventState();
}

class _StepEventState extends State<StepEvent> {
  
  bool firstOneView = true;
  bool segondOneView = false;
  bool middleOneView = false;
  bool lastOne = false;
  double values = 25;


   void suivantPlus (){
       if(values <100){
     setState(() {
      values += 25;
    });
    }

    
    switch(values.toInt()){
      case 25:
      setState(() {
        lastOne = false;
       middleOneView = false;
        firstOneView = true;
        segondOneView = false;
      }); break;

      case 50:
      setState(() {
        lastOne = false;
       middleOneView = false;
        firstOneView = false;
        segondOneView = true;
      }); break;
      
      case 75:
      setState(() {
        lastOne = false;
        firstOneView = false;
        segondOneView = false;
        middleOneView = true;
      });break;

      case 100:
      setState(() {
         firstOneView = false;
        segondOneView = false;
        middleOneView = false;
        lastOne = true;
      });
    }
  }

  void suivantmoin (){
       if(values !=25){
     setState(() {
      values -= 25;
    });
    }

    
    switch(values.toInt()){
      case 25:
      setState(() {
        lastOne = false;
       middleOneView= false;
        firstOneView = true;
        segondOneView = false;
      }); break;

      case 50:
      setState(() {
      lastOne = false;
       middleOneView = false;
        firstOneView = false;
        segondOneView = true;
      }); break;
      
      case 75:
      setState(() {
        lastOne = false;
       firstOneView = false;
        segondOneView = false;
        middleOneView = true;
      });break;

      case 100:
      setState(() {
         firstOneView = false;
        segondOneView = false;
        middleOneView = false;
        lastOne = true;
      });
    }
  }

  
  
 //int _segmentValue = 1;
  @override
  Widget build(BuildContext context) {
    double values = Provider.of<FormHelper>(context).values;
    return WillPopScope(
      onWillPop: () async {
        Provider.of<FormHelper>(context, listen: false).resetValue();
        return true;
      },
      child: Scaffold(
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
        body:Stack(
          
          children: [
            Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                        const SizedBox(height: 10,),
                    
                         Visibility(
                          maintainState: true,
                          visible: Provider.of<FormHelper>(context).values == 25? true : false,
                           child: Padding(
                             padding: const EdgeInsets.all(20),
                             child: FirstOne(suivant: ()=>print('salut Rengo')),
                           ),
                         ),
    
                         Visibility(
                          maintainState: true,
                          visible: Provider.of<FormHelper>(context).values == 50? true : false,
                          child: const Padding(
                            padding: EdgeInsets.all(20),
                            child: SegondOne(),
                          )),
    
                          Visibility(
                            maintainState: true,
                            visible: Provider.of<FormHelper>(context).values == 75? true : false,
                            child: const Padding(
                            padding: EdgeInsets.all(20),
                            child: MiddleOne(),
                          )),
    
    
                          Visibility(
                            maintainState: true, 
                          visible: Provider.of<FormHelper>(context).values == 100? true : false,
                          child: const Padding(
                            padding: EdgeInsets.all(20),
                            child: PhotoSelect(),
                          )),
    
    
                
                  ],
                ),
              ),
            ),
            Container(
                                height: MediaQuery.of(context).size.height * 0.0,
                                child: Container(
                                          width: double.infinity,
                                          height: 0,
                                          child: AirLinearStateProgressIndicator(
                                            shouldRepaint: true,
                                            size: Size(150, 150),
                                            value: Provider.of<FormHelper>(context).values,
                                            //_segmentValue / 10 * 100, //1~100
                                            valueColor:ColorApp.secondaryColor,
                                            
                                            pathStrokeWidth: 10.0,
                                            valueStrokeWidth: 10.0,
                                            roundCap: false,
                                          ),
                                        ),
                              ),
          ],
        ),
      ),
    );
  }
}