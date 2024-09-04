import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:metrogeniusapp/src/user/screens/bottomnavigation/booking/history_purchase.dart';
import 'package:metrogeniusapp/src/user/screens/bottomnavigation/booking/upcomming.dart';
import 'package:metrogeniusapp/utils/colors.dart';
import 'package:metrogeniusapp/utils/constants.dart';

class BookingsPage extends StatelessWidget {
  const BookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: AppColors.mainBlueColor,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    width: 5,
                  ),
                  AppConstants.kwidth10,
                  const Text(
                    'Bookings',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ],
              ),
            ],
          ),
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          toolbarHeight: 60,
          bottom: TabBar(
            tabs: const [
              Tab(
                child: Text(
                  'Upcoming',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'History',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
            labelColor: Colors.white, // Color for selected tab text
            unselectedLabelColor: AppColors.greyColor, // Color for unselected tab text
            dividerColor: Colors.transparent,
            indicator: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5), // Rounded corners
              color: AppColors.mainBlueColor.withOpacity(.4), // Background color of the selected tab
            ),
            indicatorPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            indicatorSize: TabBarIndicatorSize.tab,
          ),
        ),
        body: const TabBarView(
          children: [UpComming(), History()],
        ),
      ),
    );
  }
}
