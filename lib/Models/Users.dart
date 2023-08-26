import 'package:cloud_firestore/cloud_firestore.dart';

class User{

  final String username;
  final String uid;
  final String roomNo;
  final String block;

  const User({
    required this.username,
    required this.uid,
    required this.roomNo,
    required this.block
  });

  Map<String,dynamic> toJson() => {
    'username': username,
    'uid' : uid,
    'roomNo' : roomNo,
    'block' : block
  };


  // take user snapshot and return user model
  static User fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String,dynamic>;

    return User(
      username: snapshot['username'],
      uid: snapshot['uid'],
      roomNo: snapshot['roomNo'],
      block: snapshot['block']
    );
  }

}

