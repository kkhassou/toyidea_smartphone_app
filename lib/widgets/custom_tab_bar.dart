import 'package:flutter/material.dart';

class CustomTabBar extends StatefulWidget {
  final ValueChanged<int> onTabSelected;

  CustomTabBar({required this.onTabSelected});

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int _selectedIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onTabSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Column(
          children: [
            Container(
              height: 25,
              child: SizedBox(
                child: TabBar(
                  onTap: _onTabTapped,
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.blue,
                  tabs: [
                    Tab(
                      // icon: Icon(Icons.directions_transit),
                      text: "全部",
                      // child: Text(
                      //   '全部',
                      //   style: TextStyle(fontSize: 15),
                      // ),
                    ),
                    Tab(
                        // icon: Icon(Icons.directions_transit),
                        text: '起のみ'),
                    Tab(
                        // icon: Icon(Icons.directions_transit),
                        text: '空のみ'),
                    Tab(
                        // icon: Icon(Icons.directions_bike),
                        text: '雨のみ'),
                    Tab(
                        // icon: Icon(Icons.directions_bike),
                        text: '傘のみ'),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
