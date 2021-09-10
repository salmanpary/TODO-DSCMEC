import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:todo/pages/homepage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Authclass {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  FirebaseAuth auth = FirebaseAuth.instance;
  final storage = new FlutterSecureStorage();
  Future<void> googlesignin(BuildContext context) async {
    try {
      GoogleSignInAccount googlesigninaccount = await _googleSignIn.signIn();
      if (googlesigninaccount != null) {
        GoogleSignInAuthentication googlesigninauthentication =
            await googlesigninaccount.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googlesigninauthentication.idToken,
          accessToken: googlesigninauthentication.accessToken,
        );
        try {
          UserCredential userCredential =
              await auth.signInWithCredential(credential);
          storeTokenandData(userCredential);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => HomePage()),
              (route) => false);
        } catch (e) {
          final snackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      } else {
        final snackbar = SnackBar(content: Text("not able to sign in"));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    } catch (e) {
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
  Future<void> signInwithPhoneNumber(
      String verificationId, String smsCode, BuildContext context) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);

      UserCredential userCredential =
      await auth.signInWithCredential(credential);
      storeTokenAndData(userCredential);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => HomePage()),
              (route) => false);

      showSnackBar(context, "logged In");
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
  void storeTokenAndData(UserCredential userCredential) async {
    print("storing token and data");
    await storage.write(
        key: "token", value: userCredential.credential.token.toString());
    await storage.write(
        key: "usercredential", value: userCredential.toString());
  }
  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


  Future<void> storeTokenandData(UserCredential userCredential) async {
    await storage.write(
        key: "token", value: userCredential.credential.token.toString());
    await storage.write(
        key: "userCredential",
        value: userCredential.credential.token.toString());
  }

  Future<String> gettoken() async {
    return await storage.read(key: "token");
  }
  Future<void> verifyPhoneNumber(
      String phoneNumber, BuildContext context, Function setData) async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      showSnackBar(context, "Verification Completed");
    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) {
      showSnackBar(context, exception.toString());
    };
    PhoneCodeSent codeSent =
        (String verificationID, [int forceResnedingtoken]) {
      showSnackBar(context, "Verification Code sent on the phone number");
      setData(verificationID);
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationID) {
      showSnackBar(context, "Time out");
    };
    try {
      await auth.verifyPhoneNumber(
          timeout: Duration(seconds: 60),
          phoneNumber: phoneNumber,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
  Future<void>logout()async{
    try{
      await _googleSignIn.signOut();
      await auth.signOut();
      await storage.delete(key: "token");

    }
    catch(e){

    }
  }
}
