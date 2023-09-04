import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_connect/Provider/user_provider.dart';
import 'package:hostel_connect/Screens/Users/status_screen.dart';
import 'package:hostel_connect/Utils/colors.dart';
import 'package:provider/provider.dart';
import '../../Models/Users.dart';
import '../../Widgets/reusable_button.dart';
import '../../Utils/app_style.dart';
import '../../Provider/status_provider.dart';
import '../../Models/Users.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shimmer/shimmer.dart';


class HomeScreenUser extends StatefulWidget {
  const HomeScreenUser({Key? key}) : super(key: key);

  static String PageRoute = 'HomeScreenUser';

  @override
  State<HomeScreenUser> createState() => _HomeScreenUserState();
}

class _HomeScreenUserState extends State<HomeScreenUser> {

  String? RN;
  String? uid;
  String? username;
  late User user;

  int temp = 0;


  List<String>? rc;
  List<String>? ac;
  List<String>? ec;
  List<String>? c;


  String? atlastshowRequest;
  String? atlastReqStatus;

  int? oldestDate = -1;
  int? oldestTime = -1;

  bool isProgress = false;


  Future<String?> refreshuser()async{

    print("inside refreshuser");

    await Provider.of<UserProvider>(context,listen:false).refreshUser();

    user = Provider.of<UserProvider>(context,listen:false).getUser;

    RN = user.roomNo;
    uid = user.uid;
    username = user.username;
    print("ended refreshuser");


    await Future.wait([
      Provider.of<StatusProvider>(context,listen: false).refreshComplaintStatus(uid!,RN!)
    ]);

    return username;
  }

  Future<List<String>> refreshstatus()async{

    // Map<String,List<String>> status = {};
    //
    // print("inside refreshstatus");
    //
    // rc = Provider.of<StatusProvider>(context,listen: false).getStatus_RC;
    // ac = Provider.of<StatusProvider>(context,listen: false).getStatus_AC;
    // ec = Provider.of<StatusProvider>(context,listen: false).getStatus_EC;
    // c = Provider.of<StatusProvider>(context,listen: false).getStatus_C;
    //
    // status['RC'] = rc!;
    // status['AC'] = ac!;
    // status['EC'] = ec!;
    // status['C'] = c!;
    //
    // print("printing from refreshstatus()");
    // print('$rc $ac $ec $c');
    //
    // print("ended refreshstatus");

    // await Future.wait([
    //   Future.delayed(Duration(seconds: 10))
    // ]);


    String tempwaiting = await Provider.of<StatusProvider>(context,listen: false).getLatestWaiting ?? "No complaints";
    String tempprogress = await Provider.of<StatusProvider>(context,listen: false).getLatestProgress ?? "No complaints";

    return [tempwaiting, tempprogress];

  }


  late Future<void> initDataFuture;

  Future<void> refreshData()async {
    await Future.wait([
      refreshuser(),
    ]);
    await Future.wait([
      refreshstatus(),
    ]);


    print("ended refreshdata");
  }

  @override
  void initState() {
    // print("init state called");
    super.initState();
    // print("refresh data called");
    // initDataFuture = refreshData();
    // print("init state finished");
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
        body: SafeArea(
          child: Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
                    child: FutureBuilder(
                        future: refreshuser(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            // While data is being loaded, you can show a loading indicator.
                            return Center(child: CircularProgressIndicator(color: Colors.blue));
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            // Once the data is loaded, build the UI with the username.
                            return buildBodyWithUsername(snapshot.data.toString());
                          }
                        }
                    ),
                  )))
    );
  }

  Widget buildBodyWithUsername(String UN) {
    return Column(
      children: [
        Row(
          children: [
            Text('Hi $UN', style: appTextStyle(28.0, Colors.white, FontWeight.w500)),
            Expanded(child: Container()),
            IconButton(
              onPressed: () {
              },
              icon: Icon(Icons.settings, color: Colors.white, size: 30),
            ),
            SizedBox(width: 1),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 20),
          child: GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, StatusScreen.PageRoute);
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff5711D2) , Color(0xff7770c3)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(25), // Set half of the width/height for a perfect circle
                border: Border.all(
                    color: Colors.transparent,
                    width: 2),
              ),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ongoing Requests', style: appTextStyle(20.0, Colors.white, FontWeight.bold)),
                    SizedBox(height: 10),
                    FutureBuilder<List<String>>(
                        future: refreshstatus(),
                        builder: (context, snapshot) {

                          print("the final request is $atlastshowRequest");

                          if (snapshot.connectionState == ConnectionState.waiting) {
                            // While data is being loaded, you can show a loading indicator.
                            return CircularProgressIndicator(color: Colors.blue);
                          } else if (snapshot.hasError) {
                            // Handle errors here.
                            return Text('Error: ${snapshot.error}');
                          } else {
                            // Once the data is loaded, build the UI with the username.

                            return Column(
                                children: [

                                  snapshot.data![1] != "No complaints" ? Text(snapshot.data![1], style: appTextStyle(18.0, Color(0xffb4e2f1), FontWeight.w500))
                                    :
                                      Text(snapshot.data![0], style: appTextStyle(18.0, Color(0xffb4e2f1), FontWeight.w500)),

                                ]
                            );
                          }
                        }
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height*0.05),
        Column(
          children:  [
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReusableButton(content: 'Room Cleaning', url: 'Janitor.png'),
                  ReusableButton(content: 'Carpentry', url: 'Saw.png'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReusableButton(content: 'Electric Complaint', url: 'Idea.png'),
                  ReusableButton(content: 'AC complaint', url: 'Air Conditioner.png'),
                ],
              ),
            ),
            ReusableButton(content: 'General Complaints', url: 'Broom.png')
          ],
        ),
      ],
    );
  }
}
