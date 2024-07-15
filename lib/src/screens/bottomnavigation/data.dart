import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:metrogeniusapp/src/widgets/textfeild.dart';
import 'package:metrogeniusapp/utils/colors.dart';
import 'package:metrogeniusapp/utils/constants.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> _categories = [
    'Home Cleaning',
    'A/C Repair',
    'Electrical Works',
    'Beauty'
  ];
  int _currentIndex = 0;
  late Timer _timer;
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
      setState(() {
        _opacity = 0.0;
      });
      Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          _currentIndex = (_currentIndex + 1) % _categories.length;
          _opacity = 1.0;
        });
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 66,
          backgroundColor: AppColors.primaryColor,
          automaticallyImplyLeading: false,
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CURRENT LOCATION',
                style: TextStyle(fontSize: 14),
              ),
              Text('📍Maradu,Kochi', style: TextStyle(fontSize: 14))
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.grey.shade400)),
                child: const Icon(
                  Icons.notifications_active_outlined,
                  size: 25,
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 1,
                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * .4,
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromARGB(250, 142, 144, 149),
                              offset: Offset(0, 0),
                              spreadRadius: .5,
                              blurRadius: 4)
                        ],
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40), )),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppConstants.kheight15,
                          Text(
                            'HELLO NANDA 👋🏻',
                            style: TextStyle(
                                color: Color.fromRGBO(102, 108, 137, 1.0),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          AppConstants.kheight5,
                          Text(
                            'What you are looking for today',
                            style: TextStyle(
                                fontSize: 31, fontWeight: FontWeight.w800),
                          ),
                          AppConstants.kheight15,
                          TextFeild(
                             obscure: false,
                            hinttext:
                                'Search for ${_categories[_currentIndex]}',
                            controller: searchController,
                          )
                        ],
                      ),
                    ),
                  ),
                 SizedBox(height: 4,),
                  Container(
                    height: MediaQuery.of(context).size.height * .48,
                    color: AppColors.primaryColor,
                  )
                ],
              ),
              // Positioned(
              //   top: 215,
              //   child: CarouselWithBuilder(
              //     itemCount: 3,
              //     itemBuilder: (context, index) {
              //       return Container(
              //         height: 260,
              //         width: 400,
              //         margin: EdgeInsets.all(8.0),
              //         decoration: BoxDecoration(
              //           color: AppColors.mainBlueColor,
              //           borderRadius: BorderRadius.circular(8.0),
              //         ),
              //         child: Center(
              //           child: Text(
              //             'Item $index',
              //             style: TextStyle(fontSize: 24, color: Colors.white),
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        )));
  }
}

class CarouselWithBuilder extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  CarouselWithBuilder({required this.itemCount, required this.itemBuilder});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      width: 400,
      child: CarouselSlider.builder(
        itemCount: itemCount,
        itemBuilder: (context, index, realIndex) {
          return itemBuilder(context, index);
        },
        options: CarouselOptions(
            height: 230.0,
            autoPlayInterval: Duration(seconds: 10),
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 15 / 9,
            viewportFraction: .80,
            clipBehavior: Clip.hardEdge),
      ),
    );
  }
}


////

