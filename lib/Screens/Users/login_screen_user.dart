// host: "email-smtp.ap-south-1.amazonaws.com",
// auth: true,
// username: "AKIA5HGMOSPDGL6UO5GA",
// password: "BAF2zD1+YMaMWAQTGJPVbGCkSDOahWFT/ZVkfc0T1qy+",
// secure: "TLS",
// port: 25

// import 'dart:js_interop';
import 'dart:math';
import 'package:hostel_connect/Screens/Users/otp_screen.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
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

  bool isLoading = false;
  String? OTP;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailEditingController.dispose();
  }

  String generateOTP() {
    final random = Random();
    final otpLength = 6;
    final buffer = StringBuffer();
    for (var i = 0; i < otpLength; i++) {
      buffer.write(random.nextInt(10));
    }
    OTP = buffer.toString();
    return buffer.toString();
  }

  Future<String> sendOTP() async {

    String result = "";

    String otp = generateOTP();
    print(otp);

    String username = 'AKIA5HGMOSPDGL6UO5GA';
    String password = 'BAF2zD1+YMaMWAQTGJPVbGCkSDOahWFT/ZVkfc0T1qy+';

    final smtpServer = SmtpServer(
        "email-smtp.ap-south-1.amazonaws.com",
        port: 587,
        username: username,
        password: password
    );


    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address("sawant23122003@gmail.com", 'Hostel Connect')
      ..recipients.add(_emailEditingController.text)
      ..subject = 'Your Hostel Connect OTP'
      ..text = 'your otp $otp'
      ..html = "your otp is $otp";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      result =  "success";
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
        result =  "Error Sending OTP, Please Try Again";
      }
    }
    // DONE


    // Let's send another message using a slightly different syntax:
    //
    // Addresses without a name part can be set directly.
    // For instance `..recipients.add('destination@example.com')`
    // If you want to display a name part you have to create an
    // Address object: `new Address('destination@example.com', 'Display name part')`
    // Creating and adding an Address object without a name part
    // `new Address('destination@example.com')` is equivalent to
    // adding the mail address as `String`.
    //
    //
    // final equivalentMessage = Message()
    //   ..from = Address(username, 'Your name 😀')
    //   ..recipients.add(Address('destination@example.com'))
    //   ..ccRecipients.addAll([Address('destCc1@example.com'), 'destCc2@example.com'])
    //   ..bccRecipients.add('bccAddress@example.com')
    //   ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
    //   ..text = 'This is the plain text.\nThis is line 2 of the text part.'
    //   ..html = '<h1>Test</h1>\n<p>Hey! Here is some HTML content</p><img src="cid:myimg@3.141"/>'
    // ;

    // final sendReport2 = await send(equivalentMessage, smtpServer);

    // Sending multiple messages with the same connection
    //
    // Create a smtp client that will persist the connection
    var connection = PersistentConnection(smtpServer);

    // Send the first message
    await connection.send(message);

    // send the equivalent message
    // await connection.send(equivalentMessage);

    // close the connection
    await connection.close();

    return result;

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff7758cf), Color(0xff0b0d0f), Color(0xff0b0d0f)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 32),
              width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 72),
                        Text('Login to your',style: appTextStyle(30, Colors.white, FontWeight.bold),),
                        Text('Account',style: appTextStyle(30, Colors.white, FontWeight.bold),),

                        SizedBox(height: 148),

                        Text('Enter your VIT Email',style: appTextStyle(28, Color(0xffaa8bf7), FontWeight.bold)),
                        SizedBox(height: 16),
                        InputTextField(
                          textinputType: TextInputType.text,
                          textEditingController: _emailEditingController, hintText: '',
                        ),
                        SizedBox(height: 16),

                        SizedBox(height: 24),
                        Center(
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 46,
                            minWidth: MediaQuery.of(context).size.width*0.4,
                            color: purplemaincolor,
                              onPressed: () async {






                                  setState(() {
                                    isLoading = true;
                                  });

                                  String result = await sendOTP();

                                  setState(() {
                                    isLoading = false;
                                  });

                                  if(result=='success'){
                                    Navigator.pushNamed(context,OtpScreen.PageRoute, arguments: {'OTP': OTP});
                                  }
                                  else{
                                    showSnackBar(result, context);
                                  }
                                  },
                                    child: isLoading ? Center(child:
                                    CircularProgressIndicator(color: Colors.blue)) : Text("submit", style: appTextStyle(19, Colors.white, FontWeight.w600))
                                ),

                                ),



                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Login as'),
                                    GestureDetector(
                                      child: Text(" Admin", style: appTextStyle(15, blueColor, FontWeight.bold)),
                                      onTap: (){
                                        Navigator.pushNamed(context, LoginScreenAdmin.PageRoute, arguments: {'OTP': OTP});
                                    },
                            )
                          ],
                        ),
                      ],
                    ),
              )
          ),
        ),
    );
  }
}
