import 'dart:math';

import 'package:flutter/material.dart';

class RandamIcon extends StatefulWidget {
  const RandamIcon({super.key});

  @override
  State<RandamIcon> createState() => _RandamIconState();
}

class _RandamIconState extends State<RandamIcon> {
  List<IconData> icons = [
    // Icons.favorite,
    Icons.home,
    Icons.person,
    Icons.alarm,
    Icons.star,
    Icons.access_alarm,
  ];
  int? randomIndex;
  @override
  void initState() {
    randomIndex = Random().nextInt(icons.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Icon(icons[randomIndex!]);
  }
}
