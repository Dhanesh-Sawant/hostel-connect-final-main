import 'package:flutter/material.dart';
import 'package:hostel_connect/Screens/Admin/dashboard_admin.dart';

import '../../Utils/app_style.dart';

class AdminReusableButton extends StatelessWidget {
  const AdminReusableButton({
    super.key, required this.content, required this.url
  });

  final String content;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.13,
      decoration:  BoxDecoration(
        border: Border.all(
            color: Colors.blue,
            width: 1.5
        ),
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          colors: [Color(0xff520CE7), Color(0xff8A35C9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xff7366c6).withOpacity(1), // Shadow color
            spreadRadius: 10, // Spread radius
            blurRadius: 7, // Blur radius
            offset: Offset(0, 0), // Offset in the (x, y) direction
          ),
        ],
      ),
      child: MaterialButton(
          height: MediaQuery.of(context).size.height*0.06,
          minWidth: MediaQuery.of(context).size.width*0.37,
          onPressed: (){
            if(content == 'General Complaint'){

            }else{
              Navigator.push(context, MaterialPageRoute(builder: (context) => DashBoardAdmin(type: content,)));
            };
            },
          color: Colors.transparent,
          shape: const RoundedRectangleBorder(
            // side: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(14))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/$url",height: MediaQuery.of(context).size.height*0.08,width: MediaQuery.of(context).size.height*0.09),
              content == "Room Cleaning" ? Text("Room Cleaning", style: appTextStyle(15,Colors.white, FontWeight.bold))
                  :
              content == "AC complaint" ? Text("AC", style: appTextStyle(15,Colors.white, FontWeight.bold))
                  :
              content == "Electric Complaint" ? Text("Electrical", style: appTextStyle(15,Colors.white, FontWeight.bold))
                  :
              content == "Carpentry" ? Text("Carpentry", style: appTextStyle(15,Colors.white, FontWeight.bold))
                  :
              Text("General Complaints", style: appTextStyle(15,Colors.white, FontWeight.bold))
            ],
          )
      ),
    );
  }
}
