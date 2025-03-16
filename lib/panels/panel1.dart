import 'package:flutter/material.dart';

class Panel1 extends StatefulWidget {
  const Panel1({super.key});

  @override
  _Panel1State createState() => _Panel1State();
}

class _Panel1State extends State<Panel1> {

  @override
  Widget build(BuildContext context) {

    final double paddingForIcons = 30;
    final rowForLab = Row(
      
      mainAxisAlignment: MainAxisAlignment.spaceAround, // Как варик - spaceBetween
      children: [
        Container(
          padding: EdgeInsets.only(top: paddingForIcons),
          child: Icon(Icons.home, color: Colors.white),
        ),
        Container(
          padding: EdgeInsets.only(top: paddingForIcons),
          child: Icon(Icons.settings, color: Colors.black),
        ),
        Container(
          padding: EdgeInsets.only(top: paddingForIcons),
          child: Icon(Icons.abc_sharp, color: Colors.red),
        ),
      ],
    );

    return Container(
    color: Colors.red[100],
    alignment: Alignment.centerLeft,
    padding: EdgeInsets.all(15),
    child: 
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Лаба 1, Вариант 3(13)"),
        Column(
            children: [
            rowForLab,
            rowForLab,
            rowForLab
          ],
        ),
    ],
    ),
    
    );
    
  }  
}