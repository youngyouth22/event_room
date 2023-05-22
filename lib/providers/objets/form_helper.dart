import 'package:flutter/material.dart';
import 'package:event_room/providers/models/evenement.dart';

class FormHelper with ChangeNotifier {
  double values = 25;
  

  void suivantPlus (){
       if(values <100){
      values += 25;
    notifyListeners();
    }}

      void suivantmoin (){
       if(values != 25){
      values -= 25;
    notifyListeners();
    }}

    void resetValue () {
      values = 25;
      notifyListeners();
    }

}