import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';
import '../Models/Users.dart' as model;
import '../Provider/image_provider.dart';
import '../Provider/user_provider.dart';
import 'package:intl/intl.dart';


FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;


class StorageMethods{


  Future<String> uploadDataRealTime(String type, String timming, String message,model.User user) async {

    String result = 'some error';

    DateTime now = DateTime.now();
    String timeAt = DateFormat('dd-MM – kk:mm').format(now);

    // String timeAt = now.toString();

    print(now.toString());

    
    try{

      DocumentReference<Map<String, dynamic>> ref = await firebaseFirestore.collection('Complaints').doc(type);

      // DocumentSnapshot<Map<String,dynamic>> snapshot = await ref.get();

      CollectionReference collectionRef = ref.collection(user.roomNo);
      QuerySnapshot querySnapshot = await collectionRef.limit(1).get();
      print(querySnapshot.size);

      if(querySnapshot.size == 1){
        result = "already processing request for this room";
      }
      else{
        firebaseFirestore.collection('Complaints').doc(type).collection(user.roomNo).doc(user.uid).set(
            {
              "message" : message,
              "status" : "waiting",
              "timming" : timming,
              "timeAt" : timeAt,
              "username" : user.username,
              "uid" : user.uid
            }
        );

        print("exit");
        result = "success";
      }


      return result;

    }catch(e){
      result = e.toString();
      return result;
    }
  }

  Future<String> uploadGeneralComplaints(String file, String message, model.User user) async {

    String result = 'some error';

    DateTime now = DateTime.now();
    String timeAt = DateFormat('dd-MM – kk:mm').format(now);

    // String timeAt = now.toString();

    print(now.toString());


    try{

      // String? file = .of<MyImageProvider>(context as BuildContext,listen:false).getImage;

      DocumentReference<Map<String, dynamic>> ref = await firebaseFirestore.collection('Complaints').doc('General Complaints');

      CollectionReference collectionRef = ref.collection(user.uid);
      QuerySnapshot querySnapshot = await collectionRef.limit(1).get();
      print(querySnapshot.size);


      firebaseFirestore.collection('Complaints').doc('General Complaints').collection(user.uid).doc((querySnapshot.size+1).toString()).set(
           {
              "message" : message,
              "status" : "waiting",
              "timeAt" : timeAt,
              "username" : user.username,
              "uid" : user.uid,
             "image": file
            }
        );

        print("exit");
        result = "success";


      return result;

    }catch(e){
      result = e.toString();
      return result;
    }
  }


}
