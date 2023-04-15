import 'package:flutter/material.dart';

class CustomDropdownMenu extends StatefulWidget {
  final List<String>? menuItems;
  CustomDropdownMenu({this.menuItems});
  @override
  _CustomDropdownMenuState createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.menuItems![0].toString(); // 初期値を設定
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      // value: widget.menuItems != null ? widget.menuItems![0].toString() : "",
      // value: widget.menuItems![0].toString() ?? "",
      value: "全部", //_selectedValue,
      items: widget.menuItems != null
          ? widget.menuItems!.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList()
          : [],
      // [
      //   DropdownMenuItem<String>(
      //     value: 'Option 1',
      //     child: Text('Option 1'),
      //   ),
      //   DropdownMenuItem<String>(
      //     value: 'Option 2',
      //     child: Text('Option 2'),
      //   ),
      //   DropdownMenuItem<String>(
      //     value: 'Option 3',
      //     child: Text('Option 3'),
      //   ),
      // ],
      onChanged: (newValue) {
        setState(() {
          _selectedValue = newValue;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Selected: $newValue')),
        );
      },
    );
  }
}
