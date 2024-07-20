import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:metrogeniusapp/src/admin/admin_bottomNav/Home/home_admin.dart';
import 'package:metrogeniusapp/src/admin/admin_bottomNav/category/add_category_admin.dart';
import 'package:metrogeniusapp/src/admin/admin_bottomNav/employe_List/admin_employe_list.dart';
import 'package:metrogeniusapp/utils/colors.dart';

class AdminBottomNavigation extends StatefulWidget {
  const AdminBottomNavigation({super.key});

  @override
  State<AdminBottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<AdminBottomNavigation> {
  int currentIndex = 0;
  final ValueNotifier<bool> bottomNavBarVisible = ValueNotifier(true);

  final List<Widget> screens = [
    const AdminHome(),
    const AddCategoryAdmin(),
    const EmployeeListAdmin(),
  
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
          if (notification.direction == ScrollDirection.reverse) {
            bottomNavBarVisible.value = false;
          } else if (notification.direction == ScrollDirection.forward) {
            bottomNavBarVisible.value = true;
          }
          return true;
        },
        child: screens[currentIndex],
      ),
      bottomNavigationBar: ValueListenableBuilder<bool>(
        valueListenable: bottomNavBarVisible,
        builder: (context, isVisible, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: isVisible ? kBottomNavigationBarHeight+13 : 0,
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
              tabs: const [
                GButton(
                  icon: Icons.explore,
                  text: 'Explore',
                ),
                GButton(
                  icon: Icons.calendar_today,
                  text: 'Booking',
                ),
                GButton(
                  icon: Icons.payment,
                  text: 'Payment',
                ),
                GButton(
                  icon: Icons.person_2_sharp,
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
 