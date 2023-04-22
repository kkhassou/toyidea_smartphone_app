import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../api/api_client.dart';

class SimpleInputPage extends StatefulWidget {
  @override
  _SimpleInputPageState createState() => _SimpleInputPageState();
}

enum ErazeRange {
  only_umbrella,
  umbrella_rain,
  umbrella_rain_sky,
  umbrella_rain_sky_triger,
}

extension ErazeRangeExtension on ErazeRange {
  String get description {
    switch (this) {
      case ErazeRange.only_umbrella:
        return '傘だけ消す';
      case ErazeRange.umbrella_rain:
        return '傘と雨を消す';
      case ErazeRange.umbrella_rain_sky:
        return '傘と雨と空を消す';
      case ErazeRange.umbrella_rain_sky_triger:
        return '全部消す';
      default:
        return '';
    }
  }
}

class _SimpleInputPageState extends State<SimpleInputPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _trigerController = TextEditingController();
  TextEditingController _skyController = TextEditingController();
  TextEditingController _rainController = TextEditingController();
  TextEditingController _umbrellaController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // ErazeRange _erazeRange = ErazeRange.only_umbrella;
  String selectedValue = ErazeRange.only_umbrella.toString();
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
  }

  void _showPopupMenu(BuildContext context) async {
    final _selectedValue = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(20, 450, 200, 0), // 位置を調整
      items: [
        PopupMenuItem<String>(
          value: ErazeRange.only_umbrella.toString(),
          child: Container(
              color: selectedValue == ErazeRange.only_umbrella.toString()
                  ? Colors.amberAccent
                  : null,
              child: Text(ErazeRange.only_umbrella.description)),
        ),
        PopupMenuItem<String>(
          value: ErazeRange.umbrella_rain.toString(),
          child: Container(
              color: selectedValue == ErazeRange.umbrella_rain.toString()
                  ? Colors.amberAccent
                  : null,
              child: Text(ErazeRange.umbrella_rain.description)),
        ),
        PopupMenuItem<String>(
          value: ErazeRange.umbrella_rain_sky.toString(),
          child: Container(
              color: selectedValue == ErazeRange.umbrella_rain_sky.toString()
                  ? Colors.amberAccent
                  : null,
              child: Text(ErazeRange.umbrella_rain_sky.description)),
        ),
        PopupMenuItem<String>(
          value: ErazeRange.umbrella_rain_sky_triger.toString(),
          child: Container(
              color: selectedValue ==
                      ErazeRange.umbrella_rain_sky_triger.toString()
                  ? Colors.amberAccent
                  : null,
              child: Text(ErazeRange.umbrella_rain_sky_triger.description)),
        ),
      ],
    );
    if (_selectedValue != null) {
      setState(() {
        selectedValue = _selectedValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double rightPadding = 220;
    double screenWidth = MediaQuery.of(context).size.width;
    double? rightEdgePosition = screenWidth - rightPadding;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text(
          "起空雨傘入力",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 0.0),
            Container(
              padding: EdgeInsets.all(32),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Text("起", style: TextStyle(fontSize: 30)),
                        Text("　例）外に出かけようとして", style: TextStyle(fontSize: 20)),
                      ],
                    ),
                    TextFormField(
                      maxLines: null,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 0.0),
                        border: OutlineInputBorder(),
                      ),
                      controller: _trigerController,
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Container(
                          width: rightEdgePosition + 10,
                        ),
                        IconButton(
                          onPressed: () {
                            if (_trigerController.text != "") {
                              _skyController.text = _trigerController.text;
                              _trigerController.text = "";
                            }
                          },
                          // 表示アイコン
                          icon: Icon(Icons.arrow_circle_down),
                          // アイコン色
                          color: Colors.pink,
                          // サイズ
                          iconSize: 35,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all<Size>(Size(70, 30)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(200, 50, 205, 50)),
                          ),
                          onPressed: () {
                            _trigerController.text = "";
                          },
                          child: Text(
                            "起クリア",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text("空", style: TextStyle(fontSize: 30)),
                        Text("　例）空を見たら", style: TextStyle(fontSize: 20)),
                      ],
                    ),
                    TextFormField(
                      maxLines: null,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 0.0),
                        border: OutlineInputBorder(),
                      ),
                      controller: _skyController,
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Container(
                          width: rightEdgePosition - 40,
                        ),
                        IconButton(
                          onPressed: () {
                            if (_skyController.text != "") {
                              _rainController.text = _skyController.text;
                              _skyController.text = "";
                            }
                          },
                          // 表示アイコン
                          icon: Icon(Icons.arrow_circle_down),
                          // アイコン色
                          color: Colors.pink,
                          // サイズ
                          iconSize: 35,
                        ),
                        IconButton(
                          onPressed: () {
                            if (_skyController.text != "") {
                              _trigerController.text = _skyController.text;
                              _skyController.text = "";
                            }
                          },
                          // 表示アイコン
                          icon: Icon(Icons.arrow_circle_up),
                          // アイコン色
                          color: Colors.blue,
                          // サイズ
                          iconSize: 35,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all<Size>(Size(70, 30)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(200, 50, 205, 50)),
                          ),
                          onPressed: () {
                            _skyController.text = "";
                          },
                          child: Text(
                            "空クリア",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text("雨", style: TextStyle(fontSize: 30)),
                        Text("　例）雨が降りそう", style: TextStyle(fontSize: 20)),
                      ],
                    ),
                    TextFormField(
                      maxLines: null,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 0.0),
                        border: OutlineInputBorder(),
                      ),
                      controller: _rainController,
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Container(
                          width: rightEdgePosition - 40,
                        ),
                        IconButton(
                          onPressed: () {
                            if (_rainController.text != "") {
                              _umbrellaController.text = _rainController.text;
                              _rainController.text = "";
                            }
                          },
                          // 表示アイコン
                          icon: Icon(Icons.arrow_circle_down),
                          // アイコン色
                          color: Colors.pink,
                          // サイズ
                          iconSize: 35,
                        ),
                        IconButton(
                          onPressed: () {
                            if (_rainController.text != "") {
                              _skyController.text = _rainController.text;
                              _rainController.text = "";
                            }
                          },
                          // 表示アイコン
                          icon: Icon(Icons.arrow_circle_up),
                          // アイコン色
                          color: Colors.blue,
                          // サイズ
                          iconSize: 35,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all<Size>(Size(70, 30)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(200, 50, 205, 50)),
                          ),
                          onPressed: () {
                            setState(() {
                              _rainController.text = "";
                            });
                          },
                          child: Text(
                            "雨クリア",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text("傘", style: TextStyle(fontSize: 30)),
                        Text("　例）傘を持って出た", style: TextStyle(fontSize: 20)),
                      ],
                    ),
                    TextFormField(
                      maxLines: null,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 0.0),
                        border: OutlineInputBorder(),
                      ),
                      controller: _umbrellaController,
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Container(
                          width: rightEdgePosition + 10,
                        ),
                        IconButton(
                          onPressed: () {
                            _rainController.text = _umbrellaController.text;
                            _umbrellaController.text = "";
                          },
                          // 表示アイコン
                          icon: Icon(Icons.arrow_circle_up),
                          // アイコン色
                          color: Colors.blue,
                          // サイズ
                          iconSize: 35,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all<Size>(Size(70, 30)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(200, 50, 205, 50)),
                          ),
                          onPressed: () {
                            setState(() {
                              _umbrellaController.text = "";
                            });
                          },
                          child: Text(
                            "傘クリア",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Container(
                          width: 0,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all<Size>(Size(70, 40)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(199, 205, 140, 50)),
                          ),
                          onPressed: () {
                            // ここでAPIを呼ぶ
                            s_r_u_input_api(
                                _auth.currentUser?.uid as String,
                                _trigerController.text,
                                _skyController.text,
                                _rainController.text,
                                _umbrellaController.text);
                            if (selectedValue ==
                                ErazeRange.only_umbrella.toString()) {
                              _umbrellaController.clear();
                            } else if (selectedValue ==
                                ErazeRange.umbrella_rain.toString()) {
                              _rainController.clear();
                              _umbrellaController.clear();
                            } else if (selectedValue ==
                                ErazeRange.umbrella_rain_sky.toString()) {
                              _skyController.clear();
                              _rainController.clear();
                              _umbrellaController.clear();
                            } else if (selectedValue ==
                                ErazeRange.umbrella_rain_sky_triger
                                    .toString()) {
                              _trigerController.clear();
                              _skyController.clear();
                              _rainController.clear();
                              _umbrellaController.clear();
                            }
                          },
                          child: Text(
                            "保存",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                        ),
                        Container(
                          width: 10,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all<Size>(Size(40, 40)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(197, 161, 50, 205)),
                          ),
                          onPressed: () async {
                            _showPopupMenu(context);
                          },
                          child: Text(
                            "保存時\n設定",
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 14.0),
                          ),
                        ),
                        Container(
                          width: 10,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all<Size>(Size(80, 40)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(198, 50, 205, 159)),
                          ),
                          onPressed: () async {
                            var result = await Navigator.of(context)
                                .pushNamed('/simple_list');

                            if (result != null &&
                                result is Map<String, dynamic>) {
                              setState(() {
                                _trigerController.text = result['sky'];
                                _skyController.text = result['sky'];
                                _rainController.text = result['rain'];
                                _umbrellaController.text = result['umbrella'];
                              });
                            }
                          },
                          child: Text(
                            "一覧画面へ",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
