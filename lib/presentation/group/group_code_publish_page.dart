import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../api/api_client.dart';
import 'dart:math';

class GroupCodePublishPage extends StatefulWidget {
  const GroupCodePublishPage({super.key});
  @override
  State<GroupCodePublishPage> createState() => _GroupCodePublishPageState();
}

class _GroupCodePublishPageState extends State<GroupCodePublishPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _groupNameController = TextEditingController();
  String genaretedCode = "";
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 600,
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                child: Text("グループ名を入力してください"),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: TextFormField(
                    maxLines: null,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                      border: OutlineInputBorder(),
                    ),
                    controller: _groupNameController,
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                child: Text("コードを発行します"),
              ),
              genaretedCode != ""
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                      child: SelectableText(genaretedCode),
                    )
                  : Container(),
              Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: Text(
                      "発行",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    onPressed: () {
                      if (_groupNameController.text == "") {
                        setState(() {
                          genaretedCode = "グループ名は必須です";
                        });
                      } else {
                        // 10桁のランダムな文字列を生成する場合
                        String randomString = generateRandomString(10);
                        print(randomString); // 例：i5scx7l1tz
                        setState(() {
                          genaretedCode = randomString;
                        });
                        group_list_input_api(_auth.currentUser!.uid.toString(),
                            _groupNameController.text, randomString);
                        Navigator.pop(context);
                      }
                    },
                  )),
            ],
          ),
        ));
  }

  String generateRandomString(int len) {
    const chars = "abcdefghijklmnopqrstuvwxyz0123456789";
    final random = Random.secure();
    return List.generate(len, (index) => chars[random.nextInt(chars.length)])
        .join();
  }
}
