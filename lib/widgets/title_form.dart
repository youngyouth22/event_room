import 'package:flutter/material.dart';

class TitleForm extends StatelessWidget {
  final String title;

  TitleForm({required this.title});
  // ignore: empty_constructor_bodies
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SizedBox(
        height: 25,
        child: Text(title,
        style: const TextStyle(
         fontSize: 15,
         fontWeight: FontWeight.bold
        ),),
      ),

    );
  }
}