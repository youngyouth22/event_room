import 'package:event_room/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:event_room/colors.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:event_room/providers/auth.dart';


class ConfirmCode extends StatefulWidget {
  static const routeName = '/confirmation';
  const ConfirmCode({super.key});

  @override
  State<ConfirmCode> createState() => _ConfirmCodeState();
}

class _ConfirmCodeState extends State<ConfirmCode> {

  Future<void> valider() async{

  await Provider.of<Auth>(context, listen: false).Verify(LoginPage.verify, code) ;
  Navigator.of(context).pushNamed('/userCreat');
   
  }

var code ="";
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
  decoration: BoxDecoration(
    border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
    borderRadius: BorderRadius.circular(8),
  ),
);

final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
  borderRadius: BorderRadius.circular(8),
);

final submittedPinTheme = defaultPinTheme.copyWith(
  decoration: defaultPinTheme.decoration?.copyWith(
    color: Color.fromRGBO(234, 239, 243, 1),
  ),
);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Lottie.asset('assets/animations/95741-verify-code.json',
                height: 220,),
            
                Text("Vérification", 
                         style: TextStyle(
                          color: ColorApp.secondaryColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                         ),),
                      
                         const SizedBox(
                          height: 20,
                         ),
                      
                         Text("Entrez le code envoyé par sms au numéro ci-dessous:", textAlign: TextAlign.center, 
                         style: TextStyle(
                          color: ColorApp.segondTextColor,
                          fontSize: 14,
                          height: 1.4,
                          fontWeight: FontWeight.bold
                         ),),
                      
                         const SizedBox(
                          height: 20,
                         ),
                      
                        const Text("+237 697655645", 
                         style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17,
                          height: 1.4,
                          fontWeight: FontWeight.bold
                         ),), 
                      
                        const SizedBox(
                          height: 20,
                         ),
                         //////////////////////////////////////////////////////////////////////
                         ///
                
                Pinput(
              length: 6,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: focusedPinTheme,
              submittedPinTheme: submittedPinTheme,
              onChanged: (value) {
                code = value;
              },
              validator: (s) {
                return s == '222222' ? null : 'Le code est incorrect';
              },
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              showCursor: true,
              onCompleted: (pin) => print(pin),
                      ),
                      ////////////////////////////////////////////////////
                      
                  const SizedBox(
                          height: 30,
                         ),
                      
               InkWell(
                onTap: valider,
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: ColorApp.secondaryColor,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: const Center(
                    child: Text('Vérifier',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
              
                    ), ),
                  ),
                ),
                       ),
              ],),
            ),
          )
        ),
      ),
    );
  }
}