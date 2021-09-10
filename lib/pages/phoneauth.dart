import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:todo/service/Auth_service.dart';



class PhoneAuthPage extends StatefulWidget {
  @override
  _PhoneAuthPageState createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  int start = 30;
  bool wait = false;
  String buttonName = "Send";
  TextEditingController phoneController = TextEditingController();
  Authclass authClass = Authclass();
  String verificationIdFinal = "";
  String smsCode = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          "signup",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              textfield(),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                        margin: EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              otpfield(),
              SizedBox(
                height: 40,
              ),
              RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Send OTP again in ",
                        style: TextStyle(fontSize: 16, color: Colors.yellowAccent),
                      ),
                      TextSpan(
                        text: "00:$start",
                        style: TextStyle(fontSize: 16, color: Colors.pinkAccent),
                      ),
                      TextSpan(
                        text: " sec ",
                        style: TextStyle(fontSize: 16, color: Colors.yellowAccent),
                      ),
                    ],
                  )),
              SizedBox(
                height: 150,
              ),
              InkWell(
                onTap: () {
                  authClass.signInwithPhoneNumber(
                      verificationIdFinal, smsCode, context);
                },
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width - 60,
                  decoration: BoxDecoration(
                      color: Color(0xffff9601),
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Text(
                      "Lets Go",
                      style: TextStyle(
                          fontSize: 17,
                          color: Color(0xfffbe2ae),
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              )




            ],
          ),
        ),
      ),
    );

  }
  void setData(String verificationId) {
    setState(() {
      verificationIdFinal = verificationId;
    });
    startTimer();
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          wait = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }



  Widget otpfield() {
    return OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width - 34,
      fieldWidth: 30,
      otpFieldStyle: OtpFieldStyle(
        backgroundColor: Color(0xff1d1d1d),
        borderColor: Colors.white,
      ),
      style: TextStyle(fontSize: 17, color: Colors.white),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onCompleted: (pin) {
        print("Completed: " + pin);
      },
    );
  }

  Widget textfield() {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      decoration: BoxDecoration(
        color: Color(0xff1d1d1d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: phoneController,
        style: TextStyle(color: Colors.white, fontSize: 17),
        keyboardType: TextInputType.number,

        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "enter your phone number",
          hintStyle: TextStyle(color: Colors.white54, fontSize: 17),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 19, horizontal: 8),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
            child: Text(
              "(+91)",
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
            ),
          ),
          suffixIcon: InkWell(
            onTap:wait?null: ()async{
              startTimer();
              setState(() {
                start=30;
                wait=true;
                buttonName="resend";
              });
              await authClass.verifyPhoneNumber(
                  "+91 ${phoneController.text}", context, setData);

            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
              child: Text(
                "send",
                style: TextStyle(
                    color:wait?Colors.grey: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
