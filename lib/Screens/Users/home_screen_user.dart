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


  String? rc;
  String? ac;
  String? ec;
  String? c;

  Future<String?> refreshuser()async{
    print("inside refreshuser");
    await Provider.of<UserProvider>(context,listen:false).refreshUser();

    user = Provider.of<UserProvider>(context,listen:false).getUser;

    RN = user.roomNo;
    uid = user.uid;
    username = user.username;
    print("ended refreshuser");


    Future.wait([
      Provider.of<StatusProvider>(context,listen: false).refreshComplaintStatus(uid!,RN!)
    ]);
    return username;
  }

  Future<Map<String,String>> refreshstatus()async{

    temp=0;

    Map<String,String> status = {};

    print("inside refreshstatus");

    rc = Provider.of<StatusProvider>(context,listen: false).getStatus_RC;
    ac = Provider.of<StatusProvider>(context,listen: false).getStatus_AC;
    ec = Provider.of<StatusProvider>(context,listen: false).getStatus_EC;
    c = Provider.of<StatusProvider>(context,listen: false).getStatus_C;

    status['RC'] = rc!;
    status['AC'] = ac!;
    status['EC'] = ec!;
    status['C'] = c!;

    print('$rc $ac $ec $c');

    print("ended refreshstatus");

    // await Future.wait([
    //   Future.delayed(Duration(seconds: 3))
    // ]);
    return status;

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
    print("init state called");
    // TODO: implement initState
    super.initState();
    print("refresh data called");
    initDataFuture = refreshData();
    print("init state finished");
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
          child: FutureBuilder(
              future: Future.delayed(Duration(seconds: 2)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                {
                  return Center(child: CircularProgressIndicator(color: Colors.blue));
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}}');
                } else {
                  return Padding(
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
                  );
                }
              }
          ),
        ),
      ),
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
                    FutureBuilder<Map<String,String>>(
                        future: refreshstatus(),
                        builder: (context, snapshot) {

                          if(snapshot.data?['RC']! == "Not Available"){temp++;};
                          if(snapshot.data?['AC']! == "Not Available"){temp++;};
                          if(snapshot.data?['EC']! == "Not Available"){temp++;};
                          if(snapshot.data?['C']! == "Not Available"){temp++;};

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
                                  snapshot.data?['RC'] != "Not Available" ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Room Cleaning', style: appTextStyle(18.0, Color(0xffb4e2f1), FontWeight.w500)),
                                      Row(
                                        children: [
                                          snapshot.data!['RC']! == "waiting" ? Icon(LineIcons.hourglassHalf, color: Colors.white, size: 22): Icon(LineIcons.checkCircle, color: Colors.white, size: 22),
                                          Text(snapshot.data!['RC']!, style: appTextStyle(18.0, Colors.white, FontWeight.w500)),
                                        ],
                                      )
                                    ],
                                  ) : SizedBox(),

                                  snapshot.data?['AC'] != "Not Available" ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('AC complaint', style: appTextStyle(18.0, Color(0xffb4e2f1), FontWeight.w500)),
                                      Row(
                                        children: [
                                          snapshot.data!['AC']! == "waiting" ? Icon(LineIcons.hourglassHalf, color: Colors.white, size: 20): Icon(LineIcons.checkCircle, color: Colors.white, size: 20),
                                          Text(snapshot.data!['AC']!, style: appTextStyle(18.0, Colors.white, FontWeight.w500)),
                                        ],
                                      )
                                    ],
                                  ) : SizedBox(),

                                  snapshot.data?['EC'] != "Not Available" ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Electric Complaint', style: appTextStyle(18.0, Color(0xffb4e2f1), FontWeight.w500)),
                                      Row(
                                        children: [
                                          snapshot.data!['EC']! == "waiting" ? Icon(LineIcons.hourglassHalf, color: Colors.white, size: 20): Icon(LineIcons.checkCircle, color: Colors.white, size: 20),
                                          Text(snapshot.data!['EC']!, style: appTextStyle(18.0, Colors.white, FontWeight.w500)),
                                        ],
                                      )],
                                  ) : SizedBox(),

                                  snapshot.data?['C'] != "Not Available" ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Carpentry', style: appTextStyle(18.0, Color(0xffb4e2f1), FontWeight.w500)),
                                      Row(
                                        children: [
                                          snapshot.data!['C']! == "waiting" ? Icon(LineIcons.hourglassHalf, color: Colors.white, size: 20): Icon(LineIcons.checkCircle, color: Colors.white, size: 20),
                                          Text(snapshot.data!['C']!, style: appTextStyle(18.0, Colors.white, FontWeight.w500)),
                                        ],
                                      )],
                                  ) : SizedBox(),
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
