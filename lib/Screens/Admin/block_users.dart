import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hostel_connect/Screens/Admin/selected_user.dart';
import 'package:provider/provider.dart';

import '../../Provider/admin_provider.dart';
import '../../Utils/colors.dart';
import 'home_screen_admin.dart';

class BlockUsers extends StatefulWidget {
  const BlockUsers({Key? key}) : super(key: key);

  static String PageRoute = 'BlockUsers';

  @override
  State<BlockUsers> createState() => _BlockUsersState();
}

class _BlockUsersState extends State<BlockUsers> {

  FirebaseDatabase database = FirebaseDatabase.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  List<Map<String,dynamic>> blockusers  = [];

  Map<String,String> userNameID = {};

  String? adminblock;

  Future<List<Map<String,dynamic>>> getBlockUsers() async {

    blockusers.clear();

    DocumentSnapshot<Map<String, dynamic>> result = await _firebaseFirestore.collection('Users').doc(adminblock).get();

    print(result.data());
    int blockUsers = result.data()?.length ?? 0;

      result.data()?.forEach((key, value) {
        blockusers.add(value);
      });


    // documents.forEach((element) {
    //   if(element.data()['block'] == block){
    //
    //     blockusers.add(element.data()['username']);
    //     userNameID.addAll({element.data()['username']:element.data()['uid']});
    //   }
    // });

    print(blockusers);
    return blockusers;

  }


  List<String> blocks = [
    'ALBERT EINSTEIN BLOCK - A',
    'CHARLES DARWIN BLOCK - N',
    'RAMANUJAM BLOCK - F',
    'R BLOCK - R',
    'NELSON MANDELA BLOCK ANNEXE - D ANNEX',
    'QUAID -E- MILLAT MUHAMMED ISMAIL BLOCK - M',
    'JOHN F KENNEDY BLOCK- J - J',
    'JOHN F KENNEDY BLOCK - H - H',
    'SOCRATES BLOCK - G',
    'SWAMI VIVEKANANDA BLOCK ANNEXE - B ANNEX',
    'SARDAR PATEL BLOCK - P',
    'NELSON MANDELA BLOCK - D',
    'RABINDRANATH TAGORE BLOCK - C',
    'VAJPAYEE BLOCK - Q',
    'Dr. SARVEPALLI RADHAKRISHNAN BLOCK - K',
    'SWAMI VIVEKANANDA BLOCK - B',
    'Sir. C.V. RAMAN BLOCK - E',
    "NETAJI SUBHAS CHANDRA BOSE BLOCK - L"
  ];


  getAdminBlock(){
    adminblock =  Provider.of<AdminProvider>(context,listen:false).getBlock;
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAdminBlock();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Block Users'),
        backgroundColor: mobileBackgroundColor,
        actions: [
          IconButton(onPressed: (){Navigator.pushNamed(context, HomeScreenAdmin.PageRoute);}, icon: Icon(Icons.home))
        ],
      ),
      body: Container(
        child: FutureBuilder<List<Map<String,dynamic>>>(
            future: getBlockUsers(),
            builder: (context,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return CircularProgressIndicator(color: blueColor);
              }
              else{
                return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context,index){
                      return ListTile(
                          title: Row(
                            children: [
                              Text(snapshot.data![index]['username']),
                              SizedBox(width: 10),
                              Text(snapshot.data![index]['roomNo']),
                            ],
                          ),
                        onTap: (){
                          Navigator.pushNamed(context, SelectedUser.PageRoute, arguments: {'user': snapshot.data![index]});
                        },
                      );
                    }
                );
              }
            }
        ),
      ),
    );
  }
}
