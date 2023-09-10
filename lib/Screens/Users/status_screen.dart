import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:line_icons/line_icons.dart';

import 'package:provider/provider.dart';
import '../../Models/Users.dart';
import '../../Provider/user_provider.dart';
import '../../Utils/app_style.dart';
import '../../Utils/colors.dart';



class StatusScreen extends StatefulWidget {
  const StatusScreen({Key? key}) : super(key: key);

  static String PageRoute = 'StatusScreen';

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {

  final firestore = FirebaseFirestore.instance;

  List<Map<String,List<String>>> complaints = [

  ];

  var getrc, getac, getec, getc, getgc;

  bool changed = true;


  Future<List<Map<String,List<String>>>> getComplaints() async {


    User user = Provider.of<UserProvider>(context,listen:false).getUser;

    complaints.clear();



    DocumentSnapshot<Map<String, dynamic>> RC_W_snapshot = await firestore.collection('Complaints').doc('Room Cleaning').collection(user.block).doc('waiting').collection(user.roomNo).doc(user.uid).get();

    if(RC_W_snapshot.exists) {
      String status = RC_W_snapshot.data()?['status'];
      String message = RC_W_snapshot.data()?['message'];
      String timeAt = RC_W_snapshot.data()?['timeAt'];
      String timming = RC_W_snapshot.data()?['timming'];
      String dateAt = RC_W_snapshot.data()?['dateAt'];

      complaints.add({'Room Cleaning' : [status,message,dateAt,timeAt,timming]});
    }

    DocumentSnapshot<Map<String, dynamic>> RC_P_snapshot = await firestore.collection('Complaints').doc('Room Cleaning').collection(user.block).doc('progress').collection(user.roomNo).doc(user.uid).get();

    if(RC_P_snapshot.exists) {
      String status = RC_P_snapshot.data()?['status'];
      String message = RC_P_snapshot.data()?['message'];
      String timeAt = RC_P_snapshot.data()?['timeAt'];
      String timming = RC_P_snapshot.data()?['timming'];
      String dateAt = RC_P_snapshot.data()?['dateAt'];

      complaints.add({'Room Cleaning' : [status,message,dateAt,timeAt,timming]});
    }




    DocumentSnapshot<Map<String, dynamic>> RC_C_snapshot = await firestore.collection('Complaints').doc('Room Cleaning').collection(user.block).doc('completed').collection(user.roomNo).doc(user.uid).get();

    if(RC_C_snapshot.exists) {
      String status = RC_C_snapshot.data()?['status'];
      String message = RC_C_snapshot.data()?['message'];
      String timeAt = RC_C_snapshot.data()?['timeAt'];
      String timming = RC_C_snapshot.data()?['timming'];
      String dateAt = RC_C_snapshot.data()?['dateAt'];

      complaints.add({'Room Cleaning' : [status,message,dateAt,timeAt,timming]});
    }


    DocumentSnapshot<Map<String, dynamic>> AC_W_snapshot = await firestore.collection('Complaints').doc('AC complaint').collection(user.block).doc('waiting').collection(user.roomNo).doc(user.uid).get();

    if(AC_W_snapshot.exists) {
      String status = AC_W_snapshot.data()?['status'];
      String message = AC_W_snapshot.data()?['message'];
      String timeAt = AC_W_snapshot.data()?['timeAt'];
      String timming = AC_W_snapshot.data()?['timming'];
      String dateAt = AC_W_snapshot.data()?['dateAt'];

      complaints.add({'AC complaint' : [status,message,dateAt,timeAt,timming]});
    }

    DocumentSnapshot<Map<String, dynamic>> AC_A_snapshot = await firestore.collection('Complaints').doc('AC complaint').collection(user.block).doc('progress').collection(user.roomNo).doc(user.uid).get();

    if(AC_A_snapshot.exists) {
      String status = AC_A_snapshot.data()?['status'];
      String message = AC_A_snapshot.data()?['message'];
      String timeAt = AC_A_snapshot.data()?['timeAt'];
      String timming = AC_A_snapshot.data()?['timming'];
      String dateAt = AC_A_snapshot.data()?['dateAt'];

      complaints.add({'AC complaint' : [status,message,dateAt,timeAt,timming]});
    }


    DocumentSnapshot<Map<String, dynamic>> AC_C_snapshot = await firestore.collection('Complaints').doc('AC complaint').collection(user.block).doc('completed').collection(user.roomNo).doc(user.uid).get();

    if(AC_C_snapshot.exists) {
      String status = AC_C_snapshot.data()?['status'];
      String message = AC_C_snapshot.data()?['message'];
      String timeAt = AC_C_snapshot.data()?['timeAt'];
      String timming = AC_C_snapshot.data()?['timming'];
      String dateAt = AC_C_snapshot.data()?['dateAt'];

      complaints.add({'AC complaint' : [status,message,dateAt,timeAt,timming]});
    }


    DocumentSnapshot<Map<String, dynamic>> EC_W_snapshot = await firestore.collection('Complaints').doc('Electric Complaint').collection(user.block).doc('waiting').collection(user.roomNo).doc(user.uid).get();

    if(EC_W_snapshot.exists) {
      String status = EC_W_snapshot.data()?['status'];
      String message = EC_W_snapshot.data()?['message'];
      String timeAt = EC_W_snapshot.data()?['timeAt'];
      String timming = EC_W_snapshot.data()?['timming'];
      String dateAt = EC_W_snapshot.data()?['dateAt'];

      complaints.add({'Electric Complaint' : [status,message,dateAt,timeAt,timming]});
    }

    DocumentSnapshot<Map<String, dynamic>> EC_A_snapshot = await firestore.collection('Complaints').doc('Electric Complaint').collection(user.block).doc('progress').collection(user.roomNo).doc(user.uid).get();

    if(EC_A_snapshot.exists) {
      String status = EC_A_snapshot.data()?['status'];
      String message = EC_A_snapshot.data()?['message'];
      String timeAt = EC_A_snapshot.data()?['timeAt'];
      String timming = EC_A_snapshot.data()?['timming'];
      String dateAt = EC_A_snapshot.data()?['dateAt'];

      complaints.add({'Electric Complaint' : [status,message,dateAt,timeAt,timming]});
    }

    DocumentSnapshot<Map<String, dynamic>> EC_C_snapshot = await firestore.collection('Complaints').doc('Electric Complaint').collection(user.block).doc('completed').collection(user.roomNo).doc(user.uid).get();

    if(EC_C_snapshot.exists) {
      String status = EC_C_snapshot.data()?['status'];
      String message = EC_C_snapshot.data()?['message'];
      String timeAt = EC_C_snapshot.data()?['timeAt'];
      String timming = EC_C_snapshot.data()?['timming'];
      String dateAt = EC_C_snapshot.data()?['dateAt'];

      complaints.add({'Electric Complaint' : [status,message,dateAt,timeAt,timming]});
    }


    DocumentSnapshot<Map<String, dynamic>> C_W_snapshot = await firestore.collection('Complaints').doc('Carpentry').collection(user.block).doc('waiting').collection(user.roomNo).doc(user.uid).get();

    if(C_W_snapshot.exists) {
      String status = C_W_snapshot.data()?['status'];
      String message = C_W_snapshot.data()?['message'];
      String timeAt = C_W_snapshot.data()?['timeAt'];
      String timming = C_W_snapshot.data()?['timming'];
      String dateAt = C_W_snapshot.data()?['dateAt'];

      complaints.add({'Carpentry' : [status,message,dateAt,timeAt,timming]});
    }


    DocumentSnapshot<Map<String, dynamic>> C_A_snapshot = await firestore.collection('Complaints').doc('Carpentry').collection(user.block).doc('progress').collection(user.roomNo).doc(user.uid).get();

    if(C_A_snapshot.exists) {
      String status = C_A_snapshot.data()?['status'];
      String message = C_A_snapshot.data()?['message'];
      String timeAt = C_A_snapshot.data()?['timeAt'];
      String timming = C_A_snapshot.data()?['timming'];
      String dateAt = C_A_snapshot.data()?['dateAt'];

      complaints.add({'Carpentry' : [status,message,dateAt,timeAt,timming]});
    }


    DocumentSnapshot<Map<String, dynamic>> C_C_snapshot = await firestore.collection('Complaints').doc('Carpentry').collection(user.block).doc('completed').collection(user.roomNo).doc(user.uid).get();

    if(C_C_snapshot.exists) {
      String status = C_C_snapshot.data()?['status'];
      String message = C_C_snapshot.data()?['message'];
      String timeAt = C_C_snapshot.data()?['timeAt'];
      String timming = C_C_snapshot.data()?['timming'];
      String dateAt = C_C_snapshot.data()?['dateAt'];

      complaints.add({'Carpentry' : [status,message,dateAt,timeAt,timming]});
    }


    print(complaints);
    return complaints;

  }





  @override
  Widget build(BuildContext context) {

    return Container(
      decoration:  BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff2D2E31) , Color(0xff0b0d0f)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.grey.withOpacity(0.01),
            title: Text('status', style: appTextStyle(25, purplemaincolor, FontWeight.normal)),
          ),
        body:
            Container(
              child: FutureBuilder(
                future: getComplaints(),
                builder: (context, AsyncSnapshot<List<Map<String,List<String>>>> snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(color: Colors.blue));
                  }
                  else{
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.length,
                        itemBuilder: (context,int index){
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xff373737),
                            ),
                            height: MediaQuery.of(context).size.height * 0.21,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(snapshot.data![index].keys.first.toString(), style: appTextStyle(20, purplemaincolor, FontWeight.normal)),
                                      snapshot.data![index].values.first[0].toString() == "waiting" ? Row(
                                        children: [
                                          Icon(LineIcons.hourglassHalf, color: Colors.red),
                                          Text(snapshot.data![index].values.first[0].toString(), style: appTextStyle(18, Colors.red, FontWeight.normal)),
                                        ],
                                      )
                                          :
                                      snapshot.data![index].values.first[0].toString() == "progress" ? Row(
                                        children: [
                                          Icon(LineIcons.hourglassHalf, color: Colors.yellow),
                                          Text(snapshot.data![index].values.first[0].toString(), style: appTextStyle(18, Colors.yellow, FontWeight.normal)),
                                        ],
                                      )
                                          :
                                      Row(
                                        children: [
                                          Icon(Icons.done_all, color: Colors.green),
                                          Text(snapshot.data![index].values.first[0].toString(), style: appTextStyle(18, Colors.green, FontWeight.normal)),
                                        ],
                                      )
                                    ],
                              ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Submitted on ", style: appTextStyle(15, Color(0xffbbbbbb), FontWeight.normal)),
                                        Text("Completed on ", style: appTextStyle(15, Color(0xffbbbbbb), FontWeight.normal))
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(snapshot.data![index].values.first[2].toString(), style: appTextStyle(18, Colors.white, FontWeight.normal)),
                                        Text("-")
                                      ],
                                    ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(snapshot.data![index].values.first[3].toString(), style: appTextStyle(18, Colors.white, FontWeight.normal)),
                                      Text("-")
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Message", style: appTextStyle(15, Color(0xffbbbbbb), FontWeight.normal)),
                                      Text("Time", style: appTextStyle(15, Color(0xffbbbbbb), FontWeight.normal))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(snapshot.data![index].values.first[1].toString(), style: appTextStyle(16, Colors.white, FontWeight.normal)),
                                      Text(snapshot.data![index].values.first[4].toString(), style: appTextStyle(16, Colors.white, FontWeight.normal))
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ),
                        );
                      }
                    );
                  }
                },
              ),
            )

      ),
    );
  }
}
