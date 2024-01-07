import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:unibond/resources/app_colors.dart';
import 'package:unibond/resources/tab_item.dart';
import 'package:unibond/util/auth_storage.dart';
import 'package:unibond/view/screens/home_screen.dart';
import 'package:unibond/view/screens/letter/letter_box_screen.dart';
import 'package:unibond/view/screens/user/profile_screen.dart';

class RootTab extends StatefulWidget {
  final int initialIndex;

  static String get routeName => '/';
  const RootTab({
    Key? key,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  _RootTabState createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int _currentIndex;

  @override
  void initState() {
    _currentIndex = widget.initialIndex;
    _tabController = TabController(
      length: tabItems.length,
      vsync: this,
      initialIndex: _currentIndex,
    );
    _tabController.addListener(tabListener);
    super.initState();

    // AuthStorage.delAuthToken();
  }

  void tabListener() {
    if (_tabController.index != _currentIndex) {
      setState(() {
        _currentIndex = _tabController.index;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const <Widget>[
          HomeScreen(),
          LetterBoxScreen(),
          ProfileScreen(),
          // const OtherProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: primaryColor,
        backgroundColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            print(_currentIndex);
            _tabController.animateTo(index);
          });
        },
        unselectedItemColor: Colors.grey[600], // Set unselected item color
        selectedLabelStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        items: tabItems.map((tab) {
          bool isSelected = _currentIndex == tabItems.indexOf(tab);
          return BottomNavigationBarItem(
            icon: tab.icon(isSelected: isSelected, color: Colors.grey),
            activeIcon: tab.icon(isSelected: true, color: primaryColor),
            label: tab.label,
          );
        }).toList(),
      ),
    );
  }
}
