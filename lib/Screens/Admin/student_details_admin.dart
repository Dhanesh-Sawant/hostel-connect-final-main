import 'package:flutter/material.dart';
import 'package:hostel_connect/Screens/Admin/block_users.dart';
import 'package:hostel_connect/Utils/colors.dart';
import 'package:provider/provider.dart';

import '../../Provider/admin_provider.dart';
import '../../Provider/block_users_provider.dart';
import 'home_screen_admin.dart';

class StudentDetailsAdmin extends StatefulWidget {
  const StudentDetailsAdmin({Key? key}) : super(key: key);

  static String PageRoute = 'StudentDetailsAdmin';

  @override
  State<StudentDetailsAdmin> createState() => _StudentDetailsAdminState();
}

class _StudentDetailsAdminState extends State<StudentDetailsAdmin> {

  List<String> blocks = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R'];



  String? adminblock;

  getAdminBlock(){
    adminblock = Provider.of<AdminProvider>(context,listen:false).getBlock;
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getAdminBlock();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blocks'),
        actions: [
          IconButton(onPressed: (){Navigator.pushNamed(context, HomeScreenAdmin.PageRoute);}, icon: Icon(Icons.home))
        ],
        centerTitle: true,
        backgroundColor: mobileBackgroundColor,
        automaticallyImplyLeading: true,
      ),
      body: Container(
        child: ListView.builder(
          itemCount: blocks.length,
            itemBuilder: (context,index){
            return ListTile(
              title: Text(blocks[index]),
              onTap: () async {
                Navigator.pushNamed(context, BlockUsers.PageRoute, arguments: {'block' : blocks[index]});
              },
            );
            }
        )
      ),
    );
  }
}


