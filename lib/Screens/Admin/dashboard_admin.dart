import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hostel_connect/Utils/app_style.dart';
import 'package:provider/provider.dart';

import '../../Models/table.dart';
import '../../Provider/block_users_provider.dart';
import 'actions_admin.dart';

class DashBoardAdmin extends StatefulWidget {
  const DashBoardAdmin({Key? key, required this.type}) : super(key: key);

  final String type;

  @override
  State<DashBoardAdmin> createState() => _DashBoardAdminState();
}


class _DashBoardAdminState extends State<DashBoardAdmin> with TickerProviderStateMixin {

  final firestore = FirebaseFirestore.instance;

  int waiting=0;
  int progress=0;

  List<String> blockuserroomNo = [];

  List<TableData> tableDataListWaiting = [];
  List<TableData> tableDataListProgress = [];

  getMyBlockuserRoomNo() async {

      blockuserroomNo = Provider.of<BlockUsersProvider>(context,listen: false).getuserRoomNo!;
  }

  getWP() async {

      CollectionReference collectionRef = firestore.collection('Complaints');


      // print('blockusers are : $blockusers');

      waiting=0;
      progress=0;

      String roomNo;
      String username;
      String timeAt;
      String action;
      String message;
      String uid;

      tableDataListWaiting.clear();
      tableDataListProgress.clear();

      List<Future<void>> fetchFutures = [];


        for(int i =0; i<blockuserroomNo.length; i++){

          DocumentReference documentRef = collectionRef.doc(widget.type);
          final CollectionReference subcollectionRef = documentRef.collection(blockuserroomNo[i]);

          fetchFutures.add(
              subcollectionRef.get().then((querySnapshot) {
                if (querySnapshot.docs.isNotEmpty) {
                  // Collection exists and has documents
                  // print("Collection exists");

                  QueryDocumentSnapshot queryDocumentSnapshot = querySnapshot.docs.first;


                  roomNo = blockuserroomNo[i];
                  username = queryDocumentSnapshot.get('username');
                  timeAt = queryDocumentSnapshot.get('timeAt').toString();
                  action = queryDocumentSnapshot.get('status');
                  message = queryDocumentSnapshot.get('message');
                  uid = queryDocumentSnapshot.get('uid');

                  print(queryDocumentSnapshot.get('status'));

                  if(queryDocumentSnapshot.get('status')=="waiting"){
                    print("inside waiting");
                    setState(() {
                      waiting++;
                    });
                  }

                  if(queryDocumentSnapshot.get('status')=="progress"){
                    setState(() {
                      progress++;
                    });
                  }

                  TableData tableData = TableData(
                      roomNo: roomNo,
                      username: username,
                      timeAt: timeAt,
                      action: action,
                      message: message,
                      uid: uid
                  );

                  if(queryDocumentSnapshot.get('status') == "waiting"){
                    tableDataListWaiting.add(tableData);
                  }
                  else{
                    tableDataListProgress.add(tableData);
                  }

                } else {
                  // Collection is empty or does not exist
                  print("Collection does not exist");
                }
              }).catchError((error) {
                print("Error checking collection existence: $error");
              })
          );


        }

        await Future.wait(fetchFutures);
        print(blockuserroomNo);
        //
        // print("waiting: $waiting");
        // print("progress: $progress");


  }

  Future<List<TableData>> fetchWaitingTableData() async {
    return tableDataListWaiting;
  }

  Future<List<TableData>> fetchProgressTableData() async {
    return tableDataListProgress;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyBlockuserRoomNo();
    getWP();
  }

  late final TabController _tabController = TabController(
      length: 2, vsync: this
  );



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(widget.type),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Waiting : $waiting",style: appTextStyle(15, Colors.white, FontWeight.bold)),
                Text("Progress : $progress",style: appTextStyle(15, Colors.white, FontWeight.bold)),
                Text("Completed : 0",style: appTextStyle(15, Colors.white, FontWeight.bold))
              ],
            ),
          ),
          TabBar(
            tabs: const [
              Text('Waiting'),
              Text('Progress'),
            ],
            indicatorColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.label,
            controller: _tabController,
            isScrollable: false,
            labelColor: Colors.white,
            labelStyle: appTextStyle(17, Colors.white,FontWeight.bold),
            unselectedLabelColor: Colors.grey.withOpacity(0.3),
          ),
          Container(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height*0.7,
            child: TabBarView(
                controller: _tabController,
                children: [
                  FutureBuilder<List<TableData>>(
                  future: fetchWaitingTableData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(color: Colors.blue);
                    } else{
                      List<TableData> tableDataListWaiting = snapshot.data!;
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columnSpacing: 15,
                          columns: [
                            DataColumn(label: Text('Id')),
                            DataColumn(label: Text('RoomNo')),
                            DataColumn(label: Text('Username')),
                            DataColumn(label: Text('Time At')),
                            DataColumn(label: Text('Action')),
                          ],
                          rows: tableDataListWaiting.map((data) {
                            return DataRow(
                              cells: [
                                DataCell(Text(tableDataListWaiting.indexOf(data).toString())),
                                DataCell(Text(data.roomNo.toString())),
                                DataCell(Text(data.username)),
                                DataCell(Text(data.timeAt.toString())),
                                DataCell(MaterialButton(child: Text(data.action), onPressed: (){Navigator.pushNamed(context, ActionsAdmin.PageRoute, arguments: {'uid': data.uid, 'message': data.message, 'type' : widget.type, 'RN' : data.roomNo});}, color: Colors.red,)),
                              ],
                            );
                          }).toList(),
    ),
    );
                    }
                  }
                  ),
                  FutureBuilder<List<TableData>>(
                      future: fetchProgressTableData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator(color: Colors.blue);
                        } else{
                          List<TableData> tableDataListWaiting = snapshot.data!;
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columns: [
                                DataColumn(label: Text('Index')),
                                DataColumn(label: Text('Room No')),
                                DataColumn(label: Text('Time At')),
                                DataColumn(label: Text('Action')),
                              ],
                              rows: tableDataListWaiting.map((data) {
                                return DataRow(
                                  cells: [
                                    DataCell(Text(tableDataListWaiting.indexOf(data).toString())),
                                    DataCell(Text(data.roomNo.toString())),
                                    DataCell(Text(data.timeAt.toString())),
                                    DataCell(Text(data.action)),
                                  ],
                                );
                              }).toList(),
                            ),
                          );
                        }
                      }
                  ),
                ],
            ),
          )
        ],
      ),

    );
  }
}
