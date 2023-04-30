import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../api/s_r_u_api_client.dart';
import '../../../widgets/custom_dropdown_menu.dart';
import '../../../widgets/custom_tab_bar.dart';

class SimpleListPage extends StatefulWidget {
  @override
  _SimpleListPageState createState() => _SimpleListPageState();
}

class _SimpleListPageState extends State<SimpleListPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool triggerDisp = true;
  bool skyDisp = true;
  bool rainDisp = true;
  bool umbrellaDisp = true;
  int nowTabIndex = 0;
  List<Map<String, dynamic>>? items;
  List<Map<String, dynamic>>? allItems;
  List<String> menuItems = [];
  Future<void>? _initDataFuture;
  // これ、ログイン状態だと、ホーム画面に戻す
  void checkAuthentication() async {
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
    // DBから空雨傘一覧データを取得
    final value = await s_r_u_list_api(_auth.currentUser!.uid.toString());
    setState(() {
      items = value
          .cast<Map<String, dynamic>>()
          .map((item) => {
                ...item,
                'triggerDisp': true,
                'skyDisp': true,
                'rainDisp': true,
                'umbrellaDisp': true,
              })
          .toList();
      allItems = items;
      menuItems = value
          .map<String>((item) => item['trigger'].toString())
          .toSet()
          .toList();
      menuItems.insert(0, "全部");
    });
  }

  void _onTabTapped(int index) {
    setState(() {
      print(index);
      if (index == 0) {
        setState(() {
          nowTabIndex = 0;
          items = items!
              .map((item) => {
                    ...item,
                    'triggerDisp': true,
                    'skyDisp': true,
                    'rainDisp': true,
                    'umbrellaDisp': true,
                  })
              .toList();
        });
      } else if (index == 1) {
        setState(() {
          nowTabIndex = 1;
          items = items!
              .map((item) => {
                    ...item,
                    'triggerDisp': true,
                    'skyDisp': false,
                    'rainDisp': false,
                    'umbrellaDisp': false,
                  })
              .toList();
        });
      } else if (index == 2) {
        setState(() {
          nowTabIndex = 2;
          items = items!
              .map((item) => {
                    ...item,
                    'triggerDisp': false,
                    'skyDisp': true,
                    'rainDisp': false,
                    'umbrellaDisp': false,
                  })
              .toList();
        });
      } else if (index == 3) {
        setState(() {
          nowTabIndex = 3;
          items = items!
              .map((item) => {
                    ...item,
                    'triggerDisp': false,
                    'skyDisp': false,
                    'rainDisp': true,
                    'umbrellaDisp': false,
                  })
              .toList();
        });
      } else if (index == 4) {
        setState(() {
          nowTabIndex = 4;
          items = items!
              .map((item) => {
                    ...item,
                    'triggerDisp': false,
                    'skyDisp': false,
                    'rainDisp': false,
                    'umbrellaDisp': true,
                  })
              .toList();
        });
      }
    });
  }

  void _onSelected(String newValue) {
    setState(() {
      if (newValue == "全部") {
        items = allItems;
      } else {
        items = allItems!
            .where((item) => item['trigger'].toString().contains(newValue))
            .map((item) => {
                  ...item,
                })
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: _initDataFuture,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.white,
              child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                      width: 150,
                      height: 150,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      ))),
            );
            // データを取得中の間、ローディングインジケータを表示
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // エラーが発生した場合、エラーメッセージを表示
          } else {
            return Scaffold(
                appBar: AppBar(
                  title: Text('起空雨傘一覧'),
                ),
                body: Column(children: [
                  Container(
                      padding: EdgeInsets.all(5),
                      child: CustomTabBar(onTabSelected: _onTabTapped)),
                  Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Container(
                        child: CustomDropdownMenu(
                            menuItems: menuItems, onSelected: _onSelected),
                        alignment: Alignment.centerLeft,
                      )),
                  Expanded(
                    child: ListView.builder(
                      itemCount: items != null ? items!.length : 0,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.all(8.0),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                items![index]["triggerDisp"]!
                                    ? Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8.0, 0, 8.0, 8.0),
                                        child: Text(
                                          "起: " + items![index]["trigger"]!,
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )
                                    : Container(),
                                items![index]["skyDisp"]!
                                    ? Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8.0, 0, 8.0, 8.0),
                                        child: Text(
                                          "空: " + items![index]["sky"]!,
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )
                                    : Container(),
                                items![index]["rainDisp"]!
                                    ? Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8.0, 0, 8.0, 8.0),
                                        child: Text(
                                          "雨: " + items![index]["rain"]!,
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )
                                    : Container(),
                                items![index]["umbrellaDisp"]!
                                    ? Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8.0, 0, 8.0, 8.0),
                                        child: Text(
                                          "傘: " + items![index]["umbrella"]!,
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )
                                    : Container(),
                                Row(
                                  children: [
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        minimumSize:
                                            MaterialStateProperty.all<Size>(
                                                Size(40, 30)),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Color.fromARGB(
                                                    200, 50, 205, 50)),
                                      ),
                                      onPressed: () {
                                        // 前の画面に値を渡すにはどうしたらいいだろう
                                        // 複数の値を格納するためのMapを作成
                                        Map<String, dynamic> returnedValues = {
                                          'sky': items![index]["sky"]!,
                                          'rain': items![index]["rain"]!,
                                          'umbrella': items![index]
                                              ["umbrella"]!,
                                        };
                                        Navigator.pop(context, returnedValues);
                                      },
                                      child: Text(
                                        "再考する",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13.0),
                                      ),
                                    ),
                                    items![index]["skyDisp"]! == false ||
                                            items![index]["umbrellaDisp"]! ==
                                                false ||
                                            items![index]["rainDisp"]! == false
                                        ? Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8.0, 0, 0, 0),
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                minimumSize:
                                                    MaterialStateProperty.all<
                                                        Size>(Size(40, 30)),
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Color.fromARGB(
                                                            199, 50, 78, 205)),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  items = items!
                                                      .asMap()
                                                      .map((num, item) {
                                                        if (num == index) {
                                                          return MapEntry(num, {
                                                            ...item,
                                                            'triggerDisp': true,
                                                            'skyDisp': true,
                                                            'rainDisp': true,
                                                            'umbrellaDisp':
                                                                true,
                                                          });
                                                        } else {
                                                          return MapEntry(
                                                              num, item);
                                                        }
                                                      })
                                                      .values
                                                      .toList();
                                                });
                                              },
                                              child: Text(
                                                "起空雨傘見る",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13.0),
                                              ),
                                            ),
                                          )
                                        : nowTabIndex == 0
                                            ? Container()
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8.0, 0, 0, 0),
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    minimumSize:
                                                        MaterialStateProperty
                                                            .all<Size>(
                                                                Size(40, 30)),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                Color.fromARGB(
                                                                    199,
                                                                    50,
                                                                    78,
                                                                    205)),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      items = items!
                                                          .asMap()
                                                          .map((num, item) {
                                                            if (num == index) {
                                                              if (nowTabIndex ==
                                                                  1) {
                                                                return MapEntry(
                                                                    num, {
                                                                  ...item,
                                                                  'triggerDisp':
                                                                      true,
                                                                  'skyDisp':
                                                                      false,
                                                                  'rainDisp':
                                                                      false,
                                                                  'umbrellaDisp':
                                                                      false,
                                                                });
                                                              } else if (nowTabIndex ==
                                                                  2) {
                                                                return MapEntry(
                                                                    num, {
                                                                  ...item,
                                                                  'triggerDisp':
                                                                      false,
                                                                  'skyDisp':
                                                                      true,
                                                                  'rainDisp':
                                                                      false,
                                                                  'umbrellaDisp':
                                                                      false,
                                                                });
                                                              } else if (nowTabIndex ==
                                                                  3) {
                                                                return MapEntry(
                                                                    num, {
                                                                  ...item,
                                                                  'triggerDisp':
                                                                      false,
                                                                  'skyDisp':
                                                                      false,
                                                                  'rainDisp':
                                                                      true,
                                                                  'umbrellaDisp':
                                                                      false,
                                                                });
                                                              } else if (nowTabIndex ==
                                                                  4) {
                                                                return MapEntry(
                                                                    num, {
                                                                  ...item,
                                                                  'triggerDisp':
                                                                      false,
                                                                  'skyDisp':
                                                                      false,
                                                                  'rainDisp':
                                                                      false,
                                                                  'umbrellaDisp':
                                                                      true,
                                                                });
                                                              } else {
                                                                return MapEntry(
                                                                    num, item);
                                                              }
                                                            } else {
                                                              return MapEntry(
                                                                  num, item);
                                                            }
                                                          })
                                                          .values
                                                          .toList();
                                                    });
                                                  },
                                                  child: Text(
                                                    "閉じる",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13.0),
                                                  ),
                                                )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ]));
          }
        });
  }
}
