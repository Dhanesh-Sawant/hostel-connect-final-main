import 'package:flutter/material.dart';
import 'package:hostel_connect/Screens/Users/home_screen_user.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  static String PageRoute = 'OtpScreen';

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {


  @override
  Widget build(BuildContext context) {

    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    OtpTimerButtonController controller = OtpTimerButtonController();

    TextEditingController textEditingController = TextEditingController();
    int currentIndex = 0;

    return Container(
      decoration:  BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff7758cf), Color(0xff0b0d0f), Color(0xff0b0d0f)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 72),
              Text('Enter Your OTP',style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),),
          PinCodeTextField(
            appContext: context,
            length: 6, // Length of your OTP
            onChanged: (value) {
              // This callback will be invoked when OTP values change
              setState(() {
                currentIndex = value.length;
              });
            },
            controller: textEditingController,
            autoFocus: true,
            keyboardType: TextInputType.number,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.underline,
              fieldHeight: 50,
              fieldWidth: 40,
              activeFillColor: Colors.transparent,
            ),
            animationType: AnimationType.fade,
            animationDuration: Duration(milliseconds: 300),
            cursorColor: Colors.blue,
            enableActiveFill: false,
            onCompleted: (value) {

              textEditingController.text = value;

              print(value);
              print(textEditingController.text);


              if(arguments['OTP'] == value){
                Navigator.pushNamed(context, HomeScreenUser.PageRoute);
              }
              else{
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Wrong OTP'),
                    backgroundColor: Colors.red,
                  ),
                );
              }

            },
          ),
              Center(child: OtpTimerButton(
                controller: controller,
                height: 60,
                text: Text(
                  'Resend OTP',
                ),
                duration: 60,
                radius: 30,
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                buttonType: ButtonType.text_button, // or ButtonType.outlined_button
                loadingIndicator: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.red,
                ),
                loadingIndicatorColor: Colors.red,
                onPressed: () {},
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
