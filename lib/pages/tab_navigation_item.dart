import 'package:csgo_tracker/pages/matches_page.dart';
import 'file:///C:/Users/thesi/Desktop/csgo_tracker/csgo_tracker/lib/pages/statistics/satistics_page.dart';
import 'file:///C:/Users/thesi/Desktop/csgo_tracker/csgo_tracker/lib/pages/about/about_page.dart';
import 'package:flutter/material.dart';

class TabNavigationItem {
  final Widget page;
  final String label;
  final Icon icon;

  TabNavigationItem({
    required this.page,
    required this.label,
    required this.icon}
    );

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
            page: StatisticsPage(),
            label: 'Statistics',
            icon: Icon(Icons.show_chart)),
        TabNavigationItem(
            page: MatchesPage(),
            label: 'Matches',
            icon: Icon(Icons.list)),
        TabNavigationItem(
            page: AboutPage(),
            label: 'About',
            icon: Icon(Icons.info_outline)),
      ];
}
