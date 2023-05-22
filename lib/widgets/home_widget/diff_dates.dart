import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class DiffDates extends StatelessWidget {
  final String eventId;

  DiffDates(@required this.eventId);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
      stream: FirebaseFirestore.instance
        .collection('evenement')
        .doc(eventId)
        .collection('dates')
        .snapshots(),
      builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return ListView.builder(
          scrollDirection: Axis.horizontal,
        itemCount: snapshot.data!.docs.length,
        itemBuilder: (BuildContext context, int index) {
         DocumentSnapshot date = snapshot.data!.docs[index];
        Map<String, dynamic> dates = snapshot.data!.docs[index].get('debut');

        return Container(
                    height: 70,
                    width: 70,
                    color: Colors.red,
                    child: Text(dates['date']),
                    //subtitle: Text(date['fin'].toString()),
                  );
        },
      );
      },
    ),
    );

  }
}