import 'dart:convert';

import 'package:flutter/material.dart';

class MyComplaints extends StatefulWidget {
  const MyComplaints({Key? key}) : super(key: key);

  static String PageRoute = 'MyComplaints';
  @override
  State<MyComplaints> createState() => _MyComplaintsState();
}

class _MyComplaintsState extends State<MyComplaints> {

  Image? myImage;

  void getImage(String url){
    myImage = Image.memory(base64Decode(url));
  }


  @override
  Widget build(BuildContext context) {

    bool isGC = false;

    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;

    arguments['content']['gc']!=null ? {
      getImage(arguments['content']["gc"][3].toString()),
      setState(() {isGC = true;})
    } : isGC = false;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Complaints'),
        automaticallyImplyLeading: true,
      ),
      body: Container(
        child: Center(
          child: isGC ? myImage : Text(arguments['content'].toString())
        ),
      ),
    );
  }
}
