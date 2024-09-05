import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:metrogeniusapp/src/employe/bottom_navigation/analytics_user.dart';
import 'package:metrogeniusapp/src/employe/bottom_navigation/history/compleated_jobs.dart';
import 'package:metrogeniusapp/src/employe/bottom_navigation/home/employe_home.dart';
import 'package:metrogeniusapp/src/employe/bottom_navigation/profile/profile_worker.dart';
import 'package:metrogeniusapp/utils/colors.dart';

class WorkerBottomNavigation extends StatefulWidget {
  const WorkerBottomNavigation({super.key});

  @override
  State<WorkerBottomNavigation> createState() => _WorkerBottomNavigationState();
}

class _WorkerBottomNavigationState extends State<WorkerBottomNavigation> {
  int currentIndex = 1;
  
  // Using ValueNotifier to manage the visibility of the bottom nav bar
  final ValueNotifier<bool> bottomNavBarVisible = ValueNotifier(true);

  final List<Widget> screens = [
    const HistoryWorker(),
    const EmployeeHome(),
    const AnalyticsWorker(),
    const ProfileWorker1(),
  ];

  void setPage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          // Hide or show the bottom nav based on scroll direction
          if (notification.direction == ScrollDirection.reverse) {
            bottomNavBarVisible.value = false;
          } else if (notification.direction == ScrollDirection.forward) {
            bottomNavBarVisible.value = true;
          }
          return true;
        },
        // Using IndexedStack to keep the state of each screen
        child: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder<bool>(
        valueListenable: bottomNavBarVisible,
        builder: (context, isVisible, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: isVisible ? kBottomNavigationBarHeight + 15 : 0,
            child: isVisible ? child : const SizedBox.shrink(),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15, left: 9, right: 9),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(149, 78, 73, 73),
                  offset: Offset(0, 0),
                  spreadRadius: 2,
                  blurRadius: 5,
                )
              ],
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(35),
            ),
            child: GNav(
              haptic: true,
              color: AppColors.mainBlueColor,
              activeColor: Colors.white,
              gap: 8,
              onTabChange: setPage,
              padding: const EdgeInsets.all(16),
              textStyle: const TextStyle(color: Colors.white),
              tabBackgroundColor: AppColors.mainBlueColor,
              selectedIndex: currentIndex, // Ensure correct tab is highlighted
              tabs: const [
                GButton(
                  icon: Icons.history,
                  text: 'History',
                ),
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.analytics,
                  text: 'Analytics',
                ),
                GButton(
                  icon: Icons.person_2,
                  text: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
