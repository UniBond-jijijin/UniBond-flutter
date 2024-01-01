import 'package:flutter/material.dart';

import 'app_colors.dart';

class TabItem {
  final String label;
  final IconData iconData;
  final IconData? selectedIconData;

  const TabItem({
    required this.label,
    required this.iconData,
    this.selectedIconData,
  });

  Widget icon({bool isSelected = false, Color color = Colors.black}) {
    final icon =
        isSelected && selectedIconData != null ? selectedIconData : iconData;
    return Icon(
      icon,
      color: isSelected ? primaryColor : color,
      size: 30,
    );
  }
}

const List<TabItem> tabItems = [
  TabItem(
    label: '홈',
    iconData: Icons.home,
    selectedIconData: Icons.home,
  ),
  TabItem(
    label: '편지함',
    iconData: Icons.mail,
    selectedIconData: Icons.mail,
  ),
  TabItem(
    label: '프로필',
    iconData: Icons.person,
    selectedIconData: Icons.person,
  ),
];
