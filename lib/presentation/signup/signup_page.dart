import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../api/user_info_api_client.dart';
import '../../widgets/randam_icon.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController _nicknameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // これ、ログイン状態だと、ホーム画面に戻す
  checkAuthentication() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.pop(context);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return
        // Text("data");
        Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepOrangeAccent,
              title: Row(
                children: [
                  Text(
                    "新規登録",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  RandamIcon()
                ],
              ),
            ),
            body: Container(
                child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                children: [
                  SizedBox(height: 40.0),
                  TextField(
                    controller: _nicknameController,
                    decoration: InputDecoration(
                      labelText: 'ニックネーム',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'メールアドレス',
                      hintText: 'example@example.com',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'パスワード',
                      hintText: 'パスワードを入力してください',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(Size(150, 40)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(200, 30, 144, 255)),
                    ),
                    onPressed: () async {
                      if (_nicknameController.text != "" &&
                          _emailController.text != "" &&
                          _passwordController.text != "") {
                        try {
                          // メール/パスワードでユーザー登録
                          final result =
                              await _auth.createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                          insert_user_info_api(
                              _emailController.text, _nicknameController.text);
                        } catch (e) {
                          /* --- 省略 --- */
                          print("新規登録失敗");
                        }
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("エラー"),
                                content:
                                    Text("ニックネーム、メールアドレス、パスワードの３つを入力してください。"),
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
                    },
                    child: Text('新規登録'),
                  ),
                ],
              ),
            )));
  }
}
