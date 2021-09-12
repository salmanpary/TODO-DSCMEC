import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo/pages/Addtodo.dart';
import 'package:todo/pages/signuppage.dart';
import 'package:todo/service/Auth_service.dart';
import 'package:todo/custom/todocard.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Authclass authclass = Authclass();
  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection("Todo").snapshots();

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
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => Addtodopage()));
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
      body: StreamBuilder(
          stream: _stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  IconData iconData;
                  Color iconColor;

                  Map<String, dynamic> data =
                      snapshot.data.docs[index].data() as Map<String, dynamic>;
                  switch(data["Category"]){
                    case "Work":
                      iconData=Icons.run_circle_outlined;
                      iconColor=Colors.white;
                      break;
                    case "run":
                      iconData=Icons.alarm;
                      iconColor=Colors.teal;
                      break;
                    case "food":
                      iconData=Icons.emoji_food_beverage;
                      iconColor=Colors.yellow;
                      break;
                    case "programming":
                      iconData=Icons.airplay_outlined;
                      iconColor=Colors.blue;
                      break;



                    default:
                      iconData=Icons.run_circle_outlined;
                      iconColor=Colors.yellow;
                  }


                  return TodoCard(
                    title: data["title"]==null?"hey there":data["title"],
                    check: true,
                    iconbgcolor: Colors.white,
                    iconcolor: iconColor,
                    icondata: iconData,
                    time: "10am",
                  );
                });
          }),
    );
  }
}
