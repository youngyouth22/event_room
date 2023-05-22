import 'package:event_room/colors.dart';
import 'package:flutter/material.dart';


class CategorieChips extends StatefulWidget {
  const CategorieChips({super.key});

  @override
  State<CategorieChips> createState() => _CategorieChipsState();
}

class _CategorieChipsState extends State<CategorieChips> {
   int _selectedIndex = 0;
  List<String> _options = ['Toutes les catégories', 'Option 2', 'Option 3', 'Option 4'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
     child: ListView.builder(
  scrollDirection: Axis.horizontal,
  itemCount: _options.length,
  itemBuilder: (BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ChoiceChip(
        labelStyle: TextStyle(color: _selectedIndex == index ? Colors.white :Colors.black45, fontSize: 14),
        labelPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        selectedColor: ColorApp.secondaryColor,
        backgroundColor: ColorApp.secondaryColora2,
        label: Text(_options[index], style: const TextStyle(fontWeight: FontWeight.bold),),
        selected: _selectedIndex == index,
        onSelected: (bool selected) {
          setState(() {
            _selectedIndex = (selected ? index : null)!;
          });
        },
      ),
    );
  },
),
    );
  }
}