import 'package:flutter/material.dart';
import 'package:penoft_machine_test/gen/assets.gen.dart';
import 'package:penoft_machine_test/modules/dashboard/screens/book_screen.dart';
import 'package:penoft_machine_test/modules/dashboard/screens/home_screen.dart';
import 'package:penoft_machine_test/modules/dashboard/screens/profile_screen.dart';
import 'package:penoft_machine_test/shared/constants/colors.dart';
import 'package:penoft_machine_test/shared/extension/square.dart';
import 'package:penoft_machine_test/shared/extension/string.dart';

class MainNavigationScreen extends StatefulWidget {
  static const routeName = 'main-navigation';

  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const BookScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.neutral500,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items:  [
          BottomNavigationBarItem(
            icon: Assets.svg.home
              .icon(context,)
              .square(22),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Assets.svg.book
              .icon(context,)
              .square(22),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Assets.svg.user
              .icon(context,)
              .square(22),
            label: '',
          ),
        ],
      ),
    );
  }
}

