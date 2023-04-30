import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../api/group_member_list_api_client.dart';

class GroupMemberPage extends StatefulWidget {
  const GroupMemberPage({super.key, required this.code});
  final String code;
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
    final value = await get_group_member_list(widget.code);
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
                      Text(
                        items![index]["nickname"]!,
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
