
import 'package:event_room/colors.dart';
import 'package:event_room/providers/models/user.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:event_room/widgets/custom_field.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:event_room/providers/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';




class LoginPage extends StatefulWidget {
  static const routeName = '/Connection';
  static String verify = "";
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
FirebaseAuth auth = FirebaseAuth.instance;
String phone ='697723146';
UserCredential? authResult;
  Future<void> valider() async{

  await Provider.of<Auth>(context, listen: false).Login('+237', _phone.text);
  Navigator.of(context).pushNamed('/confirmation');
 
  }


  /////////////////////////////////////////////////////////////////////////////////////////////////////////////

  showCountryPicker2(){
    showCountryPicker(
  context: context,
  favorite: ['CM'],
  countryListTheme: const CountryListThemeData(
    flagSize: 25,
    backgroundColor: Colors.white,
    textStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
    bottomSheetHeight: 500, // Optional. Country list modal height
    //Optional. Sets the border radius for the bottomsheet.
      borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20.0),
      topRight: Radius.circular(20.0),
    ),
    //Optional. Styles the search field.
    inputDecoration: InputDecoration(
      hintText: 'Entrer le nom ou le code du pays',
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromARGB(76, 33, 149, 243)
        )
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromARGB(43, 158, 158, 158)
        )
      ),
      prefixIcon: Icon(FeatherIcons.globe),
      
    ),
  ),
  onSelect: (country) {
    chooseCountryController.text = country.name;
    countryCode.text = country.countryCode; 
  },
);


  }

  TextEditingController countryCode = TextEditingController();
  TextEditingController chooseCountryController = TextEditingController();
  TextEditingController _phone = TextEditingController();
  var code = '237';
  @override
  void initState() {
    // TODO: implement initState
    countryCode.text = "+000";
     
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     PageConfirmation(BuildContext ctx){
    Navigator.of(ctx).pushNamed('/confirmation');
  }
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Container(
              child: Form(
                key: null,
                child: Column(
                  
                  children: [
                    Lottie.asset('assets/animations/136184-clown-juggling-on-unicycle.json',
                height: 220,),
                      Text("Entrez votre numéro", 
                     style: TextStyle(
                      color: ColorApp.secondaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                     ),),
                     const SizedBox(
                      height: 20,
                     ),
                     Text("Event Room vous envoyera un message de confirmation pour s'assurer que le numéro entré est bien le votre.", 
                     style: TextStyle(
                      color: ColorApp.segondTextColor,
                      fontSize: 12,
                      height: 1.4,
                      fontWeight: FontWeight.bold
                     ),),
          
                     const SizedBox(
                      height: 20,
                     ),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                border: Border.all(width: 2, color: ColorApp.secondaryColora2),
                borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                      
                      const SizedBox(width: 20,
                      ),
                      Expanded(child: TextField(
                        onTap: showCountryPicker2,
                        readOnly: true,
                        controller: chooseCountryController,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Choisit ton pays",
                            alignLabelWithHint: false,
                            //suffixIcon: Icon(FeatherIcons.chevronDown),
                          ),
                          keyboardType: TextInputType.number,
                      )
                      ),
                      const SizedBox(width: 10,),
                      const SizedBox(
                        width: 40,
                        child: TextField(
                          readOnly: true,
                          decoration:  InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: Icon(FeatherIcons.chevronDown),
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                      ],),
                    ),
                    const SizedBox(height: 30,),
                    ////////////////////////////
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                border: Border.all(width: 2, color: ColorApp.secondaryColora2),
                borderRadius: BorderRadius.circular(10)),
                      child: Row(children: [
                       const SizedBox(width: 10,),
                       SizedBox(
                        width: 40,
                        child: TextField(
                          controller: countryCode,
                          readOnly: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                     const SizedBox(width: 10,),
                      Text("|", 
                      style: TextStyle(
                        fontSize: 33,
                       color: ColorApp.secondaryColora2,
                      ),),
                      const SizedBox(width: 10,),
                       Expanded(child: TextField(
                        controller: _phone,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            
                            hintText: "Phone"
                          ),
                          keyboardType: TextInputType.number,
                      )
                      ),
                      ],),
                    ),
          
                    
                    const SizedBox(height: 50,),
                    InkWell(
            onTap: () { 
              valider();
              Provider.of<UserC>(context, listen: false).number = _phone.text;
             print('${authResult} rengo');
             Navigator.of(context).pushNamed('/confirmation');
              },
            
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                color: ColorApp.secondaryColor,
                borderRadius: BorderRadius.circular(15)
              ),
              child: const Center(
                child: Text('Se connecter',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
          
                ), ),
              ),
            ),
                   ),
                  ],
                ),
              )
                ),
          ),
        ),
        ),

      );
    
  }
}