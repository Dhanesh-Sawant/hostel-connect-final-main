import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hostel_connect/Screens/Admin/student_details_admin.dart';

import '../../Utils/app_style.dart';
import '../../Utils/colors.dart';
import '../../Utils/show_snackbar.dart';

class EditDetails extends StatefulWidget {
  const EditDetails({Key? key}) : super(key: key);

  static String PageRoute = 'EditDetails';

  @override
  State<EditDetails> createState() => _EditDetailsState();
}

class _EditDetailsState extends State<EditDetails> {

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  bool isLoading = false;

  TextEditingController BlockEditingController = TextEditingController();
  TextEditingController RoomEditingController = TextEditingController();

  Future<String> setChanges(String uid) async {

    String result;

    try{
      await _firebaseFirestore.collection('Users').doc(uid).update({
        'block': BlockEditingController.text,
        'roomNo': RoomEditingController.text,
      });
      result = "success";
    }catch(e){
      print(e);
      result = "error + $e";
    }
    return result;
  }


  @override
  Widget build(BuildContext context) {

    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Details"),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Container(
          height: MediaQuery.of(context).size.height*0.30,
          width: MediaQuery.of(context).size.width*0.8,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.only(top: 16,left: 16.0,right: 16),
              child: Column(
                children: [
                  TextField(
                    controller: BlockEditingController,
                    decoration: InputDecoration(labelText: 'Enter block',labelStyle: appTextStyle(16, Colors.grey, FontWeight.bold), icon: Icon(Icons.access_time_outlined)),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: RoomEditingController,
                    decoration: InputDecoration(labelText: 'Enter Room No',labelStyle: appTextStyle(16, Colors.grey, FontWeight.bold), icon: Icon(Icons.message)),
                  ),
                  SizedBox(height: 28.0),
                  MaterialButton(
                    minWidth: MediaQuery.of(context).size.width*0.6,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    color: blueColor,
                    onPressed: () async {
                      print(BlockEditingController.text);
                      print(RoomEditingController.text);

                      String result = await setChanges(arguments['uid']);
                      isLoading = true;
                      if(result == "success"){
                        Navigator.pushNamed(context, StudentDetailsAdmin.PageRoute);
                    }
                      else{
                        showSnackBar(result,context);
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
