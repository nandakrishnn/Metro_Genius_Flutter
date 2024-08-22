import 'package:flutter/material.dart';
import 'package:metrogeniusapp/src/employe/bottom_navigation/home/pages/requests_jobs.dart';
import 'package:metrogeniusapp/src/employe/bottom_navigation/home/pages/upcomming_work.dart';

import 'package:metrogeniusapp/utils/colors.dart';


class EmployeeHome extends StatelessWidget {
  const EmployeeHome({super.key});

  @override
  Widget build(BuildContext context) {
   return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){}, icon: const Icon(Icons.dashboard)),
          centerTitle: true,
          elevation: 0,
          title: Text('My Tasks'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.notifications))
        ],
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          toolbarHeight: 60,
          bottom:  TabBar(tabs: const [
  
            Tab(
              child: Text(
                'Committed',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color:AppColors.greyColor
                ),
              ),
            ),
            Tab(
             child: Text('Requests',
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
            borderRadius: BorderRadius.circular(5), // Rounded corners
            color: AppColors.mainBlueColor.withOpacity(.5) // Background color of the selected tab
          ),
           indicatorPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
           indicatorSize: TabBarIndicatorSize.tab,
          ),
        ),
        body: const TabBarView(
          children: [UpCommingWorks(), WorkRequests()],
        ),
      ),
    );
  }
  }

