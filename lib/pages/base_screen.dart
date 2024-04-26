import 'package:ave_memoria/pages/homepage.dart';
import 'package:ave_memoria/pages/profile.dart';
import 'package:ave_memoria/pages/statistics.dart';
import 'package:ave_memoria/pages/store.dart';
import 'package:ave_memoria/pages/story.dart';
import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;
  PageController _pageController = PageController(initialPage: 0);
  final List<Widget> _screens = const [
    Homepage(),
    Story(),
    Store(),
    Statistics(),
    Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: theme.colorScheme.primary,
        showUnselectedLabels: true,
        unselectedItemColor: appTheme.gray,
        unselectedLabelStyle: CustomTextStyles.semiBold14Text,
        selectedLabelStyle: CustomTextStyles.semiBold14Primary,
        backgroundColor: appTheme.white,
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
            _pageController.animateToPage(
              value,
              duration: Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.buildingColumns,
              size: 25.h,
            ),
            label: 'главная',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.crown,
              size: 25.h,
            ),
            label: 'сюжет',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.feather,
              size: 25.h,
            ),
            label: 'проводник',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.chartSimple,
              size: 25.h,
            ),
            label: 'оценка',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.solidUser,
              size: 25.h,
            ),
            label: 'профиль',
          ),
        ],
      ),
    );
  }
}