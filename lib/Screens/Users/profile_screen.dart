import 'package:flutter/material.dart';
import 'package:hostel_connect/Resources/auth_methods.dart';
import 'package:hostel_connect/Screens/Users/login_screen_user.dart';
import 'package:provider/provider.dart';
import '../../Models/Users.dart';
import '../../Provider/user_provider.dart';
import '../../Utils/app_style.dart';
import '../../Utils/colors.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  late User user;

  Future<User> getUser() async {

    user = await Provider.of<UserProvider>(context,listen:false).getUser;

    return user;
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
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.grey.withOpacity(0.01),
          title: Text("My Account", style: appTextStyle(25, purplemaincolor, FontWeight.bold) ),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 30),
              Container(
                  decoration: BoxDecoration(
                  color: Color(0xff373737),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                height: MediaQuery.of(context).size.height * 0.46,
                width: MediaQuery.of(context).size.width*0.8,
                child: FutureBuilder<User>(
                  future: getUser(),
                  builder: (BuildContext context, AsyncSnapshot<User> snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator(color: purplemaincolor,));
                    }
                    else if(snapshot.hasError){
                      return Center(child: Text("Error"));
                    }
                    else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Name", style: appTextStyle(20, purplemaincolor, FontWeight.bold)),
                              Text(snapshot.data!.username, style: appTextStyle(22, Colors.white, FontWeight.normal)),
                              SizedBox(height: 10,),
                              Text("Registration No.", style: appTextStyle(20, purplemaincolor, FontWeight.bold)),
                              Text(snapshot.data!.uid, style: appTextStyle(22, Colors.white, FontWeight.normal)),
                              SizedBox(height: 10,),
                              Text("Block", style: appTextStyle(20, purplemaincolor, FontWeight.bold)),
                              Text(snapshot.data!.block, style: appTextStyle(22, Colors.white, FontWeight.normal)),
                              SizedBox(height: 10,),
                              Text("Room No.", style: appTextStyle(20, purplemaincolor, FontWeight.bold)),
                              Text(snapshot.data!.roomNo, style: appTextStyle(22, Colors.white, FontWeight.normal)),
                            ]
                        ),
                      );
                    }
                  },

                )
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: MaterialButton(
                  minWidth: 130,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  color: Colors.red,
                  child: Text("Logout", style: appTextStyle(20, Colors.white, FontWeight.normal)),
                    onPressed: (){
                      AuthMethods().SignOut();
                      Navigator.pushNamed(context, LoginScreenUser.PageRoute);
                    }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
