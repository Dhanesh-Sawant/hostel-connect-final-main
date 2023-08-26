import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hostel_connect/Screens/Admin/dashboard_admin.dart';
import 'package:hostel_connect/Utils/app_style.dart';

class ActionsAdmin extends StatefulWidget {
  const ActionsAdmin({Key? key}) : super(key: key);

  static String PageRoute = 'ActionsAdmin';

  @override
  State<ActionsAdmin> createState() => _ActionsAdminState();
}

class _ActionsAdminState extends State<ActionsAdmin> {

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;



  @override
  Widget build(BuildContext context) {

    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;

    updateStatus(dynamic uid, dynamic type) async {

      firebaseFirestore.collection('Complaints').doc(type).collection(uid).doc('1').update(
        {
          "status" : "progress"
        }
      );

    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Actions'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Message', style: appTextStyle(20, Colors.white, FontWeight.bold)),
            Text(arguments['message'], style: appTextStyle(16, Colors.white, FontWeight.normal)),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: MaterialButton(
                color: Colors.blue,
                child: Text('Move to Progress', style: appTextStyle(16, Colors.white, FontWeight.normal)),
                  onPressed: (){
                    updateStatus(arguments['uid'], arguments['type']);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DashBoardAdmin(type: arguments['type'])));
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}
