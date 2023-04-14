import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_card.dart';
import '../../widgets/menu_button.dart';
import '../../widgets/randam_icon.dart';

import 'package:firebase_auth/firebase_auth.dart';

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
  String startComment = "さあ今日も\n　起空雨傘で考えよう!";
  double startComment_fontSize = 30;
  void _onMenuButonTap(int index) {
    print("index");
    print(index);
    setState(() {
      if (index == 1) {
        appTypeList = AppTypeList.TrigerSkyRainUmbrella;
        startComment = "さあ今日も\n　起空雨傘で考えよう!";
        startComment_fontSize = 30;
      } else if (index == 2) {
        appTypeList = AppTypeList.Innovation;
        startComment = "さあ今日も\n　イノベーションを起こそう!";
        startComment_fontSize = 25;
      } else if (index == 3) {
        appTypeList = AppTypeList.Integration;
      }
    });
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
                children: [
                  user != null ? Container() : Center(child: CustomCard()),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
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
                  //   Padding(
                  //       padding:
                  //           EdgeInsets.fromLTRB(150, underbutton_from_top!, 0, 0),
                  //       child: ElevatedButton(
                  //         style: ElevatedButton.styleFrom(
                  //             backgroundColor: Colors.orange),
                  //         child: Text(
                  //           "過去の空雨傘",
                  //           style: TextStyle(fontSize: 30),
                  //         ),
                  //         onPressed: user != null ? () {} : null,
                  //       )),
                  //   Padding(
                  //       padding: const EdgeInsets.fromLTRB(150, 30, 0, 0),
                  //       child: ElevatedButton(
                  //         style: ElevatedButton.styleFrom(
                  //             backgroundColor: Colors.orange),
                  //         child: Text(
                  //           "模範の空雨傘",
                  //           style: TextStyle(fontSize: 30),
                  //         ),
                  //         onPressed: user != null ? () {} : null,
                  //       )),
                ],
              ),
            ),
          );
        });
  }
}
