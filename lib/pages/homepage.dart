import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo/pages/Addtodo.dart';
import 'package:todo/pages/signuppage.dart';
import 'package:todo/service/Auth_service.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          "todays schedule",
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/profile.jpg"),
          ),
          SizedBox(
            width: 25,
          ),
        ],
        bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.only(left: 22),
              child: Text(
                "monday 21",
                style: TextStyle(
                  fontSize: 33,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            preferredSize: Size.fromHeight(35)),
      ),
      bottomNavigationBar:
          BottomNavigationBar(backgroundColor: Colors.black87, items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: 32,
            color: Colors.white,
          ),
          title: Container(),
        ),
        BottomNavigationBarItem(
          icon: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (builder)=>Addtodopage()));
            },
            child: Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Colors.indigoAccent,
                      Colors.purple,
                    ],
                  )),
              child: Icon(
                Icons.add,
                size: 32,
                color: Colors.white,
              ),
            ),
          ),
          title: Container(),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
            size: 32,
            color: Colors.white,
          ),
          title: Container(),
        ),
      ]),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Todocard(
                "wakeupbro",Icons.alarm,Colors.red,"10am",true,Colors.white
              ),
              Todocard(
                  "eat",Icons.emoji_food_beverage,Colors.red,"11am",false,Colors.white
              ),
              Todocard(
                  "sleep",Icons.alarm,Colors.red,"12am",true,Colors.white
              ),
              Todocard(
                  "code",Icons.computer,Colors.red,"1pm",true,Colors.white
              ),
              Todocard(
                  "repeat",Icons.circle,Colors.red,"2pm",true,Colors.white
              ),
              SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }

  Widget Todocard(String title,IconData icondata,Color iconcolor,String time,bool check,Color iconbgcolor) {

    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Theme(
            data: ThemeData(
              primarySwatch: Colors.blue,
              unselectedWidgetColor: Color(0xff5e616a),
            ),
            child: Transform.scale(
              scale: 1.5,
              child: Checkbox(
                onChanged: (bool value) {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                activeColor: Color(0xff6cf8a9),
                checkColor: Color(0xff0e3e26),
                value: check,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 75,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Color(0xff2a2e3d),
                child: Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: 33,
                      width: 36,
                      decoration: BoxDecoration(
                        color: iconbgcolor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(icondata,color:iconcolor,),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                    Text(time,style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
