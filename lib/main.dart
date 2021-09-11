

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:todo/pages/homepage.dart';
import 'package:todo/pages/signuppage.dart';
import 'package:todo/pages/signinpage.dart';
import 'package:todo/service/Auth_service.dart';
import 'package:todo/pages/Addtodo.dart';

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
  Widget currentpage=Signuppage();
  Authclass authclass=Authclass();




  @override
  void initState(){
    super.initState();
    checkLogin();
  }
  void checkLogin()async{
    String token =await authclass.gettoken();
    if(token!=null){
      setState(() {
        currentpage=HomePage();
      });
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

