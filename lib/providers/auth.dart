import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_room/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';


class Auth with ChangeNotifier{
  static UserCredential? authResult;
  static DocumentReference<Map<String, dynamic>> firestore = FirebaseFirestore.instance.collection('users').doc(authResult?.user?.uid );
  
  FirebaseAuth auth = FirebaseAuth.instance;
  
  Future<void> Login(String code, String number) async {
  await FirebaseAuth.instance.verifyPhoneNumber(
  phoneNumber: '${code + number}',
  verificationCompleted: (PhoneAuthCredential credential) {},
  verificationFailed: (FirebaseAuthException e) {},
  codeSent: (String verificationId, int? resendToken) {
   LoginPage.verify = verificationId;
  },
  codeAutoRetrievalTimeout: (String verificationId) {},
);
  }

  Future<void> Verify(String verifyId, String smsCod) async {

    try{
      // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verifyId, smsCode: smsCod);

    // Sign the user in (or link) with the credential
    authResult = await auth.signInWithCredential(credential);
     
    print('${authResult} rengo');
   
    }

    catch(e){
     print('error');
    }

   

  }
}