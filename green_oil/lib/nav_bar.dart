import 'package:flutter/material.dart';
import 'package:green_oil/home_screen/home_screen.dart';
import 'package:green_oil/profile_screen/profile_screen.dart';
import 'package:green_oil/schedule_screen/schedule_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key, required this.wantedPage});

  final int wantedPage;

  @override
  State<NavBar> createState() {
    return _NavBar();
  }
}

class _NavBar extends State<NavBar> {
  late int _selectedPageIndex;

  @override
  void initState() {
    super.initState();
    // Initialize _selectedPageIndex based on wantedPage
    _selectedPageIndex = widget.wantedPage;
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = HomeScreen();

    if (_selectedPageIndex == 1) {
      activePage = const ScheduleScreen();
    } else if (_selectedPageIndex == 2) {
      activePage = const ProfileScreen();
    }

    return Scaffold(
      body: activePage,
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              spreadRadius: 0,
              blurRadius: 2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            onTap: _selectPage,
            currentIndex: _selectedPageIndex,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Theme.of(context).disabledColor,
            iconSize: 30,
            selectedFontSize: 16,
            unselectedFontSize: 14,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.schedule,
                ),
                label: 'Schedule',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
