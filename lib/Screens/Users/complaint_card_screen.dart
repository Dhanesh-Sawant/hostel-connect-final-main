import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hostel_connect/Screens/Users/status_screen.dart';
import 'package:hostel_connect/Utils/app_style.dart';
import 'package:hostel_connect/Utils/colors.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import '../../Provider/sense_change_provider.dart';
import '../../Provider/status_provider.dart';
import '../../Provider/user_provider.dart';
import '../../Resources/storage_methods.dart';
import '../../Models/Users.dart' as model;
import '../../Utils/show_snackbar.dart';

class ComplaintCard extends StatefulWidget {
  @override
  _ComplaintCardState createState() => _ComplaintCardState();

  static String PageRoute = 'ComplaintCard';

}

class _ComplaintCardState extends State<ComplaintCard> {
  TextEditingController _timingController = TextEditingController();
  TextEditingController _messageController = TextEditingController();
  StorageMethods storageMethods = StorageMethods();


  final ref = FirebaseDatabase.instance.ref('complaints');

  model.User? user;
  String? uid;
  bool isLoading = false;


  @override
  void dispose() {
    _timingController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  getcurrentuserAndUid() async{
    user = await Provider.of<UserProvider>(context,listen: false).getUser;
    uid = await Provider.of<UserProvider>(context,listen: false).getUid;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcurrentuserAndUid();
    _timingController.text = '8-10';
  }



  @override
  Widget build(BuildContext context) {

    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;


    List<String> _time = [
      '8-10',
      '10-12',
      '2-6',
    ];

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
          title: Text(arguments['content'], style: appTextStyle(25, purplemaincolor, FontWeight.bold)),
        ),
        body:

            Stack(
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/${arguments['content']}.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 72.0, left: 36, right: 36),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Time", style: appTextStyle(20, Colors.white, FontWeight.w500)),
                      SizedBox(height: 20),

                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black12.withOpacity(0.5),
                          border: Border.all(color: purplemaincolor, width: 3),
                        ),
                        width: MediaQuery.of(context).size.width*0.8,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: DropdownButton<String>(
                            underline: SizedBox(),
                            value: _timingController.text ?? "8-10",
                            icon: Row(
                              children: [
                                SizedBox(width: 260),
                                Icon(Icons.arrow_drop_down_sharp, color: purplemaincolor, size: 30),
                              ],
                            ), // Dropdown arrow icon
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.white),

                            onChanged: (String? newValue) {
                              setState(() {
                                _timingController.text = newValue ?? "8-10";
                              });
                            },
                            items: _time.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            dropdownColor: Colors.black12.withOpacity(0.6),
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.width*0.2),
                      Text("Message", style: appTextStyle(20, Colors.white, FontWeight.w500)),
                      SizedBox(height: 20),
                      TextField(
                        maxLines: 5,
                        controller: _messageController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.black12.withOpacity(0.5),
                          hintText: 'Enter your message',
                          hintStyle: appTextStyle(16, Colors.grey, FontWeight.w500),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: purplemaincolor, width: 3),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: purplemaincolor, width: 3),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: purplemaincolor, width: 3),
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      Center(
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 46,
                          minWidth: MediaQuery.of(context).size.width*0.4,
                          color: purplemaincolor,
                            onPressed: () async {

                            String type = arguments['content'];
                            String timing = _timingController.text;
                            String message = _messageController.text;
                            print('Type of Complaint: $type');
                            print('Timings: $timing');
                            print('Message: $message');

                            setState(() {
                              isLoading = true;
                            });


                            String result = await storageMethods.uploadDataRealTime(type,timing,message,user!);
                            print(result);


                            setState(() {
                              isLoading = false;
                            });

                            if(result!='success'){
                              showSnackBar(result,context);
                            }
                            else{
                              Provider.of<SenseChangeProvider>(context,listen:false).setSenseChange();
                              Navigator.pushNamed(context, StatusScreen.PageRoute,arguments: {'user' : user, 'type' : type});
                            }


                            },
                            child: isLoading ? Center(child: CircularProgressIndicator(color: Colors.blue)) : Text("submit", style: appTextStyle(19, Colors.white, FontWeight.w600))
                        ),
                      )
                    ],
                  ),
                )

              ]
            )
      ),
    );
  }
}
