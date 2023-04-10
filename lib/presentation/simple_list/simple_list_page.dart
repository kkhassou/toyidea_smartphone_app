import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../api/api_client.dart';

class SimpleListPage extends StatefulWidget {
  @override
  _SimpleListPageState createState() => _SimpleListPageState();
}

class _SimpleListPageState extends State<SimpleListPage> {
  List<Map<String, dynamic>>? items;
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
    // DBから空雨傘一覧データを取得
    s_r_u_list_api(_auth.currentUser!.uid.toString()).then((value) {
      print("kake value");
      print(value);
      setState(() {
        // setStateを追加
        items = value.cast<Map<String, dynamic>>(); // itemsにvalueを代入
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('空雨傘一覧'),
      ),
      body: ListView.builder(
        itemCount: items != null ? items!.length : 0,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "空: " + items![index]["sky"]!,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "雨: " + items![index]["rain"]!,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "傘: " + items![index]["umbrella"]!,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all<Size>(Size(40, 30)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(200, 50, 205, 50)),
                        ),
                        onPressed: () {
                          // 前の画面に値を渡すにはどうしたらいいだろう
                          // 複数の値を格納するためのMapを作成
                          Map<String, dynamic> returnedValues = {
                            'sky': items![index]["sky"]!,
                            'rain': items![index]["rain"]!,
                            'umbrella': items![index]["umbrella"]!,
                          };
                          Navigator.pop(context, returnedValues);
                        },
                        child: Text(
                          "再考する",
                          style: TextStyle(color: Colors.white, fontSize: 13.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
