import 'package:flutter/material.dart';

import '../../widgets/randam_icon.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
                    onPressed: () {
                      // 新規登録処理を実行
                      print('メールアドレス: ${_emailController.text}');
                      print('パスワード: ${_passwordController.text}');
                    },
                    child: Text('新規登録'),
                  ),
                ],
              ),
            )));
  }
}
