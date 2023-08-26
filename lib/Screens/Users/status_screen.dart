import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hostel_connect/Provider/sense_change_provider.dart';
import 'package:hostel_connect/Screens/Users/home_screen_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../../Provider/user_provider.dart';
import 'mycomplaints.dart';


class StatusScreen extends StatefulWidget {
  const StatusScreen({Key? key}) : super(key: key);

  static String PageRoute = 'StatusScreen';

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {

  final firestore = FirebaseFirestore.instance;

  List<dynamic> complaints = [

  ];

  var getrc, getac, getec, getc, getgc;

  bool changed = true;


  Future<List<dynamic>> getComplaints() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();

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

            complaints.add({'rc' : [status,message,timeAt,timming]});

            await prefs.setStringList('rc_local', <String>[status,message,timeAt,timming]);
            print(prefs.getStringList('rc_local'));

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

        complaints.add({'ac' : [status,message,timeAt,timming]});

        await prefs.setStringList('ec_local', <String>[status,message,timeAt,timming]);

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

        complaints.add({'ec' : [status,message,timeAt,timming]});

        await prefs.setStringList('ec_local', <String>[status,message,timeAt,timming]);


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

        complaints.add({'c' : [status,message,timeAt,timming]});

        await prefs.setStringList('c_local', <String>[status,message,timeAt,timming]);

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

          complaints.add({'gc' : [status,message,timeAt,image]});

          await prefs.setStringList('g_local', <String>[status,message,timeAt,image]);

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

  getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    changed = await Provider.of<SenseChangeProvider>(context,listen:false).getsensechange;

    setState(() {
      getrc = prefs.getStringList('rc_local');
      getac = prefs.getStringList('ac_local');
      getec = prefs.getStringList('ec_local');
      getc = prefs.getStringList('c_local');
    });
  }


  void makeChanges(){
    changed = false;
    Provider.of<SenseChangeProvider>(context,listen:false).setSenseChange();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getData();
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
        appBar: AppBar(
            title: Text('My Complaints'),
          centerTitle: false,
          leading: Icon(Icons.backup_table_rounded),
          actions: [IconButton(icon: Icon(Icons.home),onPressed: (){Navigator.pushNamed(context, HomeScreenUser.PageRoute);})],
          automaticallyImplyLeading: false,
        ),
        body:
            // changed ?
            Container(
              child: FutureBuilder(
                future: getComplaints(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(color: Colors.blue));
                  }
                  else{

                    print(snapshot.data);
                    print(snapshot.data?.length);

                    // makeChanges();

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.length,
                        itemBuilder: (context,int index){
                        return GestureDetector(
                          onTap: (){Navigator.pushNamed(context, MyComplaints.PageRoute,arguments: {'content': snapshot.data![index]});},
                          child: ListTile(
                            leading: Icon(Icons.ac_unit_rounded),
                            title: Text(snapshot.data![index].toString())
                          ),
                        );
                      }
                    );


                  }
                },
              ),
            )

          // FOR CACHE          // :
            //   Container(
            //
            //   child: Center(
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         Card(child: Text(getrc.toString() ?? 'No Complaints')),
            //         Card(child: Text(getac.toString() ?? 'No Complaints')),
            //         Card(child: Text(getec.toString() ?? 'No Complaints')),
            //         Card(child: Text(getc.toString() ?? 'No Complaints')),
            //       ],
            //     ),
            //   // )
            // )
            // )

            // Expanded(
            //   child: ListView.builder(
            //     itemCount: complaints.length,
            //       itemBuilder: (context,index){
            //         return Padding(
            //           padding: const EdgeInsets.symmetric(vertical: 8.0),
            //           child: ListTile(
            //             leading: Icon(Icons.cleaning_services,color: blueColor),
            //             title: Text(snapshot.child('type').value.toString(),style: appTextStyle(20, Colors.white, FontWeight.bold),),
            //         subtitle: Column(
            //         children: [
            //         Padding(
            //         padding: const EdgeInsets.symmetric(vertical: 8.0),
            //         child: Text(snapshot.child('atTime').value.toString(),style: appTextStyle(15, Colors.white, FontWeight.normal)),
            //         ),
            //         Padding(
            //         padding: const EdgeInsets.symmetric(vertical: 8.0),
            //         child: Text(snapshot.child('message').value.toString(),style: appTextStyle(15, Colors.white, FontWeight.normal)),
            //         ),
            //         Text(snapshot.child('roomNo').value.toString(),style: appTextStyle(15, Colors.white, FontWeight.normal)),
            //         Padding(
            //         padding: const EdgeInsets.symmetric(vertical: 8.0),
            //         child: Text(snapshot.child('time').value.toString(),style: appTextStyle(15, Colors.white, FontWeight.normal)),
            //         ),
            //         Container(
            //         child: Text(snapshot.child('status').value.toString(),style: appTextStyle(15, Colors.white, FontWeight.w700)),
            //         color: Colors.red,
            //         padding: EdgeInsets.all(8)
            //         )
            //         ],
            //         ),
            //         ),
            //         );
            //       }
            //   )
            // )
      ),
    );
  }
}
