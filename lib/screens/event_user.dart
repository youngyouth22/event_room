import 'package:event_room/colors.dart';
import 'package:flutter/material.dart';

import '../widgets/eventUser/orgas_event.dart';
import '../widgets/eventUser/partic_event.dart';

class EventUser extends StatelessWidget {
  const EventUser({super.key});
  static const routeName = '/EventUser';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('vos évènements'),
          titleTextStyle: const TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: const IconThemeData(
            color: Colors.black
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: ColorApp.secondaryColor,
            labelColor: ColorApp.secondaryColor,
            tabs: const [
              Tab(
                child: Text('que vous organisez'),
              ),
              Tab(
                child: Text('au quel vous participez'),
              ),
            ]),
        ),
        body: const TabBarView(
          children: [
            Organise(),
            Participe(),
          ]),
      ),
    );
  }
}