import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thundervolt/views/bottomnav.dart';

class OTPLoginVM {
  static OTPLoginVM instance = OTPLoginVM._();
  OTPLoginVM._();

  FirebaseAuth _auth = FirebaseAuth.instance;

  String? verificationIdh;
  String? phone;

  Future<void> verifyPhone(
      {int forceResend = 0,
      String smsCode = '',
      String phoneNumber = '',
      BuildContext? context}) async {
    try {
      print(phoneNumber);
      phone = phoneNumber;

      await _auth.verifyPhoneNumber(
          forceResendingToken: forceResend,
          phoneNumber: '+91${phoneNumber}', // PHONE NUMBER TO SEND OTP
          codeAutoRetrievalTimeout: (String verId) {
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
            verificationIdh = verId;
          },
          codeSent: (String verificationId, int? resendToken) {
            verificationIdh = verificationId;
            print('code sent-----');
            print(resendToken);
            print(verificationId);
          },
          // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
          timeout: const Duration(seconds: 60),
          verificationCompleted: (AuthCredential phoneAuthCredential) async {
            print('Verification Completed-----');
            print(phoneAuthCredential);
          },
          verificationFailed: (FirebaseAuthException exceptio) {
            Fluttertoast.showToast(
                msg: "Verification Failed",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black87,
                textColor: Colors.white,
                fontSize: 16.0);
            print('verification Failed-----');
            print('${exceptio.message}');
          });
    } on FirebaseAuthException catch (e) {
      print(e.message);
      handleError(e, context!);
    } catch (e) {
      print('error-----' + e.toString());
      // handleError(e, context!);
    }
  }

  handleError(FirebaseAuthException error, BuildContext context) {
    print(error);
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        print(error.code);
        Fluttertoast.showToast(
            msg: "Invalid verification code",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black87,
            textColor: Colors.white,
            fontSize: 16.0);
        break;

      default:
        print(error.message);
        Fluttertoast.showToast(
            msg: "Something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black87,
            textColor: Colors.white,
            fontSize: 16.0);
        break;
    }
  }

  signInWithOTP(String smsOTP, BuildContext context) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationIdh!,
        smsCode: smsOTP,
      );

      print('OTP When singinwithotp handler executes: $smsOTP');
      print('---------credentials');
      print(credential);
      final UserCredential authResult =
          await _auth.signInWithCredential(credential);

      if (authResult != null) {
        print('SignIn Successfully! ');
        print(authResult);

        Fluttertoast.showToast(
            msg: "Sign in success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black87,
            textColor: Colors.white,
            fontSize: 16.0);
        print('delay started');
        await Future.delayed(Duration(seconds: 3));
        print('delay ended');

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('remember', true);
        prefs.setString("phone", "8200879036");

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BottomNav()),
            (route) => false);
      } else {
        Fluttertoast.showToast(
            msg: "Sign in failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black87,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      // await UserDetails.instance.getUserDetails();
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      handleError(e, context);
    } catch (e) {
      print('error-----------' + e.toString());
      // handleError(e, context);
    }
  }
}
