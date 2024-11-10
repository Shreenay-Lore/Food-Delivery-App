import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/auth/controllers/phone_verification_controller.dart';
import 'package:get/get.dart';

class VerificationService{
  final PhoneVerificationController controller = Get.put(PhoneVerificationController());
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyPhoneNumber (
    String phoneNumber,
    {required Null Function(String verificationId, int? resendToken) codeSend}
  ) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential  credentials) async {
        controller.phoneVerificationFunction();
      }, 
      verificationFailed: (FirebaseAuthException e) {
        debugPrint(e.toString());
      }, 
      //timeout: const Duration(seconds: 60),
      codeSent: (String verificationId, int? resendToken) {
        codeSend(verificationId, resendToken);
      }, 
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void>  verifySmsCode(String verificationId, String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    await _auth.signInWithCredential(credential).then((value){
      controller.phoneVerificationFunction();
    });
  }


}