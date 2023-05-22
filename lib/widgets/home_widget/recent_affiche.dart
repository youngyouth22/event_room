import 'package:event_room/colors.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fluentui_icons/fluentui_icons.dart';

class RecentAffiche extends StatelessWidget {
  final String image;
  final String nom;
  final String ville;
  final String pays;
  final String categorie;
  final bool isgratuit;
  RecentAffiche({
    required this.image,
    required this.nom,
    required this.ville,
    required this.pays,
    required this.categorie,
    this.isgratuit = false
  });

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => buildsheet(),
    );
  }

  Widget makeDismissible({required Widget child}) => Builder(
    builder: (context) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(onTap: () {}, child: child,),
      );
    }
  );

  Widget buildsheet () => makeDismissible(
    child: DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.9,
        builder: (_, controller) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))
          ),
          child: ListView(
            controller: controller,
            children: [
              Center(child: 
              Container(
                width: 35,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10)
                ),

              ),),
              
              const SizedBox(height: 8,),

                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  leading: ClipRRect(
                  child: Container(
                    width: 55,
                    height: 55,
                    child: FastCachedImage(url: image,
                      fadeInDuration: const Duration(seconds: 1),
                      fit: BoxFit.cover),
                  ),
                ),

                title:  Text(nom ,textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                          
                            ),),

                subtitle: Text('${pays}, ${ville}',
                                      style: const TextStyle(
                                         color: Colors.grey
                                      ),),
                ),

                const Expanded(child: Divider()),

                ListTile(
                   contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                  leading: const Icon(FeatherIcons.heart, size: 25),
                  title: Text('Liker' ,textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              overflow: TextOverflow.ellipsis,
                          
                            ),),
                  onTap: () => null,
                ),


                ListTile(
                   contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                  leading: const Icon(FeatherIcons.minusCircle, size: 25),
                  title: Text('Masquer' ,textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              overflow: TextOverflow.ellipsis,
                          
                            ),),
                  onTap: () => null,
                ),


              ListTile(
                   contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                  leading: const Icon(FeatherIcons.user, size: 25),
                  title: Text("Infos sur l'organisateur" ,textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              overflow: TextOverflow.ellipsis,
                          
                            ),),
                  onTap: () => null,
                ),

              ListTile(
                   contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                  leading: const Icon(FeatherIcons.share2, size: 25),
                  title: Text('Partager' ,textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              overflow: TextOverflow.ellipsis,
                          
                            ),),
                  onTap: () => null,
                ),

              ListTile(
                   contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                  leading: const Icon(FeatherIcons.flag, size: 25),
                  title: Text('Signaler' ,textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              overflow: TextOverflow.ellipsis,
                          
                            ),),
                  onTap: () => null,
                ),


            ],
          ),
        )
    ),
  );

  

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
           // width: double.infinity,
            //color: Colors.red,
             child: Row(
              children: [
                ClipRRect(
                  child: Container(
                    width: 100,
                    height: 100,
                    child: FastCachedImage(url: image,
                      fadeInDuration: const Duration(seconds: 1),
                      fit: BoxFit.cover),
                  ),
                ),
    
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Container(
                     alignment: Alignment.centerLeft,
                      //width: MediaQuery.of(context).size.width * 0.7,
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(nom ,textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                          
                            ),),
                          ),
                        
                   const SizedBox(height: 4,),
                           
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text('${pays}, ${ville}',
                                      style: const TextStyle(
                                         color: Colors.grey
                                      ),),
                        ),
    
                        const SizedBox(height: 4,),
                           
                        Container(
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width * 0.47,
                          child: Text(categorie,
                                      style: const TextStyle(
                                         color: Color.fromARGB(221, 34, 33, 33),
                                         fontWeight: FontWeight.bold,
                                         fontSize: 13,
                                         overflow: TextOverflow.ellipsis
                                      ),),
                        ),
    
                        const SizedBox(height: 4,),
    
                        Container(
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  shape: BoxShape.rectangle,
                                  color: ColorApp.secondaryColora2
                                ),
                                child: const Padding(
                                  padding:  EdgeInsets.all(4),
                                  child: Text('GRATUIT', style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54
                                  ),),
                                ),
                              )
                            ],
                          ),
                        )
                        ],
                      ),
                      
                    ),
              ),  
              ],
            ),
          ),

          IconButton(onPressed: () {
          _showBottomSheet(context);
            },
          icon: const Icon(FeatherIcons.moreVertical, color: Colors.grey,))
        ],
      ),
    );
  }
}