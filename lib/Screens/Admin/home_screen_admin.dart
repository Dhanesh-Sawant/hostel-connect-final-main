import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hostel_connect/Provider/admin_provider.dart';
import 'package:hostel_connect/Screens/Admin/dashboard_admin.dart';
import 'package:hostel_connect/Utils/colors.dart';
import 'package:provider/provider.dart';
import '../../Provider/block_users_provider.dart';
import '../../Utils/my_drawer_list.dart';
import '../../Utils/my_header_drawer.dart';
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

  refreshAdmin()async{
    await Provider.of<AdminProvider>(context,listen:false).refreshAdmin();
  }

  getadminblock(){
    Future.delayed(Duration(seconds: 5),(){
      adminblock = Provider.of<AdminProvider>(context,listen: false).getBlock;
    });
  }

  setBlockUsers() async {

    Future.delayed(Duration(seconds: 7),() async {
      print('block: $adminblock');
      await Provider.of<BlockUsersProvider>(context,listen: false).setBlockUsers(adminblock!);
    });

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshAdmin();
    getadminblock();
    setBlockUsers();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        automaticallyImplyLeading: true,
        title: Text('Admin home page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: MaterialButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => GeneralCompPage()));}, color: Colors.blue, child: Text('General Complaints'),minWidth: MediaQuery.of(context).size.width*0.5),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: MaterialButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DashBoardAdmin(type: 'Room Cleaning')));}, color: Colors.blue, child: Text('Room Cleaning'),minWidth: MediaQuery.of(context).size.width*0.5),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: MaterialButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DashBoardAdmin(type: 'AC complaint')));}, color: Colors.blue, child: Text('AC complaint'),minWidth: MediaQuery.of(context).size.width*0.5),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: MaterialButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DashBoardAdmin(type: 'Electric Complaint')));}, color: Colors.blue, child: Text('Electric Complaint'),minWidth: MediaQuery.of(context).size.width*0.5),
              ),
              MaterialButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DashBoardAdmin(type: 'Carpentry')));}, color: Colors.blue, child: Text('Carpentry'),minWidth: MediaQuery.of(context).size.width*0.5),

            ],
          ),
        )
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawer(),
                MyDrawerList()
              ],
            ),
          ),
        ),
      ),
    );
  }
}



