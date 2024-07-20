import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:metrogeniusapp/src/user/screens/bottomnavigation/booking/history_purchase.dart';
import 'package:metrogeniusapp/src/user/screens/bottomnavigation/booking/upcomming.dart';
import 'package:metrogeniusapp/utils/colors.dart';

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
              Row(children: [
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(202, 189, 255, 1.0),
                      borderRadius: BorderRadius.circular(14)),
                  width: 5,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Bookings',
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Color.fromARGB(255, 0, 0, 0)),
                )
              ]),
              
            ],
          ),
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          toolbarHeight: 60,
          bottom:  TabBar(tabs: const [
            Tab(
              child: Text(
                'Upcoming',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color:AppColors.greyColor
                ),
              ),
            ),
            Tab(
             child: Text('History',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color:AppColors.greyColor
                ),),
              
              
            )
          ],
          dividerColor: Colors.transparent,
          indicator: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10), // Rounded corners
            color: AppColors.lightPurple // Background color of the selected tab
          ),
           indicatorPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
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


