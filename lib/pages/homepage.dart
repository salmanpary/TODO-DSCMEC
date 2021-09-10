import 'package:flutter/material.dart';
import 'package:todo/pages/signuppage.dart';
import 'package:todo/service/Auth_service.dart';
class HomePage extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Authclass authclass=Authclass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: ()async{
            await authclass.logout();
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (buidler)=>Signuppage()), (route) => false);
            
          })
        ],
      ),
    );
  }
}
