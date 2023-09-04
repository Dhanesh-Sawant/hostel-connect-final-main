import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hostel_connect/Provider/sense_change_provider.dart';
import 'package:hostel_connect/Screens/Users/home_screen_user.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../../Provider/user_provider.dart';
import '../../Utils/app_style.dart';
import '../../Utils/colors.dart';
import 'mycomplaints.dart';


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


    String rooomNo = Provider.of<UserProvider>(context,listen:false).getRoomNo;
    String uid = Provider.of<UserProvider>(context,listen:false).getUid;

    CollectionReference collectionRef = firestore.collection('Complaints');

    DocumentReference documentRef_rc = collectionRef.doc('Room Cleaning');
    DocumentReference documentRef_ac = collectionRef.doc('AC complaint');
    DocumentReference documentRef_ec = collectionRef.doc('Electric Complaint');
    DocumentReference documentRef_c = collectionRef.doc('Carpentry');
    DocumentReference documentRef_g = collectionRef.doc('General Complaints');

    final CollectionReference subcollectionRef_rc = documentRef_rc.collection(rooomNo);
    final CollectionReference subcollectionRef_ac = documentRef_ac.collection(rooomNo);
    final CollectionReference subcollectionRef_ec = documentRef_ec.collection(rooomNo);
    final CollectionReference subcollectionRef_c = documentRef_c.collection(rooomNo);
    final CollectionReference subcollectionRef_gc = documentRef_g.collection(uid);

    complaints.clear();


    await Future.wait([

        subcollectionRef_rc.get().then((querySnapshot) async {
          if (querySnapshot.docs.isNotEmpty) {
            // Collection exists and has documents
            // print("Collection exists");

            QueryDocumentSnapshot queryDocumentSnapshot = querySnapshot.docs.first;

            print(queryDocumentSnapshot.get('status'));

            String status = queryDocumentSnapshot.get('status');
            String message = queryDocumentSnapshot.get('message');
            String timeAt = queryDocumentSnapshot.get('timeAt');
            String timming = queryDocumentSnapshot.get('timming');
            String dateAt = queryDocumentSnapshot.get('dateAt');


            complaints.add({'Room Cleaning' : [status,message,dateAt,timeAt,timming]});


          } else {
            // Collection is empty or does not exist
            print("Collection does not exist");
          }
        }).catchError((error) {
          print("Error checking collection existence: $error");
        }),

        subcollectionRef_ac.get().then((querySnapshot) async {
      if (querySnapshot.docs.isNotEmpty) {
        // Collection exists and has documents
        // print("Collection exists");


        QueryDocumentSnapshot queryDocumentSnapshot = querySnapshot.docs.first;

        print(queryDocumentSnapshot.get('status'));

        String status = queryDocumentSnapshot.get('status');
        String message = queryDocumentSnapshot.get('message');
        String timeAt = queryDocumentSnapshot.get('timeAt');
        String timming = queryDocumentSnapshot.get('timming');
        String dateAt = queryDocumentSnapshot.get('dateAt');

        complaints.add({'AC Complaint' : [status,message,dateAt,timeAt,timming]});


      } else {
        // Collection is empty or does not exist
        print("Collection does not exist");
      }
    }).catchError((error) {
      print("Error checking collection existence: $error");
    }),



    subcollectionRef_ec.get().then((querySnapshot) async {
      if (querySnapshot.docs.isNotEmpty) {
        // Collection exists and has documents
        // print("Collection exists");

        QueryDocumentSnapshot queryDocumentSnapshot = querySnapshot.docs.first;

        print(queryDocumentSnapshot.get('status'));

        String status = queryDocumentSnapshot.get('status');
        String message = queryDocumentSnapshot.get('message');
        String timeAt = queryDocumentSnapshot.get('timeAt');
        String timming = queryDocumentSnapshot.get('timming');
        String dateAt = queryDocumentSnapshot.get('dateAt');

        complaints.add({'Electric Complaint' : [status,message,dateAt,timeAt,timming]});



      } else {
        // Collection is empty or does not exist
        print("Collection does not exist");
      }
    }).catchError((error) {
      print("Error checking collection existence: $error");
    }),

    subcollectionRef_c.get().then((querySnapshot) async {
      if (querySnapshot.docs.isNotEmpty) {
        // Collection exists and has documents
        // print("Collection exists");

        QueryDocumentSnapshot queryDocumentSnapshot = querySnapshot.docs.first;

        print(queryDocumentSnapshot.get('status'));

        String status = queryDocumentSnapshot.get('status');
        String message = queryDocumentSnapshot.get('message');
        String timeAt = queryDocumentSnapshot.get('timeAt');
        String timming = queryDocumentSnapshot.get('timming');
        String dateAt = queryDocumentSnapshot.get('dateAt');

        complaints.add({'Carpentry' : [status,message,dateAt,timeAt,timming]});

      } else {
        // Collection is empty or does not exist
        print("Collection does not exist");
      }

    }).catchError((error) {
      print("Error checking collection existence: $error");
    }),

      subcollectionRef_gc.get().then((querySnapshot) async {
        if (querySnapshot.docs.isNotEmpty) {
          // Collection exists and has documents
          // print("Collection exists");

          QueryDocumentSnapshot queryDocumentSnapshot = querySnapshot.docs.first;

          print(queryDocumentSnapshot.get('status'));

          String status = queryDocumentSnapshot.get('status');
          String message = queryDocumentSnapshot.get('message');
          String timeAt = queryDocumentSnapshot.get('timeAt');
          String image = queryDocumentSnapshot.get('image');
          String dateAt = queryDocumentSnapshot.get('dateAt');

          complaints.add({'General Complaints' : [status,message,dateAt,timeAt,image]});

        } else {
          // Collection is empty or does not exist
          print("Collection does not exist");
        }

      }).catchError((error) {
        print("Error checking collection existence: $error");
      }),

    ]
    );
    

    // await Future.delayed(Duration(seconds: 10));

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
            elevation: 0,
            backgroundColor: Colors.grey.withOpacity(0.01),
            leading: IconButton(
              onPressed: (){Navigator.pop(context);},
              icon: Icon(LineIcons.arrowLeft, color: purplemaincolor, size: 30),
            ),
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
