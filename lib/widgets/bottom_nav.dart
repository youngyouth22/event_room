import 'package:event_room/colors.dart';
import 'package:event_room/screens/chat_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../screens/home.dart';
import '../screens/parametre.dart';
import '../screens/proches_event.dart';


class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});
  static const routeName = '/Home';

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;
  List<Widget> body = const[
    HomePage(),
    ProcheEvent(),
    Icon(Icons.home),
    ChatGroup(),
    Parametre(),
  ];
  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      body: Center(child: body[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: ColorApp.secondaryColor,
        unselectedItemColor: ColorApp.segondTextColor,
        showSelectedLabels: false,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(FluentSystemIcons.ic_fluent_home_filled)
           ),

           BottomNavigationBarItem(
            label: 'Proche',
            icon: Icon(FontAwesome5.compass)
           ),

           BottomNavigationBarItem(
            label: 'Ticket',
            icon: Icon(FluentSystemIcons.ic_fluent_ticket_filled)
           ),

           BottomNavigationBarItem(
            label: 'chat',
            icon: Icon(FluentSystemIcons.ic_fluent_chat_filled)
           ),

           BottomNavigationBarItem(
            label: 'User',
            icon: Icon(FluentSystemIcons.ic_fluent_person_filled)
           ),
           
        ],
      ),
    );
  }
}