import 'package:flutter/material.dart';

import '../colors.dart';

class ChatGroup extends StatelessWidget {
  const ChatGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white.withOpacity(0),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset('assets/illustrations/puffy-group-of-characters-working-in-a-team.png',),
            )),

            Container(
              padding: const EdgeInsets.all(20),
              child: Text("Vous n'êtes dans aucun groupe de discussion",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                height: 1.4,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.7)
              ),),
            ),

             Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text("Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                height: 1.4,
                fontWeight: FontWeight.w400,
                color: Colors.black54
              ),),
            ),

             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
               child: InkWell(
                         onTap: () { 
               //Navigator.of(context).pushNamed('/confirmation');
                },
                         
                         child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: ColorApp.secondaryColor,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: const Center(
                  child: Text('évènements proche de vous',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                       
                  ), ),
                ),
                         ),
                     ),
             ),
          ],
        ),
      ),
    );
  }
}