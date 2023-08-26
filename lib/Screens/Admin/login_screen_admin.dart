import 'package:flutter/material.dart';
import 'package:hostel_connect/Screens/Users/home_screen_user.dart';
import 'package:hostel_connect/Screens/Users/login_screen_user.dart';
// import '../Resources/auth_methods.dart';
import '../../Resources/auth_methods.dart';
import '../../Utils/colors.dart';
import '../../Utils/show_snackbar.dart';
import '../../Widgets/text_field.dart';
import '../../Utils/app_style.dart';
import 'home_screen_admin.dart';


class LoginScreenAdmin extends StatefulWidget {
  const LoginScreenAdmin({Key? key}) : super(key: key);

  static String PageRoute = 'LoginScreenAdmin';

  @override
  State<LoginScreenAdmin> createState() => _LoginScreenAdminState();
}


class _LoginScreenAdminState extends State<LoginScreenAdmin> {

  final TextEditingController _usernameEditingController = TextEditingController();
  final TextEditingController _passwordEditingController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _usernameEditingController.dispose();
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
                        hintText: 'Enter your username here..',
                        textinputType: TextInputType.text,
                        textEditingController: _usernameEditingController,
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
                          setState(() {
                            _isLoading = true;
                          });

                          String result = await AuthMethods().LogIn(
                              username: _usernameEditingController.text,
                              password: _passwordEditingController.text
                          );

                          print(result + "login");

                          setState(() {
                            _isLoading = false;
                          });

                          if(result!='admin'){
                            if(result=='user'){
                              showSnackBar('admin not found', context);
                              AuthMethods().SignOut();
                            }
                            showSnackBar(result, context);
                          }
                          else {
                            Navigator.pushNamed(context, HomeScreenAdmin.PageRoute);
                          }
                        },
                        color: blueColor,
                        minWidth: double.infinity,
                        child: _isLoading ? Center(child: CircularProgressIndicator(color: Colors.white)) : Text('Log in',style: appTextStyle(16,Colors.white,FontWeight.bold)),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Login as'),
                          GestureDetector(
                            child: Text(" Users",style: appTextStyle(15, blueColor, FontWeight.bold)),
                            onTap: (){
                              Navigator.pushNamed(context, LoginScreenUser.PageRoute);
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
