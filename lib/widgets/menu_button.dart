import 'package:flutter/material.dart';

class MenuButton extends StatefulWidget {
  final ValueChanged<int> onMenuButonTap;
  MenuButton({required this.onMenuButonTap});
  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem<int>(
          value: 1,
          child: Text('起空雨傘'),
        ),
        PopupMenuItem<int>(
          value: 2,
          child: Text('イノベーション'),
        ),
        PopupMenuItem<int>(
          value: 3,
          child: Text('Button 3'),
        ),
      ],
      onSelected: (int value) {
        print('Selected button: $value');
        widget.onMenuButonTap(value);
      },
      icon: Icon(Icons.menu),
    );
  }
}
