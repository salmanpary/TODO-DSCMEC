

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/pages/signuppage.dart';
import 'package:todo/pages/signinpage.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Myapp());
}

class Myapp extends StatefulWidget {


  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  FirebaseAuth auth = FirebaseAuth.instance;
  void signup()async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: "barry.allen@example.com",
          password: "SuperSecretPassword!"
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Signinpage(),
    );
  }
}
