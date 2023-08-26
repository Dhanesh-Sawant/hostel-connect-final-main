import 'package:cloud_firestore/cloud_firestore.dart';

class Admin{

  final String username;
  final String eid;
  final String block;

  const Admin({
    required this.username,
    required this.eid,
    required this.block
  });

  Map<String,dynamic> toJson() => {
    'username': username,
    'eid' : eid,
    'block' : block
  };


  // take user snapshot and return user model
  static Admin fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String,dynamic>;

    return Admin(
        username: snapshot['username'],
        eid: snapshot['eid'],
        block: snapshot['block']
    );
  }

}

