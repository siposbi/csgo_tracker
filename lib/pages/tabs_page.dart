import 'package:csgo_tracker/materials/custom_colors.dart';
import 'package:csgo_tracker/pages/tab_navigation_item.dart';
import 'package:flutter/material.dart';

class TabsPage extends StatefulWidget {
  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(TabNavigationItem.items[_currentIndex].label),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          for (final tabItem in TabNavigationItem.items) tabItem.page,
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: CustomColors.PRIMARY_COLOR,
          primaryColor: Colors.white,
          unselectedWidgetColor: Colors.black,
        ), //
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int index) => setState(() => _currentIndex = index),
          items: <BottomNavigationBarItem>[
            for (final tabItem in TabNavigationItem.items)
              BottomNavigationBarItem(
                icon: tabItem.icon,
                label: tabItem.label,
              ),
          ],
        ),
      ),
    );
  }
}
