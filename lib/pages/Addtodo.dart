import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Addtodopage extends StatefulWidget {
  @override
  _AddtodopageState createState() => _AddtodopageState();
}

class _AddtodopageState extends State<Addtodopage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xff1d1e26),
            Color(0xff252041),
          ]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            IconButton(
              icon: Icon(
                CupertinoIcons.arrow_left,
                color: Colors.white,
                size: 28,
              ),
              onPressed: () {},
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "create",
                    style: TextStyle(
                        fontSize: 33,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "newtodo",
                    style: TextStyle(
                        fontSize: 33,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  label("task title"),
                  SizedBox(
                    height: 30,
                  ),
                  label(" Task type"),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      chipdata("important", 0xffff6d6e),
                      SizedBox(
                        width: 20,
                      ),
                      chipdata("planned", 0xffff6d6e),
                    ],
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  label("description"),
                  SizedBox(
                    height: 12,
                  ),
                  description(),
                  SizedBox(
                    width: 25,
                  ),
                  label("category "),
                  SizedBox(
                    height: 12,
                  ),
                  Wrap(
                    runSpacing: 10,
                    children: [
                      chipdata("food", 0xffff6d6e),
                      SizedBox(
                        width: 20,
                      ),
                      chipdata("programming", 0xfff29732),
                      SizedBox(
                        width: 20,
                      ),
                      chipdata("work", 0xff6557ff),
                      SizedBox(
                        width: 20,
                      ),
                      chipdata("run", 0xff2bc8d9),
                    ],
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  button(),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget button() {
    return Container(
        height: 56,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [
            Color(0xff8a32f1),
            Color(0xffad32f9),
          ]),
        ),
      child: Center(
        child: Text("add todo",style:TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            ),),
      ),
    );
  }

  Widget description() {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        style: TextStyle(
          color: Colors.grey,
          fontSize: 17,
        ),
        maxLines: null,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Task title",
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 17,
            ),
            contentPadding: EdgeInsets.only(
              left: 20,
              right: 20,
            )),
      ),
    );
  }

  Widget chipdata(String label, int color) {
    return Chip(
      backgroundColor: Color(color),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      labelPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 3.8),
    );
  }

  Widget title() {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        style: TextStyle(
          color: Colors.grey,
          fontSize: 17,
        ),
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Task title",
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 17,
            ),
            contentPadding: EdgeInsets.only(
              left: 20,
              right: 20,
            )),
      ),
    );
  }

  Widget label(String label) {
    return Text(
      label,
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 16.5,
          letterSpacing: 0.2),
    );
  }
}
