import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../api/api_client.dart';

class GroupCodeAddPage extends StatefulWidget {
  const GroupCodeAddPage({super.key});
  @override
  State<GroupCodeAddPage> createState() => _GroupCodeAddPageState();
}

class _GroupCodeAddPageState extends State<GroupCodeAddPage> {
  TextEditingController _codeController = TextEditingController();
  String genaretedCode = "";
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
                child: Text("もらったコードを入力してください"),
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
                    controller: _codeController,
                  )),
              genaretedCode != ""
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                      child: SelectableText(genaretedCode),
                    )
                  : Container(),
              Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: Text(
                      "チームに参加する",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_codeController.text == "") {
                        setState(() {
                          genaretedCode = "コードは必須です";
                        });
                      } else {
                        await group_member_list_input_api(
                          _auth.currentUser!.uid.toString(),
                          "",
                          _codeController.text,
                        );
                      }
                    },
                  )),
            ],
          ),
        ));
  }
}
