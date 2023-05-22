import 'package:event_room/providers/models/evenement.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';


class Evenements with ChangeNotifier {
  


  List<Evenement> _ListeEvent = [];

  
  List <Evenement> get ListeEvent{
     return [..._ListeEvent];
  }

  void setEvent(List<Evenement> ListeEvent) {
    _ListeEvent = ListeEvent;
    notifyListeners();
  }
}




















