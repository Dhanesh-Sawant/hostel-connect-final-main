import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


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


  Future<void> refreshComplaintStatus(String uid, String RN)async{

    print("uid : $uid, room:  $RN");

    DocumentSnapshot<Map<String, dynamic>> snapshot_rc = await ref.doc('Room Cleaning').collection(RN).doc(uid).get();
    DocumentSnapshot<Map<String, dynamic>> snapshot_ec = await ref.doc('Electric Complaint').collection(RN).doc(uid).get();
    DocumentSnapshot<Map<String, dynamic>> snapshot_ac = await ref.doc('AC complaint').collection(RN).doc(uid).get();
    DocumentSnapshot<Map<String, dynamic>> snapshot_c = await ref.doc('Carpentry').collection(RN).doc(uid).get();

    // status_RC.clear();
    // status_AC.clear();
    // status_EC.clear();
    // status_C.clear();
    //
    // status_RC.add(snapshot_rc.data()?['status'].toString() ?? "-");
    // status_RC.add(snapshot_rc.data()?['dateAt'].toString() ?? "-");
    // status_RC.add(snapshot_rc.data()?['timeAt'].toString() ?? "-");
    //
    //
    // status_AC.add(snapshot_ac.data()?['status'].toString() ?? "-");
    // status_AC.add(snapshot_ac.data()?['dateAt'].toString() ?? "-");
    // status_AC.add(snapshot_ac.data()?['timeAt'].toString() ?? "-");
    //
    //
    //
    // status_EC.add(snapshot_ec.data()?['status'].toString() ?? "-");
    // status_EC.add(snapshot_ec.data()?['dateAt'].toString() ?? "-");
    // status_EC.add(snapshot_ec.data()?['timeAt'].toString() ?? "-");
    //
    //
    // status_C.add(snapshot_c.data()?['status'].toString() ?? "-");
    // status_C.add(snapshot_c.data()?['dateAt'].toString() ?? "-");
    // status_C.add(snapshot_c.data()?['timeAt'].toString() ?? "-");


    if(snapshot_rc.data()?['status'].toString() =="waiting"){

      if(int.parse(snapshot_rc.data()!['dateAt'].toString().substring(0,2) + snapshot_rc.data()!['timeAt'].toString().substring(0,2) + snapshot_rc.data()!['timeAt'].toString().substring(3,5), radix: 10) > waitingcounter)
      {
        waitingcounter = int.parse(snapshot_rc.data()!['dateAt'].toString().substring(0,2) + snapshot_rc.data()!['timeAt'].toString().substring(0,2) + snapshot_rc.data()!['timeAt'].toString().substring(3,5), radix: 10);
        print("rc $waitingcounter");
        latestwaiting = "Room Cleaning";
      }

    }
     if(snapshot_ac.data()?['status'].toString() =="waiting"){

      if(int.parse(snapshot_ac.data()!['dateAt'].toString().substring(0,2) + snapshot_ac.data()!['timeAt'].toString().substring(0,2) + snapshot_ac.data()!['timeAt'].toString().substring(3,5), radix: 10) > waitingcounter){
        waitingcounter = int.parse(snapshot_ac.data()!['dateAt'].toString().substring(0,2) + snapshot_ac.data()!['timeAt'].toString().substring(0,2) + snapshot_ac.data()!['timeAt'].toString().substring(3,5), radix: 10);
        print("ac $waitingcounter");
        latestwaiting = "AC Complaint";
      }
    }

     if(snapshot_ec.data()?['status'].toString() =="waiting"){
      if(int.parse(snapshot_ec.data()!['dateAt'].toString().substring(0,2) + snapshot_ec.data()!['timeAt'].toString().substring(0,2) + snapshot_ec.data()!['timeAt'].toString().substring(3,5), radix: 10) > waitingcounter){
        waitingcounter = int.parse(snapshot_ec.data()!['dateAt'].toString().substring(0,2) + snapshot_ec.data()!['timeAt'].toString().substring(0,2) + snapshot_ec.data()!['timeAt'].toString().substring(3,5), radix: 10);
        print("ec $waitingcounter");
        latestwaiting = "Electric Complaint";
      }
    }
     if(snapshot_c.data()?['status'].toString() =="waiting"){
      if(int.parse(snapshot_c.data()!['dateAt'].toString().substring(0,2) + snapshot_c.data()!['timeAt'].toString().substring(0,2) + snapshot_c.data()!['timeAt'].toString().substring(3,5), radix: 10) > waitingcounter){
        waitingcounter = int.parse(snapshot_c.data()!['dateAt'].toString().substring(0,2) + snapshot_c.data()!['timeAt'].toString().substring(0,2) + snapshot_c.data()!['timeAt'].toString().substring(3,5), radix: 10);
        print("c $waitingcounter");
        latestwaiting = "carpentry";
      }
    }


    if(snapshot_rc.data()?['status'].toString() =="progress"){
      latestprogress = "Room Cleaning";
    }
    else if(snapshot_ac.data()?['status'].toString() =="progress"){
      latestprogress = "AC Complaint";
    }
    else if(snapshot_ec.data()?['status'].toString() =="progress"){
      latestprogress = "Electric Complaint";
    }
    else if(snapshot_c.data()?['status'].toString() =="progress"){
      latestprogress = "Carpentry";
    }



    // print("printing from status provider : $status_RC $status_AC $status_EC $status_C");

    notifyListeners();
  }




}