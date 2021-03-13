import 'package:flutter/material.dart';

class TabNavigationItem {
  final Widget page;
  final String label;
  final Icon icon;

  TabNavigationItem({
   required this.page,
   required this.label,
   required this.icon
});

  static List<TabNavigationItem> get items => [

  ];
}