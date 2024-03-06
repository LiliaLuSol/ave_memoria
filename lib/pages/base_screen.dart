import 'package:ave_memoria/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = const [
    Homepage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _selectedIndex,
            children: _screens,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                SizedBox(
                  width: double.maxFinite,
                  child: Divider(
                      height: 1, color: appTheme.gray),
                ),
                Container(
                  height: 89.v,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                  child: BottomNavigationBar(
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
                        label: 'свод',
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
