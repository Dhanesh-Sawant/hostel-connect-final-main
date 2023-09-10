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


    DocumentSnapshot<Map<String, dynamic>> result = await _firebaseFirestore.collection('Users').doc(adminblock).get();


    temp1.clear();
    temp2.clear();
    temp3.clear();

    result.data()?.forEach((key, value) {
      temp1.add(value['username']);
      temp2.add(value['roomNo']);
      temp3.add(value['uid']);
    });



    adminblockusers = temp1;
    blockuseroomNo = temp2;

  }

}