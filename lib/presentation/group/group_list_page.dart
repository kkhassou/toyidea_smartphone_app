import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../api/api_client.dart';

class GroupListPage extends StatefulWidget {
  const GroupListPage({super.key});
  @override
  State<GroupListPage> createState() => _GroupListPageState();
}

class _GroupListPageState extends State<GroupListPage> {
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
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                10,
                10,
                0,
                0,
              ),
              child: Text("チーム名"),
            ),
            Container(width: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                10,
                10,
                0,
                0,
              ),
              child: Text("チームコード"),
            ),
            Container(width: 20),
          ],
        ),
        Expanded(
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
                          SelectableText(items![index]["code"]!),
                          Container(width: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlue),
                            child: Text(
                              "コピー",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            onPressed: () {
                              Clipboard.setData(
                                  ClipboardData(text: items![index]["code"]!));
                            },
                          )
                        ],
                      ),
                    ),
                  );
                })
            // ])
            ),
      ],
    );
  }
}
