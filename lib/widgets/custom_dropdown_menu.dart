import 'package:flutter/material.dart';

class CustomDropdownMenu extends StatefulWidget {
  final List<String>? menuItems;
  final ValueChanged<String>? onSelected;

  CustomDropdownMenu({this.menuItems, this.onSelected});
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: DropdownButton<String>(
        value: _selectedValue,
        isExpanded: true,
        items: widget.menuItems != null
            ? widget.menuItems!.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(value, textAlign: TextAlign.left),
                  ),
                );
              }).toList()
            : [],
        onChanged: (newValue) {
          setState(() {
            _selectedValue = newValue;
            widget.onSelected!(newValue!);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Selected: $newValue')),
          );
        },
      ),
    );
  }
}
