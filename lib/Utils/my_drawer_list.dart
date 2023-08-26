import 'package:flutter/material.dart';
import 'package:hostel_connect/Screens/Admin/login_screen_admin.dart';
import 'package:hostel_connect/Screens/Admin/student_details_admin.dart';
import 'package:hostel_connect/Utils/app_style.dart';
import 'package:hostel_connect/Utils/colors.dart';

import '../Resources/auth_methods.dart';

class MyDrawerList extends StatefulWidget {
  const MyDrawerList({Key? key});


  @override
  State<MyDrawerList> createState() => _MyDrawerListState();
}

class _MyDrawerListState extends State<MyDrawerList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      padding: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          menuItem('Dashboard',Icons.dashboard_outlined),
          GestureDetector(child: menuItem('Student Details',Icons.school),onTap: (){Navigator.pushNamed(context, StudentDetailsAdmin.PageRoute);}),
          menuItem('Staff Details',Icons.work),
          menuItem('My Profile',Icons.account_circle),
          GestureDetector(child: menuItem('logout',Icons.logout),onTap: (){AuthMethods().SignOut();
          Navigator.pushNamed(context, LoginScreenAdmin.PageRoute);})
        ],
      ),
    );
  }
}

Widget menuItem(String detail, IconData iconData){
  return Material(
    child: InkWell(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Expanded(child: Icon(iconData,size: 20,color: Colors.blue,)),
            Expanded(flex:3,child: Text(detail,style: appTextStyle(15, Colors.white, FontWeight.normal)))
          ],
        ),
      ),
    ),
  );
}
