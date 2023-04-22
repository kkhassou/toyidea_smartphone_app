import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../api/api_client.dart';

class GroupMemberPage extends StatefulWidget {
  const GroupMemberPage({super.key});
  @override
  State<GroupMemberPage> createState() => _GroupMemberPageState();
}

class _GroupMemberPageState extends State<GroupMemberPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Map<String, dynamic>>? items;
  List<Map<String, dynamic>>? allItems;
  List<String> menuItems = [];
  Future<void>? _initDataFuture;
  // これ、ログイン状態だと、ホーム画面に戻す
  checkAuthentication() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pop(context);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
    _initDataFuture = initData();
  }

  Future<void> initData() async {
    await checkAuthentication();
    // DBから空雨傘一覧データを取得
    // final value = await s_r_u_list_api(_auth.currentUser!.uid.toString());
    final value =
        await belong_group_list_api(_auth.currentUser!.uid.toString());
    setState(() {
      items = value
          .cast<Map<String, dynamic>>()
          .map((item) => {
                ...item,
              })
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: 300,
        child: ListView.builder(
            itemCount: items != null ? items!.length : 0,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  margin: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(items![index]["name"]!),
                      Container(width: 20),
                      items![index]["code"] != null
                          ? Text(items![index]["code"]!)
                          : Container(
                              // いや、自分で作成したチームだからこそ、招待のためにコードコピーできた方がいいな
                              child: Text("自分で作成したチーム"),
                            )
                    ],
                  ),
                ),
              );
            }));
  }
}
