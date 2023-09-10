import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hostel_connect/Utils/app_style.dart';
import 'package:hostel_connect/Utils/colors.dart';

import 'edit_details.dart';
import 'home_screen_admin.dart';

class SelectedUser extends StatefulWidget {
  const SelectedUser({Key? key}) : super(key: key);

  static String PageRoute = 'SelectedUser';

  @override
  State<SelectedUser> createState() => _SelectedUserState();
}

class _SelectedUserState extends State<SelectedUser> {



  @override
  Widget build(BuildContext context) {

    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;


    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
        backgroundColor: mobileBackgroundColor,
        actions: [
          IconButton(onPressed: (){Navigator.pushNamed(context, HomeScreenAdmin.PageRoute);}, icon: Icon(Icons.home))
        ],
      ),
      body: Center(
        child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage('https://th.bing.com/th/id/OIP.Yw4exB-_crv1xcdLRQ6hngHaHx?pid=ImgDet&rs=1'),
                  ),
                ),
                Text('uid: ${arguments['user']['uid']}',style: appTextStyle(15, Colors.white, FontWeight.normal)),
                Text('username: ${arguments['user']['username']}',style: appTextStyle(20, Colors.white, FontWeight.normal)),
                Text('block: ${arguments['user']['block']}',style: appTextStyle(20, Colors.white, FontWeight.normal)),
                Text('roomNo: ${arguments['user']['roomNo']}',style: appTextStyle(20, Colors.white, FontWeight.normal)),
                SizedBox(height: 40),
                MaterialButton(
                    onPressed: (){
                      Navigator.pushNamed(context, EditDetails.PageRoute, arguments: {'uid':arguments['uid']});
                    },
                    color: Colors.red,
                    child: Text('Edit User Room Details',style: appTextStyle(20, Colors.white, FontWeight.normal)))
              ],
            )
        ),
      ),
    );
  }
}
