import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class StatusProvider with ChangeNotifier{

  CollectionReference ref = FirebaseFirestore.instance.collection('Complaints');

  late String status_RC;
  late String status_AC;
  late String status_EC;
  late String status_C;

  String get getStatus_RC => status_RC;
  String get getStatus_AC => status_AC;
  String get getStatus_EC => status_EC;
  String get getStatus_C => status_C;


  Future<void> refreshComplaintStatus(String uid, String RN)async{

    DocumentSnapshot<Map<String, dynamic>> snapshot_rc = await ref.doc('Room Cleaning').collection(RN).doc(uid).get();
    DocumentSnapshot<Map<String, dynamic>> snapshot_ec = await ref.doc('Electric Complaint').collection(RN).doc(uid).get();
    DocumentSnapshot<Map<String, dynamic>> snapshot_ac = await ref.doc('AC complaint').collection(RN).doc(uid).get();
    DocumentSnapshot<Map<String, dynamic>> snapshot_c = await ref.doc('Carpentry').collection(RN).doc(uid).get();

    status_RC =  snapshot_rc.data()!['status'].toString();
    status_AC =  snapshot_ac.data()!['status'].toString();
    status_EC =  snapshot_ec.data()!['status'].toString();
    status_C =  snapshot_c.data()!['status'].toString();

    notifyListeners();
  }


}