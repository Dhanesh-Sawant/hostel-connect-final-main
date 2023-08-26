import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hostel_connect/Provider/image_provider.dart';
import 'package:hostel_connect/Screens/Users/picker.dart';
import 'package:hostel_connect/Screens/Users/status_screen.dart';
import 'package:hostel_connect/Utils/colors.dart';
import 'package:image_picker/image_picker.dart';
import '../../Provider/user_provider.dart';
import '../../Utils/show_snackbar.dart';
import 'package:provider/provider.dart';
import '../../Models/Users.dart' as model;
import '../../Resources/storage_methods.dart';

class GeneralComplaints extends StatefulWidget {
  const GeneralComplaints({Key? key}) : super(key: key);

  static String PageRoute = 'GeneralComplaints';

  @override
  State<GeneralComplaints> createState() => _GeneralComplaintsState();
}


class _GeneralComplaintsState extends State<GeneralComplaints> {

  StorageMethods storageMethods = StorageMethods();

  File? MyFile;
  String? ImageInString;
  bool isLoading = false;
  model.User? user;
  String? uid;

  TextEditingController _messageController = TextEditingController();


  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context){
          return SimpleDialog(
            title: const Text('Choose an image from :'),
            children: [
              SimpleDialogOption(
                  padding: EdgeInsets.all(20),
                  child: Text('Camera'),
                  onPressed: ()async{
                    Navigator.of(context).pop();
                    List<dynamic> temp = await pickImage(ImageSource.camera);
                    File? filedisplay = temp[0];

                    setState(()  {
                      print(temp);
                      MyFile = filedisplay;
                      ImageInString = temp[1];
                    });
                  }
              ),
              SimpleDialogOption(
                  padding: EdgeInsets.all(20),
                  child: Text('Gallery'),
                  onPressed: ()async{
                    Navigator.of(context).pop();
                    File? temp = await pickImage(ImageSource.gallery)[0];
                    setState(()  {
                      print(temp);
                      MyFile = temp;
                    });
                  }
              ),
            ],
          );
        }
    );

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
    return Scaffold(
        appBar: AppBar(
          title: Text("General Complaints",style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: mobileBackgroundColor,
        ),
        body: SafeArea(
          child: Column(
            children: [

              SizedBox(height: 64),

              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.4,
                child:

                MyFile==null ? Image.network('https://www.thepoortraveler.net/wp-content/uploads/2015/11/SPIN-Hostel-El-Nido-Shared-Bathroom.jpg',
                  fit: BoxFit.cover,
                )
                    :
                Image.file(MyFile!,fit: BoxFit.cover),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 40),
                child: TextFormField(controller: _messageController,
                  decoration: InputDecoration(
                    hintText: 'Enter your message',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  maxLines: 5,
                  minLines: 3
                ),
              ),


              MaterialButton(
                minWidth: MediaQuery.of(context).size.width*0.8,
                onPressed: () => _selectImage(context),
                color: Colors.blue,
                child: Text('Choose',style: TextStyle(color: Colors.white)),
              ),

              SizedBox(height: 20),

              MaterialButton(
                minWidth: MediaQuery.of(context).size.width*0.8,
                 onPressed: () async {

                   // Provider.of<MyImageProvider>(context,listen:false).setImage(MyFile!);


                  if(MyFile==null) showSnackBar('Choose an image first', context);
                  else{

                    String message = _messageController.text;

                    setState(() {
                      isLoading = true;
                    });

                    String result = await storageMethods.uploadGeneralComplaints(ImageInString!,message,user!);
                    print(result);

                    setState(() {
                      isLoading = false;
                    });

                    if(result!='success'){
                      showSnackBar(result,context);
                    }
                    else{
                      Navigator.pushNamed(context, StatusScreen.PageRoute,arguments: {'user' : user, 'type' : 'General Complaints'});
                    }

                  }
                 },
                color: Colors.blue,
                child: Text('Upload',style: TextStyle(color: Colors.white)),
              ),

            ],
          ),
        )
    );
  }
}
