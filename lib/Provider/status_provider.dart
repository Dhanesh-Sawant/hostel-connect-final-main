import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../Models/Users.dart';


class StatusProvider with ChangeNotifier{

  CollectionReference ref = FirebaseFirestore.instance.collection('Complaints');

  late List<String> status_RC = [];
  late List<String> status_AC = [];
  late List<String> status_EC = [];
  late List<String> status_C = [];


  String? latestwaiting;
  String? latestprogress;

  List<String> get getStatus_RC => status_RC;
  List<String> get getStatus_AC => status_AC;
  List<String> get getStatus_EC => status_EC;
  List<String> get getStatus_C => status_C;

  String? get getLatestWaiting => latestwaiting;
  String? get getLatestProgress => latestprogress;

  int waitingcounter = -1;
  int progresscounter = -1;


  Future<void> refreshComplaintStatus(User user)async{


    DocumentSnapshot<Map<String, dynamic>> W_snapshot_rc = await ref.doc('Room Cleaning').collection(user.block).doc("waiting").collection(user.roomNo).doc(user.uid).get();
    DocumentSnapshot<Map<String, dynamic>> W_snapshot_ec = await ref.doc('Electric Complaint').collection(user.block).doc("waiting").collection(user.roomNo).doc(user.uid).get();
    DocumentSnapshot<Map<String, dynamic>> W_snapshot_ac = await ref.doc('AC complaint').collection(user.block).doc("waiting").collection(user.roomNo).doc(user.uid).get();
    DocumentSnapshot<Map<String, dynamic>> W_snapshot_c = await ref.doc('Carpentry').collection(user.block).doc("waiting").collection(user.roomNo).doc(user.uid).get();

    DocumentSnapshot<Map<String, dynamic>> P_snapshot_rc = await ref.doc('Room Cleaning').collection(user.block).doc("progress").collection(user.roomNo).doc(user.uid).get();
    DocumentSnapshot<Map<String, dynamic>> P_snapshot_ec = await ref.doc('Electric Complaint').collection(user.block).doc("progress").collection(user.roomNo).doc(user.uid).get();
    DocumentSnapshot<Map<String, dynamic>> P_snapshot_ac = await ref.doc('AC complaint').collection(user.block).doc("progress").collection(user.roomNo).doc(user.uid).get();
    DocumentSnapshot<Map<String, dynamic>> P_snapshot_c = await ref.doc('Carpentry').collection(user.block).doc("progress").collection(user.roomNo).doc(user.uid).get();




    if(W_snapshot_rc.exists){
      if(int.parse(W_snapshot_rc.data()!['dateAt'].toString().substring(0,2) + W_snapshot_rc.data()!['timeAt'].toString().substring(0,2) + W_snapshot_rc.data()!['timeAt'].toString().substring(3,5), radix: 10) > waitingcounter)
      {
        waitingcounter = int.parse(W_snapshot_rc.data()!['dateAt'].toString().substring(0,2) + W_snapshot_rc.data()!['timeAt'].toString().substring(0,2) + W_snapshot_rc.data()!['timeAt'].toString().substring(3,5), radix: 10);
        print("rc $waitingcounter");
        latestwaiting = "Room Cleaning";
      }

    }
     if(W_snapshot_ec.exists){
      if(int.parse(W_snapshot_ec.data()!['dateAt'].toString().substring(0,2) + W_snapshot_ec.data()!['timeAt'].toString().substring(0,2) + W_snapshot_ec.data()!['timeAt'].toString().substring(3,5), radix: 10) > waitingcounter){
        waitingcounter = int.parse(W_snapshot_ec.data()!['dateAt'].toString().substring(0,2) + W_snapshot_ec.data()!['timeAt'].toString().substring(0,2) + W_snapshot_ec.data()!['timeAt'].toString().substring(3,5), radix: 10);
        print("ac $waitingcounter");
        latestwaiting = "AC Complaint";
      }
    }

     if(W_snapshot_ac.exists){
      if(int.parse(W_snapshot_ac.data()!['dateAt'].toString().substring(0,2) + W_snapshot_ac.data()!['timeAt'].toString().substring(0,2) + W_snapshot_ac.data()!['timeAt'].toString().substring(3,5), radix: 10) > waitingcounter){
        waitingcounter = int.parse(W_snapshot_ac.data()!['dateAt'].toString().substring(0,2) + W_snapshot_ac.data()!['timeAt'].toString().substring(0,2) + W_snapshot_ac.data()!['timeAt'].toString().substring(3,5), radix: 10);
        print("ec $waitingcounter");
        latestwaiting = "Electric Complaint";
      }
    }
     if(W_snapshot_c.exists){
      if(int.parse(W_snapshot_c.data()!['dateAt'].toString().substring(0,2) + W_snapshot_c.data()!['timeAt'].toString().substring(0,2) + W_snapshot_c.data()!['timeAt'].toString().substring(3,5), radix: 10) > waitingcounter){
        waitingcounter = int.parse(W_snapshot_c.data()!['dateAt'].toString().substring(0,2) + W_snapshot_c.data()!['timeAt'].toString().substring(0,2) + W_snapshot_c.data()!['timeAt'].toString().substring(3,5), radix: 10);
        print("c $waitingcounter");
        latestwaiting = "carpentry";
      }
    }


    if(P_snapshot_rc.exists){
      latestprogress = "Room Cleaning";
    }
    else if(P_snapshot_ec.exists){
      latestprogress = "AC Complaint";
    }
    else if(P_snapshot_ac.exists){
      latestprogress = "Electric Complaint";
    }
    else if(P_snapshot_c.exists){
      latestprogress = "Carpentry";
    }

    notifyListeners();
  }




}