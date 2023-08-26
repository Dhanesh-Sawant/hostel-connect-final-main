import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hostel_connect/Screens/Admin/selected_user.dart';

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

  List<String> blockusers  = [];

  Map<String,String> userNameID = {};


  Future<List<String>> getBlockUsers(String block) async {

    blockusers.clear();

    QuerySnapshot<Map<String,dynamic>> result = await _firebaseFirestore.collection('Users').get();
    List<QueryDocumentSnapshot<Map<String,dynamic>>> documents = result.docs;


    documents.forEach((element) {
      if(element.data()['block'] == block){

        blockusers.add(element.data()['username']);
        userNameID.addAll({element.data()['username']:element.data()['uid']});
      }
    });

    print(blockusers);

    return blockusers;

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;

    return Scaffold(
      appBar: AppBar(
        title: Text('Block Users'),
        backgroundColor: mobileBackgroundColor,
        actions: [
          IconButton(onPressed: (){Navigator.pushNamed(context, HomeScreenAdmin.PageRoute);}, icon: Icon(Icons.home))
        ],
      ),
      body: Container(
        child: FutureBuilder(
            future: getBlockUsers(arguments['block']),
            builder: (context, AsyncSnapshot<List<String>> snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return CircularProgressIndicator(color: blueColor);
              }
              else{
                return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context,index){
                      return ListTile(
                          title: Text(snapshot.data![index]),
                        onTap: (){
                            Navigator.pushNamed(context, SelectedUser.PageRoute, arguments: {'uid': userNameID[snapshot.data![index]]});
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
