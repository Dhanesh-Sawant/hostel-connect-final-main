
import 'package:flutter/material.dart';
import 'package:hostel_connect/Provider/admin_provider.dart';
import 'package:hostel_connect/Screens/Admin/dashboard_admin.dart';
import 'package:hostel_connect/Utils/colors.dart';
import 'package:provider/provider.dart';
import '../../Provider/block_users_provider.dart';
import '../../Utils/app_style.dart';
import '../../Utils/my_drawer_list.dart';
import '../../Utils/my_header_drawer.dart';
import '../../Widgets/reusable_button.dart';
import 'admin_reusable_button.dart';
import 'general_comp_page.dart';

class HomeScreenAdmin extends StatefulWidget {
  const HomeScreenAdmin({Key? key}) : super(key: key);

  static String PageRoute = 'HomeScreenAdmin';

  @override
  State<HomeScreenAdmin> createState() => _HomeScreenAdminState();
}


class _HomeScreenAdminState extends State<HomeScreenAdmin> {


  Map<String,dynamic>? map;
  List<String>? users;

  String? adminblock;

  Future<String> getUsername() async{
    await Future.delayed(Duration(seconds: 1));
      return Provider.of<AdminProvider>(context,listen:false).getUsername;
  }


  Future<void> refreshAdmin()async{
    await Provider.of<AdminProvider>(context,listen:false).refreshAdmin();
  }

  Future<void> getadminblock() async{
    adminblock = await Provider.of<AdminProvider>(context,listen: false).getBlock;
  }

  Future<void> setBlockUsers() async {
      print('Admin block: $adminblock');
      await Provider.of<BlockUsersProvider>(context,listen: false).setBlockUsers(adminblock!);
  }

  setInitData() async {

    await Future.wait([
      refreshAdmin(),
    ]);
    print("refreshed admin");

    await Future.wait([
      getadminblock(),
    ]);
    print("got admin block");

    await Future.wait([
      setBlockUsers()
    ]);
    print("set block users");

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setInitData();
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
            body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
                  child: FutureBuilder(
                      future: getUsername(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          // While data is being loaded, you can show a loading indicator.
                          return Center(child: CircularProgressIndicator(color: Colors.blue));
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          // Once the data is loaded, build the UI with the username.
                          return buildBodyWithUsername(snapshot.data.toString());
                        }
                      }
                  ),
                )))
    );
  }

  Widget buildBodyWithUsername(String UN) {
    return Column(
      children: [
        Row(
          children: [
            Text('Hi $UN', style: appTextStyle(28.0, Colors.white, FontWeight.w500)),
            Expanded(child: Container()),
            IconButton(
              onPressed: () {
              },
              icon: Icon(Icons.settings, color: Colors.white, size: 30),
            ),
            SizedBox(width: 1),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height*0.05),
        Column(
          children:  [
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AdminReusableButton(content: 'Room Cleaning', url: 'Janitor.png'),
                  AdminReusableButton(content: 'Carpentry', url: 'Saw.png'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AdminReusableButton(content: 'Electric Complaint', url: 'Idea.png'),
                  AdminReusableButton(content: 'AC complaint', url: 'Air Conditioner.png'),
                ],
              ),
            ),
            AdminReusableButton(content: 'General Complaints', url: 'Broom.png')
          ],
        ),
      ],
    );
  }


}

// Scaffold(
// appBar: AppBar(
// backgroundColor: mobileBackgroundColor,
// automaticallyImplyLeading: true,
// title: Text('Admin home page'),
// ),
// body: Padding(
// padding: const EdgeInsets.all(8.0),
// child: Center(
// child: Column(
// // crossAxisAlignment: CrossAxisAlignment.center,
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Padding(
// padding: const EdgeInsets.only(bottom: 24.0),
// child: MaterialButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => GeneralCompPage()));}, color: Colors.blue, child: Text('General Complaints'),minWidth: MediaQuery.of(context).size.width*0.5),
// ),
// Padding(
// padding: const EdgeInsets.only(bottom: 24.0),
// child: MaterialButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DashBoardAdmin(type: 'Room Cleaning')));}, color: Colors.blue, child: Text('Room Cleaning'),minWidth: MediaQuery.of(context).size.width*0.5),
// ),
// Padding(
// padding: const EdgeInsets.only(bottom: 24.0),
// child: MaterialButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DashBoardAdmin(type: 'AC complaint')));}, color: Colors.blue, child: Text('AC complaint'),minWidth: MediaQuery.of(context).size.width*0.5),
// ),
// Padding(
// padding: const EdgeInsets.only(bottom: 24.0),
// child: MaterialButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DashBoardAdmin(type: 'Electric Complaint')));}, color: Colors.blue, child: Text('Electric Complaint'),minWidth: MediaQuery.of(context).size.width*0.5),
// ),
// MaterialButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DashBoardAdmin(type: 'Carpentry')));}, color: Colors.blue, child: Text('Carpentry'),minWidth: MediaQuery.of(context).size.width*0.5),
//
// ],
// ),
// )
// ),
// drawer: Drawer(
// child: Container(
// color: Color(0xff222222),
// child: Column(
// children: [
// MyHeaderDrawer(),
// MyDrawerList(),
// // Expanded(child: Container(child: Text("hi"),))
// // Container(
// //   child: Text("hello"),
// //   height: double.infinity,
// //   color: Color(0xff222222),
// // )
// ],
// ),
// ),
// ),
// );
//
