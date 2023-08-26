import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hostel_connect/Screens/Users/status_screen.dart';
import 'package:hostel_connect/Utils/app_style.dart';
import 'package:hostel_connect/Utils/colors.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import '../../Provider/sense_change_provider.dart';
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
  }


  @override
  Widget build(BuildContext context) {

    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;

    // String? _currentSelectedValue ="8-10";
    //
    // var _time = [
    //   '8-10',
    //   '10-12',
    //   '2-6',
    //   '6-7'
    // ];

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
            icon: Icon(LineIcons.arrowLeft),
          ),
          title: Text(arguments['content'], ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height*0.30,
          width: MediaQuery.of(context).size.width*0.8,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.only(top: 16,left: 16.0,right: 16),
              child: Column(
                children: [
                  TextField(
                    controller: _timingController,
                    decoration: InputDecoration(hintText: 'eg: 5-7',labelText: 'Timings',labelStyle: appTextStyle(16, Colors.grey, FontWeight.bold), icon: Icon(Icons.access_time_outlined)),
                  ),
                  // FormField<String>(
                  //   builder: (FormFieldState<String> state) {
                  //     return InputDecorator(
                  //       decoration: InputDecoration(
                  //         icon: Icon(Icons.access_time_outlined),
                  //           labelStyle: appTextStyle(20, Colors.grey, FontWeight.bold),
                  //           errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                  //           hintText: 'Please select expense',
                  //           border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                  //       isEmpty: _currentSelectedValue == '',
                  //       child: DropdownButtonHideUnderline(
                  //         child: DropdownButton<String>(
                  //           value: _currentSelectedValue,
                  //           isDense: true,
                  //           onChanged: (newValue) {
                  //             setState(() {
                  //               _currentSelectedValue = newValue;
                  //               state.didChange(newValue);
                  //             });
                  //           },
                  //           items: _time.map((String value) {
                  //             return DropdownMenuItem<String>(
                  //               value: value,
                  //               child: Text(value),
                  //             );
                  //           }).toList(),
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _messageController,
                    decoration: InputDecoration(labelText: 'Message (if any)',labelStyle: appTextStyle(16, Colors.grey, FontWeight.bold), icon: Icon(Icons.message)),
                  ),
                  SizedBox(height: 28.0),
                  MaterialButton(
                    minWidth: MediaQuery.of(context).size.width*0.6,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    color: blueColor,
                    onPressed: () async {
                      // Perform submit action here
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
                    child: isLoading ? CircularProgressIndicator(color: Colors.white) : Text('Submit',style: appTextStyle(15, Colors.white, FontWeight.w600),),
                  ),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}
