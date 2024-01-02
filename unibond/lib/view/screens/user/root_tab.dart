import 'package:flutter/material.dart';
import 'package:unibond/resources/app_colors.dart';
import 'package:unibond/resources/tab_item.dart';
import 'package:unibond/view/screens/home_screen.dart';
import 'package:unibond/view/screens/letter/letter_box_screen.dart';
import 'package:unibond/view/screens/user/other_profile_screen.dart';
import 'package:unibond/view/screens/user/profile_screen.dart';

class RootTab extends StatefulWidget {
  static String get routeName => '/';
  const RootTab({
    Key? key,
  }) : super(key: key);

  @override
  _RootTabState createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    _tabController = TabController(
      length: tabItems.length,
      vsync: this,
      initialIndex: _currentIndex,
    );
    _tabController.addListener(tabListener);
    super.initState();
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
        children: <Widget>[
          const HomeScreen(),
          LetterBoxScreen(
            fakeEnvelopes: [
              LetterEnvelope(date: '2023-10-15', sender: '지지진'),
              LetterEnvelope(date: '2023-10-14', sender: '진지지'),
            ],
          ),
          const ProfileScreen(),
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
