import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_card.dart';
import '../../widgets/randam_icon.dart';

import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loginFlag = false;
  double? underbutton_from_top;
  double? uppertitle_from_top;
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    double rightPadding = 240;
    double screenWidth = MediaQuery.of(context).size.width;
    double rightEdgePosition = screenWidth - rightPadding;
    User? user;
    if (loginFlag) {
      underbutton_from_top = 170.0;
    } else {
      underbutton_from_top = 120.0;
    }
    return StreamBuilder<User?>(
        stream: _auth.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            user = snapshot.data;
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepOrangeAccent,
              title: Row(
                children: [
                  Text(
                    "ホーム",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  RandamIcon(),
                  Container(width: rightEdgePosition),
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
                      : Container()
                ],
              ),
            ),
            body: Container(
              child: Column(
                children: [
                  // TODO:ログインと新規登録のカードを作成する
                  user != null ? Container() : Center(child: CustomCard()),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Text(
                      "さあ今日も\n　空雨傘で考えよう!",
                      style: TextStyle(fontSize: 30),
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
                              backgroundColor: Colors.deepOrangeAccent),
                          child: Text(
                            "はじめる",
                            style: TextStyle(fontSize: 40),
                          ),
                          onPressed: loginFlag ? () {} : null,
                        )),
                  ]),
                  Padding(
                      padding:
                          EdgeInsets.fromLTRB(150, underbutton_from_top!, 0, 0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurpleAccent),
                        child: Text(
                          "過去の空雨傘",
                          style: TextStyle(fontSize: 30),
                        ),
                        onPressed: loginFlag ? () {} : null,
                      )),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(150, 30, 0, 0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurpleAccent),
                        child: Text(
                          "模範の空雨傘",
                          style: TextStyle(fontSize: 30),
                        ),
                        onPressed: loginFlag ? () {} : null,
                      )),
                ],
              ),
            ),
          );
        });
  }
}
