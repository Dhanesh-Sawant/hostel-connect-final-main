import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BlockUsersProvider with ChangeNotifier{

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  List<String>? adminblockusers;
  List<String>? blockuseroomNo;
  List<String>? blockuserUid;



  List<String>? get getblockusers => adminblockusers;
  List<String>? get getuserRoomNo => blockuseroomNo;
  List<String>? get getuserUid => blockuserUid;


  Future<void> setBlockUsers(String adminblock) async {

    List<String> temp1 = [];
    List<String> temp2 = [];
    List<String> temp3 = [];



    QuerySnapshot<Map<String,dynamic>> result = await _firebaseFirestore.collection('Users').get();
    List<QueryDocumentSnapshot<Map<String,dynamic>>> documents = result.docs;

    temp1.clear();
    temp2.clear();
    temp3.clear();

    documents.forEach((element) {
      // print(element.data()['block']);

      if(element.data()['block'] == adminblock){
        temp1?.add(element.data()['username']);
        temp2?.add(element.data()['roomNo']);
        temp3?.add(element.data()['uid']);
      }
    });

    // print("from provider $temp1");

    adminblockusers = temp1;
    blockuseroomNo = temp2;

  }

}