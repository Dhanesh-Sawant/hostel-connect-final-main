import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_otp/email_otp.dart';

class OtpVerification extends StatefulWidget {

  static String PageRoute = 'OtpVerification';

  @override
  State<OtpVerification> createState() => _OtpVerificationState();

}

class _OtpVerificationState extends State<OtpVerification> {
  @override

  String? pin1,pin2,pin3,pin4,pin5,pin6;
  EmailOTP myauth = EmailOTP();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  Widget build(BuildContext context) {

    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(color: Color(0xFF474646)),
            child: Stack(
              children: [
                Positioned(
                  // left: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.85,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: -17,
                  top: 0,
                  child: Container(
                    width: 407,
                    height: 44,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 407,
                            height: 30,
                            child: Stack(children: [
                                // Image.network('https://picsum.photos/seed/1/600'),
                                ]),
                          ),
                        ),
                        Positioned(
                          left: 324,
                          top: 16,
                          child: Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 20,
                                  height: 14,
                                  child: Stack(children: [
                                    // Image.network('https://picsum.photos/seed/1/600'),
                                      ]),
                                ),
                                const SizedBox(width: 4),
                                Container(
                                  width: 16,
                                  height: 15,
                                  padding: const EdgeInsets.only(
                                    top: 3,
                                    left: 1,
                                    right: 0.75,
                                    bottom: 2,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                    // Image.network('https://picsum.photos/seed/1/600'),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Container(
                                  width: 35,
                                  height: 14,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 2,
                                        top: 3,
                                        child: Container(
                                          width: 19,
                                          height: 8,
                                          decoration: ShapeDecoration(
                                            color: Colors.black,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 330,
                          top: 8,
                          child: Container(
                            width: 6,
                            height: 6,
                            child: Stack(children: [
                                // Image.network('https://picsum.photos/seed/1/600'),
                                ]),
                          ),
                        ),
                        Positioned(
                          left: 21,
                          top: 12,
                          child: Container(
                            width: 54,
                            height: 21,
                            padding: const EdgeInsets.only(top: 3, left: 11, right: 10, bottom: 3),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 33,
                                  height: 15,
                                  padding: const EdgeInsets.only(
                                    top: 2,
                                    left: 2,
                                    right: 2.57,
                                    bottom: 1.91,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      // Image.network('https://picsum.photos/seed/1/600'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: -72,
                  top: -205,
                  child: Opacity(
                    opacity: 0.20,
                    child: Container(
                      width: 543,
                      height: 543,
                      decoration: ShapeDecoration(
                        color: Color(0xFFF7A435),
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 222,
                  top: -130,
                  child: Opacity(
                    opacity: 0.20,
                    child: Container(
                      width: 392,
                      height: 392,
                      decoration: ShapeDecoration(
                        color: Color(0xFFF69007),
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width*0.32,
                  top: 431,
                  child: Text(
                    'OTP Verification',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF474646),
                      fontSize: 22,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Positioned(
                  left: 86,
                  top: 719,
                  child: GestureDetector(
                    onTap: () async {
                      var inputOTP = (pin1!+pin2!+pin3!+pin4!+pin5!+pin6!);
                      print(inputOTP);
                      String result = await myauth.verifyOTP(
                          otp: inputOTP
                      );
                      print(result);
                    },
                    child: Container(
                      width: 259,
                      height: 39,
                      decoration: ShapeDecoration(
                        color: Color(0xFFF7A435),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 0.25, color: Color(0xFFF8CA8C)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width*0.31,
                  top: 825,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'You  have an account ? ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        TextSpan(
                          text: 'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width*0.45,
                  top: 727,
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Positioned(
                  left: 80,
                  top: 469,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'We Will send you a one time password on\n this  ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'Outfit',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: 'Email-Id',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'Outfit',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Positioned(
                  left: 152,
                  top: 517,
                  child: Text(
                    arguments['email'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                Positioned(
                  left: 107,
                  top: 570,
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: ShapeDecoration(
                      color: Color(0xFFF6F6F6),
                      shape: OvalBorder(
                        side: BorderSide(width: 0.50, color: Color(0xFFF49516)),
                      ),
                    ),
                    child: TextFormField(

                      cursorColor: Colors.black,
                      onSaved: (pin1){
                      },
                      onChanged: (value){
                        if(value.length == 1){
                          pin1 = value;
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 167,
                  top: 570,
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: ShapeDecoration(
                      color: Color(0xFFF6F6F6),
                      shape: OvalBorder(
                        side: BorderSide(width: 0.50, color: Color(0xFFF49516)),
                      ),
                    ),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      onSaved: (pin2){},
                      onChanged: (value){
                        if(value.length == 1){
                          pin2 = value;
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 222,
                  top: 570,
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: ShapeDecoration(
                      color: Color(0xFFF6F6F6),
                      shape: OvalBorder(
                        side: BorderSide(width: 0.50, color: Color(0xFFF49516)),
                      ),
                    ),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      onSaved: (pin3){},
                      onChanged: (value){
                        if(value.length == 1){
                          pin3 = value;
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 280,
                  top: 570,
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: ShapeDecoration(
                      color: Color(0xFFF6F6F6),
                      shape: OvalBorder(
                        side: BorderSide(width: 0.50, color: Color(0xFFF49516)),
                      ),
                    ),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      onSaved: (pin4){},
                      onChanged: (value){
                        pin4 = value;
                        if(value.length == 1){
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 280,
                  top: 570,
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: ShapeDecoration(
                      color: Color(0xFFF6F6F6),
                      shape: OvalBorder(
                        side: BorderSide(width: 0.50, color: Color(0xFFF49516)),
                      ),
                    ),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      onSaved: (pin5){},
                      onChanged: (value){
                        pin5 = value;
                        if(value.length == 1){
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 280,
                  top: 570,
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: ShapeDecoration(
                      color: Color(0xFFF6F6F6),
                      shape: OvalBorder(
                        side: BorderSide(width: 0.50, color: Color(0xFFF49516)),
                      ),
                    ),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      onSaved: (pin6){},
                      onChanged: (value){
                        pin6 = value;
                        if(value.length == 1){
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width*0.47,
                  top: 629,
                  child: Text(
                    '00.30 ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF675A5A),
                      fontSize: 12,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width*0.32,
                  top: 661,
                  child: Opacity(
                    opacity: 0.30,
                    child: Text(
                      'Do not send OTP  ?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width*0.57,
                  top: 661,
                  child: Opacity(
                    opacity: 0.30,
                    child: Text(
                      'Send OTP',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFE8890A),
                        fontSize: 12,
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 15,
                  top: 49,
                  child: Opacity(
                    opacity: 0.65,
                    child: Container(
                      width: 30,
                      height: 31,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(width: 30, height: 31),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 40,
                  top: 148,
                  child: Container(
                    width: 332,
                    height: 249,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 330,
                          height: 249,
                          child: Stack(
                            children: [
                              Positioned(
                                left: MediaQuery.of(context).size.width*0.05,
                                top: 0,
                                child: Container(
                                  width: 307.60,
                                  height: 247.89,
                                  child: Stack(children: [
                                    // Image.asset(),
                                      ]),
                                ),
                              ),
                              Positioned(
                                left: 166.14,
                                top: 1.54,
                                child: Container(
                                  width: 165.97,
                                  height: 43.97,
                                  child: Stack(children: [
                                    // Image.network('https://picsum.photos/seed/1/600'),
                                      ]),
                                ),
                              ),
                              Positioned(
                                left: 31.31,
                                top: 21.11,
                                child: Container(
                                  width: 287.28,
                                  height: 227.41,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 42.15,
                                        top: 0,
                                        child: Container(
                                          width: 86.83,
                                          height: 101.76,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 86.83,
                                                  height: 101.76,
                                                  child: Stack(children: [
                                                    // Image.network('https://picsum.photos/seed/1/600'),
                                                      ]),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 250.29,
                                        top: 17.30,
                                        child: Container(
                                          width: 36.99,
                                          height: 33.90,
                                          child: Stack(children: [
                                            // Image.network('https://picsum.photos/seed/1/600'),
                                              ]),
                                        ),
                                      ),
                                      Positioned(
                                        left: 86.79,
                                        top: 141.32,
                                        child: Container(
                                          width: 42.12,
                                          height: 27.59,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 24.82,
                                                top: 11.29,
                                                child: Container(
                                                  width: 13.73,
                                                  height: 11.27,
                                                  child: Stack(children: [
                                                      // Image.network('https://picsum.photos/seed/1/600'),
                                                      ]),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}