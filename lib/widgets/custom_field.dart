import 'package:event_room/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './text_style.dart';

Widget CustomField({
  required String hintTxt,
  required IconData image,
  required TextEditingController? controller,
  bool isObs = false,
  TextInputType? keyBordType,
}) {
  return Container(
    height: 65.0,
    padding: const EdgeInsets.symmetric(horizontal: 30.0),
    margin: EdgeInsets.symmetric(
      vertical: 10.0,
    ),
    decoration: BoxDecoration(
      color: ColorApp.secondaryColora2,
      borderRadius: BorderRadius.circular(20.0),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 270.0,
          child: TextField(
            textAlignVertical: TextAlignVertical.center,
            obscureText: isObs,
            keyboardType: keyBordType,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintTxt,
              hintStyle: hintStyle,
            ),
            style: headline2,
          ),
        ),
        Icon(
          image,
          size: 20,
          color: Colors.grey,
        )
      ],
    ),
  );
}
