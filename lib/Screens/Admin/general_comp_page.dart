import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hostel_connect/Utils/app_style.dart';
import 'package:provider/provider.dart';

import '../../Models/table.dart';
import '../../Provider/block_users_provider.dart';
import 'actions_admin.dart';

class GeneralCompPage extends StatefulWidget {
  const GeneralCompPage({Key? key}) : super(key: key);


  @override
  State<GeneralCompPage> createState() => _GeneralCompPageState();
}


class _GeneralCompPageState extends State<GeneralCompPage> with TickerProviderStateMixin {

  final firestore = FirebaseFirestore.instance;

  int waiting=0;
  int progress=0;

  List<String> blockuserUid = [];

  List<TableData> tableDataListWaiting = [];
  List<TableData> tableDataListProgress = [];

  getMyBlockuserUid() async {

    blockuserUid = Provider.of<BlockUsersProvider>(context,listen: false).getuserUid!;
  }

  getWP() async {

    CollectionReference collectionRef = firestore.collection('Complaints');


    waiting=0;
    progress=0;


    String username;
    String timeAt;
    String action;
    String uid;
    String message;

    tableDataListWaiting.clear();
    tableDataListProgress.clear();

    List<Future<void>> fetchFutures = [];


    for(int i =0; i<blockuserUid.length; i++){

      DocumentReference documentRef = collectionRef.doc('General Complaints');
      final CollectionReference subcollectionRef = documentRef.collection(blockuserUid[i]);

      fetchFutures.add(
          subcollectionRef.get().then((querySnapshot) {
            if (querySnapshot.docs.isNotEmpty) {
              // Collection exists and has documents
              // print("Collection exists");


                QueryDocumentSnapshot queryDocumentSnapshot = querySnapshot.docs.first;

                uid = blockuserUid[i];
                username = queryDocumentSnapshot.get('username');
                timeAt = queryDocumentSnapshot.get('timeAt').toString();
                action = queryDocumentSnapshot.get('status');
                message = queryDocumentSnapshot.get('message');

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
                  username: username,
                  timeAt: timeAt,
                  action: action,
                  uid: uid,
                  message: message
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
    print(blockuserUid);
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
    getMyBlockuserUid();
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
        title: Text('GeneralCompPage'),
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
                              DataColumn(label: Text('Username')),
                              DataColumn(label: Text('Time At')),
                              DataColumn(label: Text('Action')),
                            ],
                            rows: tableDataListWaiting.map((data) {
                              return DataRow(
                                cells: [
                                  DataCell(Text(tableDataListWaiting.indexOf(data).toString())),
                                  DataCell(Text(data.username)),
                                  DataCell(Text(data.timeAt.toString())),
                                  DataCell(MaterialButton(child: Text(data.action), onPressed: (){Navigator.pushNamed(context, ActionsAdmin.PageRoute, arguments: {'uid': data.uid, 'message': data.message, 'type' : 'General Complaints'});}, color: Colors.red)),
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
                              DataColumn(label: Text('Username')),
                              DataColumn(label: Text('Time At')),
                              DataColumn(label: Text('Action')),
                            ],
                            rows: tableDataListWaiting.map((data) {
                              return DataRow(
                                cells: [
                                  DataCell(Text(tableDataListWaiting.indexOf(data).toString())),
                                  DataCell(Text(data.username)),
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
