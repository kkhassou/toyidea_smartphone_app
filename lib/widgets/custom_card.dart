import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(Size(150, 40)),
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(200, 30, 144, 255)),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('/signup');
              },
              child: Text('新規登録'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(Size(150, 40)),
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(200, 50, 205, 50)),
              ),
              onPressed: () {
                // callApi();
                Navigator.of(context).pushNamed('/login');
              },
              child: Text('ログイン'),
            ),
          ],
        ),
      ),
    );
  }
}
