import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:hostel_connect/Provider/admin_provider.dart';
import 'package:hostel_connect/Provider/status_provider.dart';
import 'package:hostel_connect/Screens/Admin/dashboard_admin.dart';
import 'package:hostel_connect/Screens/Admin/general_comp_page.dart';
import 'package:hostel_connect/Screens/Users/complaint_card_screen.dart';
import 'package:hostel_connect/Screens/Users/home_screen_user.dart';
import 'package:hostel_connect/Screens/Users/login_screen_user.dart';
import 'package:hostel_connect/Screens/Users/mycomplaints.dart';
import 'package:hostel_connect/Screens/Users/otp_screen.dart';
import 'package:hostel_connect/Screens/Users/status_screen.dart';
import 'package:provider/provider.dart';
import 'Provider/block_users_provider.dart';
import 'Provider/sense_change_provider.dart';
import 'Provider/user_provider.dart';
import 'Screens/Admin/actions_admin.dart';
import 'Screens/Admin/block_users.dart';
import 'Screens/Admin/edit_details.dart';
import 'Screens/Admin/home_screen_admin.dart';
import 'Screens/Admin/login_screen_admin.dart';
import 'Screens/Admin/selected_user.dart';
import 'Screens/Admin/student_details_admin.dart';
import 'Screens/Users/general_complaints.dart';
import 'Screens/Users/layout_screen.dart';
import 'Utils/colors.dart';
import 'Utils/otp_verification.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(

      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => StatusProvider()),
        ChangeNotifierProvider(create: (_) => AdminProvider()),
        ChangeNotifierProvider(create: (_) => BlockUsersProvider()),
         ChangeNotifierProvider(create: (_) => SenseChangeProvider()),
        // to get current user and to refresh user
      ],

      child : MaterialApp(

        routes: {
          LoginScreenUser.PageRoute : (context) => LoginScreenUser(),
          LoginScreenAdmin.PageRoute : (context) => LoginScreenAdmin(),
          HomeScreenUser.PageRoute : (context) => HomeScreenUser(),
          HomeScreenAdmin.PageRoute : (context) => HomeScreenAdmin(),
          ComplaintCard.PageRoute : (context) => ComplaintCard(),
          StatusScreen.PageRoute : (context) => StatusScreen(),
          StudentDetailsAdmin.PageRoute : (context) => StudentDetailsAdmin(),
          ActionsAdmin.PageRoute : (context) => ActionsAdmin(),
          BlockUsers.PageRoute : (context) => BlockUsers(),
          SelectedUser.PageRoute : (context) => SelectedUser(),
          EditDetails.PageRoute : (context) => EditDetails(),
          GeneralComplaints.PageRoute : (context) => GeneralComplaints(),
          OtpVerification.PageRoute : (context) => OtpVerification(),
          MyComplaints.PageRoute : (context) => MyComplaints(),
          LayoutScreen.PageRoute : (context) => LayoutScreen(),
          OtpScreen.PageRoute : (context) => OtpScreen(),
        },

        debugShowCheckedModeBanner: false,
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        title: 'Hostel Connect',
        theme: ThemeData.dark().copyWith(
          // primaryColor: Colors.blueGrey,
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: LoginScreenUser(),
      )

    );
  }
}