import 'package:event_room/widgets/middle_one.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';

class ProcheAffiche extends StatelessWidget {
  
  final String image;
  final String nom;
  final String categorie;
  final String ville;
  final String pays;
  //final String date2;

   ProcheAffiche({
    required this.image,
    required this.nom,
    required this.categorie,
    required this.ville,
    required this.pays,
    //required this.date2

   });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1/1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(children: [
          FastCachedImage(url: image,
                      width: double.infinity,
                      fadeInDuration: const Duration(seconds: 1),
                      fit: BoxFit.cover),
          Positioned.fill(child:
           DecoratedBox(
            decoration: BoxDecoration(gradient: 
            LinearGradient(
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.6)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.6, 0.95]
              )),
            )
           ),

           Align(
            alignment: Alignment.bottomLeft,
             child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(nom, style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),),
                  subtitle: Text('${pays}, ${ville}',
                                        style: const TextStyle(
                                           color: Colors.white
                                        ),),
                )
              ],
             ),
           ),

           Padding(
             padding: const EdgeInsets.all(15),
             child: Align(
              alignment: Alignment.topRight,
               child: Container(
                height: 60,
                width: 55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('21',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.bold
                    ),),

                    const SizedBox(height: 5,),

                    Text('DEC',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.black.withOpacity(0.7),
                    ),
                    )
                  ],
                ),
               ),
             ),
           )
        ]),
      ),
    );
  }
}