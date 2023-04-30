import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toyidea_smartphone_app/presentation/group/group_code_add_page.dart';

import '../../api/user_info_api_client.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/menu_button.dart';
import '../../widgets/randam_icon.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../group/group_code_publish_page.dart';
import '../group/group_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

enum AppTypeList {
  TrigerSkyRainUmbrella,
  Innovation,
  Integration,
}

class _HomePageState extends State<HomePage> {
  double? underbutton_from_top;
  double? uppertitle_from_top;
  AppTypeList appTypeList = AppTypeList.TrigerSkyRainUmbrella;
  String startComment = "今日も\n　起空雨傘で考えよう!";
  double startComment_fontSize = 30;
  String nickName = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // これ、ログイン状態だと、ホーム画面に戻す
  void checkAuthentication() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
      } else {
        initData();
      }
    });
  }

  void _onMenuButonTap(int index) {
    print("index");
    print(index);
    setState(() {
      if (index == 1) {
        appTypeList = AppTypeList.TrigerSkyRainUmbrella;
        startComment = "今日も\n　起空雨傘で考えよう!";
        startComment_fontSize = 30;
      } else if (index == 2) {
        appTypeList = AppTypeList.Innovation;
        startComment = "今日も\n　イノベーションを起こそう!";
        startComment_fontSize = 25;
      } else if (index == 3) {
        appTypeList = AppTypeList.Integration;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
  }

  Future<void> initData() async {
    // DBから空雨傘一覧データを取得
    // insert_user_info_api(_auth.currentUser!.email.toString(), "かけっち");
    final value =
        await get_user_nickname_api(_auth.currentUser!.email.toString());
    if (value.length != 0) {
      setState(() {
        nickName =
            value.map<String>((item) => item['nickname'].toString()).first;
      });
    }
    // TODO:nickNmaeの格納をuidとセットで行う
    // sinupの時にできるかと思ったけど、sinupの時だと、まだ、uidが取れないのでダメだった。
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    double rightPadding = 240;
    double screenWidth = MediaQuery.of(context).size.width;
    double rightEdgePosition = screenWidth - rightPadding;
    User? user;
    return StreamBuilder<User?>(
        stream: _auth.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            user = snapshot.data;
            if (user != null) {
              underbutton_from_top = 120.0;
            } else {
              underbutton_from_top = 170.0;
            }
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepOrangeAccent,
              title: Row(
                children: [
                  MenuButton(onMenuButonTap: _onMenuButonTap),
                  Text(
                    "ホーム",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  RandamIcon(),
                  Container(width: rightEdgePosition - 50),
                  user != null
                      ? ElevatedButton(
                          onPressed: () async {
                            await _auth.signOut();
                            _auth.authStateChanges();
                            if (_auth.currentUser == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('ログアウトしました'),
                                ),
                              );
                              print('ログアウトしました！');
                            }
                          },
                          child: Text("ログアウト"))
                      : Container(),
                ],
              ),
            ),
            body: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  user != null ? Container() : Center(child: CustomCard()),
                  nickName != ""
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                          child: Text(
                            nickName,
                            style: TextStyle(fontSize: startComment_fontSize),
                            textAlign: TextAlign.left,
                          ))
                      : Container(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                    child: Text(
                      startComment,
                      style: TextStyle(fontSize: startComment_fontSize),
                    ),
                  ),
                  Row(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 50, 0, 0),
                      child: Image(
                        image: AssetImage('assets/images/face_kakegawa.jpg'),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(50, 50, 0, 0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange),
                          child: Text(
                            "はじめる",
                            style: TextStyle(fontSize: 40),
                          ),
                          onPressed: user != null
                              ? () {
                                  Navigator.of(context)
                                      .pushNamed('/simple_input');
                                }
                              : null,
                        )),
                  ]),
                  user != null
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  child: Text("グループメニュー"),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green),
                                          child: Text(
                                            "加入一覧",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                          onPressed: () {
                                            showModalBottomSheet(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return GroupListPage();
                                                });
                                          },
                                        )),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 0, 0, 0),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green),
                                          child: Text(
                                            "コード追加",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                          onPressed: () {
                                            showModalBottomSheet(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return GroupCodeAddPage();
                                                });
                                          },
                                        )),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 0, 0, 0),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green),
                                          child: Text(
                                            "コード発行",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                          onPressed: () {
                                            showModalBottomSheet(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return GroupCodePublishPage();
                                                });
                                          },
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          );
        });
  }
}
