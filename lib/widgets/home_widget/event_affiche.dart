import 'package:flutter/material.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';

class EventAffiche extends StatelessWidget {
  final String image;
  final String nom;
  final String ville;
  final String pays;
  EventAffiche(this.image, this.nom, this.ville, this.pays);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 180,
      //color: Colors.green,
      child: Column(
        children: [
          ClipRRect(
            child: Container(
                height: 180,
                width: 180,
                color: Colors.grey.withOpacity(0.08),
                child: FastCachedImage(url: image,
                fadeInDuration: const Duration(seconds: 1),
                fit: BoxFit.cover),
            ),
          ),

          const SizedBox(height: 12,),

          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
            width: double.infinity,
            child: Text(nom, style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.black87
            ),)
            ),
          ),

          Row(children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 4),
              child: Text('${pays}, ${ville}',
              style: const TextStyle(
                 color: Colors.grey
              ),),
            )
          ],),

          // Padding(
          //   padding: const EdgeInsets.only(left: 10, top: 4),
          //   child: Row(
          //     children: [
          //       CircleAvatar(
          //         backgroundColor: Colors.grey[300],
          //         radius: 16,
          //       ),

          //       Text('User Name')
          //     ],
          //   ),
          // )
        ],
      ),

    );
  }
}