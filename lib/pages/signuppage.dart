import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:todo/pages/homepage.dart';
import 'package:todo/pages/signinpage.dart';
import 'package:todo/service/Auth_service.dart';
import 'package:todo/pages/phoneauth.dart';

class Signuppage extends StatefulWidget {
  @override
  _SignuppageState createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool circular = false;
  Authclass authclass=Authclass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "sign up",
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              buttonitem("assets/google.svg", "continue with google", 25,()async{
                await authclass.googlesignin(context);
              }),
              buttonitem(
                  "assets/phone-call-icon.svg", "continue with phone", 30,(){
                    Navigator.push(context, MaterialPageRoute(builder: (builder)=>PhoneAuthPage()));
              }),
              SizedBox(
                height: 15,
              ),
              Text(
                "or",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              textitem("email.....", emailcontroller, false),
              SizedBox(
                height: 15,
              ),
              textitem("password.....", passwordcontroller, true),
              SizedBox(
                height: 30,
              ),
              colorbutton(),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "already have an account?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (builder) => Signinpage()),
                          (route) => false);
                    },
                    child: Text(
                      "login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget colorbutton() {
    return InkWell(
      onTap: () async {
        setState(() {
          circular = true;
        });
        try {
          firebase_auth.UserCredential userCredential =
              await firebaseAuth.createUserWithEmailAndPassword(
                  email: emailcontroller.text,
                  password: passwordcontroller.text);
          print(userCredential.user.email);
          setState(() {
            circular = false;
          });
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => HomePage()),
              (route) => false);
        } catch (e) {
          final snackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          setState(() {
            circular = false;
          });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 90,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(colors: [
              Color(0xfffd746c),
              Color(0xffff9068),
              Color(0xfffd746c)
            ])),
        child: Center(
          child: circular
              ? CircularProgressIndicator()
              : Text(
                  "signup",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
        ),
      ),
    );
  }

  Widget textitem(
      String labeltext, TextEditingController controller, bool obscuretext) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        obscureText: obscuretext,
        controller: controller,
        style: TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          labelText: labeltext,
          labelStyle: TextStyle(
            fontSize: 17,
            color: Colors.white,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              width: 1.5,
              color: Colors.amber,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget buttonitem(String imagepath, String buttonname, double size,Function ontap ) {
    return InkWell(
      onTap:ontap,
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width - 60,
        child: Card(
          elevation: 8,
          color: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                imagepath,
                height: size,
                width: size,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                buttonname,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
