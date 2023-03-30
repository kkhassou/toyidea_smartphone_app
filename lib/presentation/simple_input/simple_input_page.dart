import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../api/api_client.dart';

class SimpleInputPage extends StatefulWidget {
  @override
  _SimpleInputPageState createState() => _SimpleInputPageState();
}

class _SimpleInputPageState extends State<SimpleInputPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
  }

  showError(String errorMessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(errorMessage),
            actions: <Widget>[
              ElevatedButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
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
          "空雨傘入力",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 40.0),
            Container(
              padding: EdgeInsets.all(32),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("空", style: TextStyle(fontSize: 30)),
                    TextFormField(
                      controller: _emailController,
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Container(
                          width: rightEdgePosition + 40,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all<Size>(Size(70, 30)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(200, 50, 205, 50)),
                          ),
                          onPressed: () {},
                          child: Text(
                            "全体クリア",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                        ),
                      ],
                    ),
                    Text("雨", style: TextStyle(fontSize: 30)),
                    TextFormField(
                      controller: _passwordController,
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Container(
                          width: rightEdgePosition + 40,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all<Size>(Size(70, 30)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(200, 50, 205, 50)),
                          ),
                          onPressed: () {},
                          child: Text(
                            "雨傘クリア",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "傘",
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    TextFormField(
                      controller: _passwordController,
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Container(
                          width: rightEdgePosition + 60,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all<Size>(Size(70, 30)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(200, 50, 205, 50)),
                          ),
                          onPressed: () {},
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
                          width: rightEdgePosition + 70,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all<Size>(Size(80, 40)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(199, 205, 140, 50)),
                          ),
                          onPressed: () {
                            // ここでAPIを呼ぶ
                            s_r_u_input_api();
                          },
                          child: Text(
                            "保存",
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
                          width: rightEdgePosition + 30,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all<Size>(Size(80, 40)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(199, 205, 140, 50)),
                          ),
                          onPressed: () {},
                          child: Text(
                            "模範ランダム",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
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
