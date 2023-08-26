// host: "email-smtp.ap-south-1.amazonaws.com",
// auth: true,
// username: "AKIA5HGMOSPDGL6UO5GA",
// password: "BAF2zD1+YMaMWAQTGJPVbGCkSDOahWFT/ZVkfc0T1qy+",
// secure: "TLS",
// port: 25

import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_connect/Screens/Users/home_screen_user.dart';
import 'package:hostel_connect/Screens/Admin/login_screen_admin.dart';
import 'package:hostel_connect/Utils/otp_verification.dart';
// import '../Resources/auth_methods.dart';
import '../../Resources/auth_methods.dart';
import '../../Utils/colors.dart';
import '../../Utils/show_snackbar.dart';
import '../../Widgets/text_field.dart';
import '../../Utils/app_style.dart';
import 'layout_screen.dart';


class LoginScreenUser extends StatefulWidget {
  const LoginScreenUser({Key? key}) : super(key: key);

  static String PageRoute = 'LoginScreenUser';

  @override
  State<LoginScreenUser> createState() => _LoginScreenUserState();
}


class _LoginScreenUserState extends State<LoginScreenUser> {

  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController = TextEditingController();

  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // EmailAuth = new EmailAuth(
    //   sessionName: "Sample session",
    // );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(child: Container(),flex: 1),
                      Text('Hostel Connect',style: appTextStyle(30, blueColor, FontWeight.bold),),

                      SizedBox(height: 72),
                      InputTextField(
                        hintText: 'Enter your Email-Id here..',
                        textinputType: TextInputType.text,
                        textEditingController: _emailEditingController,
                      ),
                      SizedBox(height: 16),
                      InputTextField(
                        hintText: 'Enter your Password here..',
                        textinputType: TextInputType.visiblePassword,
                        textEditingController: _passwordEditingController,
                        isPass: true,
                      ),

                      SizedBox(height: 24),
                      MaterialButton(
                        onPressed: ()async{

                          // setState(() {
                          //   loading = true;
                          // });
                          //
                          // print(_emailEditingController.text);

                          setState(() {
                            loading = true;
                          });

                          String result = await AuthMethods().LogIn(
                              username: _emailEditingController.text,
                              password: _passwordEditingController.text
                          );

                          print(result + "login");

                          setState(() {
                            loading = false;
                          });

                          if(result!='user'){
                            if(result=='admin'){
                              showSnackBar('user not found', context);
                              AuthMethods().SignOut();
                            }
                            else{
                              showSnackBar(result, context);
                            }
                          }
                          else {
                            Navigator.pushNamed(context, LayoutScreen.PageRoute);
                          }
                        },
                        color: blueColor,
                        minWidth: double.infinity,
                        child: loading ? CircularProgressIndicator(color: Colors.white) : Text('Get OTP',style: appTextStyle(16,Colors.white,FontWeight.bold)),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Login as'),
                          GestureDetector(
                            child: Text(" Admin",style: appTextStyle(15, blueColor, FontWeight.bold)),
                            onTap: (){
                              Navigator.pushNamed(context, LoginScreenAdmin.PageRoute);
                            },
                          )
                        ],
                      ),

                      Flexible(child: Container(),flex: 1),
                    ],
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}
