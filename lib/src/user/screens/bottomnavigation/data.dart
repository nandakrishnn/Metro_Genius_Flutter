// import 'dart:async';

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:metrogeniusapp/src/widgets/textfeild.dart';
// import 'package:metrogeniusapp/utils/colors.dart';
// import 'package:metrogeniusapp/utils/constants.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   List<String> _categories = [
//     'Home Cleaning',
//     'A/C Repair',
//     'Electrical Works',
//     'Beauty'
//   ];
//   int _currentIndex = 0;
//   late Timer _timer;
//   double _opacity = 1.0;

//   @override
//   void initState() {
//     super.initState();
//     _timer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
//       setState(() {
//         _opacity = 0.0;
//       });
//       Future.delayed(Duration(milliseconds: 500), () {
//         setState(() {
//           _currentIndex = (_currentIndex + 1) % _categories.length;
//           _opacity = 1.0;
//         });
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController searchController = TextEditingController();
//     return Scaffold(
//         appBar: AppBar(
//           toolbarHeight: 66,
//           backgroundColor: AppColors.primaryColor,
//           automaticallyImplyLeading: false,
//           title: const Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'CURRENT LOCATION',
//                 style: TextStyle(fontSize: 14),
//               ),
//               Text('📍Maradu,Kochi', style: TextStyle(fontSize: 14))
//             ],
//           ),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.only(right: 20),
//               child: Container(
//                 height: 48,
//                 width: 48,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(25),
//                     border: Border.all(color: Colors.grey.shade400)),
//                 child: const Icon(
//                   Icons.notifications_active_outlined,
//                   size: 25,
//                 ),
//               ),
//             )
//           ],
//         ),
//         body: SingleChildScrollView(
//             child: Padding(
//           padding: const EdgeInsets.only(top: 5, bottom: 5),
//           child: Stack(
//             children: [
//               Column(
//                 children: [
//                   SizedBox(
//                     height: 1,
//                   ),
//                   Container(
//                     width: double.infinity,
//                     height: MediaQuery.of(context).size.height * .4,
//                     decoration: BoxDecoration(
//                         color: AppColors.primaryColor,
//                         boxShadow: [
//                           BoxShadow(
//                               color: Color.fromARGB(250, 142, 144, 149),
//                               offset: Offset(0, 0),
//                               spreadRadius: .5,
//                               blurRadius: 4)
//                         ],
//                         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40), )),
//                     child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           AppConstants.kheight15,
//                           Text(
//                             'HELLO NANDA 👋🏻',
//                             style: TextStyle(
//                                 color: Color.fromRGBO(102, 108, 137, 1.0),
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           AppConstants.kheight5,
//                           Text(
//                             'What you are looking for today',
//                             style: TextStyle(
//                                 fontSize: 31, fontWeight: FontWeight.w800),
//                           ),
//                           AppConstants.kheight15,
//                           TextFeild(
//                              obscure: false,
//                             hinttext:
//                                 'Search for ${_categories[_currentIndex]}',
//                             controller: searchController,
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                  SizedBox(height: 4,),
//                   Container(
//                     height: MediaQuery.of(context).size.height * .48,
//                     color: AppColors.primaryColor,
//                   )
//                 ],
//               ),
//               // Positioned(
//               //   top: 215,
//               //   child: CarouselWithBuilder(
//               //     itemCount: 3,
//               //     itemBuilder: (context, index) {
//               //       return Container(
//               //         height: 260,
//               //         width: 400,
//               //         margin: EdgeInsets.all(8.0),
//               //         decoration: BoxDecoration(
//               //           color: AppColors.mainBlueColor,
//               //           borderRadius: BorderRadius.circular(8.0),
//               //         ),
//               //         child: Center(
//               //           child: Text(
//               //             'Item $index',
//               //             style: TextStyle(fontSize: 24, color: Colors.white),
//               //           ),
//               //         ),
//               //       );
//               //     },
//               //   ),
//               // ),
//             ],
//           ),
//         )));
//   }
// }

// class CarouselWithBuilder extends StatelessWidget {
//   final int itemCount;
//   final IndexedWidgetBuilder itemBuilder;

//   CarouselWithBuilder({required this.itemCount, required this.itemBuilder});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 190,
//       width: 400,
//       child: CarouselSlider.builder(
//         itemCount: itemCount,
//         itemBuilder: (context, index, realIndex) {
//           return itemBuilder(context, index);
//         },
//         options: CarouselOptions(
//             height: 230.0,
//             autoPlayInterval: Duration(seconds: 10),
//             autoPlay: true,
//             enlargeCenterPage: true,
//             aspectRatio: 15 / 9,
//             viewportFraction: .80,
//             clipBehavior: Clip.hardEdge),
//       ),
//     );
//   }
// }

// ////
// import 'dart:async';

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:metrogeniusapp/src/screens/bottomnavigation/data.dart';
// import 'package:metrogeniusapp/src/widgets/home/carousel.dart';
// import 'package:metrogeniusapp/src/widgets/home/categories_container.dart';
// import 'package:metrogeniusapp/src/widgets/textfeild.dart';
// import 'package:metrogeniusapp/utils/colors.dart';
// import 'package:metrogeniusapp/utils/constants.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   List<String> _categories = [
//     'Home Cleaning',
//     'A/C Repair',
//     'Electrical Works',
//     'Beauty'
//   ];
//   List<String> images = [
//     'https://cleaningspaces.net/wp-content/uploads/2021/05/monthly-cleaning-schedule.jpeg',
//     'https://t4.ftcdn.net/jpg/05/11/92/95/360_F_511929539_hkrzPKGI6pEA8TwUfrwrB0g73FyEaowM.jpg',
//     'https://media.istockphoto.com/id/1389783400/photo/the-man-repairing-broken-tv-at-home.jpg?s=612x612&w=0&k=20&c=oE5qA2xMWCEOcIHu9CMWFEuihKElSicch_Dbx7NjCvc=',
//     'https://t3.ftcdn.net/jpg/04/80/48/10/360_F_480481061_rld9llq95TvFSMM3vAcacadXeVtiAYa6.jpg'
//   ];

//   int _currentIndex = 0;
//   late Timer _timer;
//   double _opacity = 1.0;

//   @override
//   void initState() {
//     super.initState();
//     _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
//       setState(() {
//         _opacity = 0.0;
//       });
//       Future.delayed(const Duration(milliseconds: 500), () {
//         setState(() {
//           _currentIndex = (_currentIndex + 1) % _categories.length;
//           _opacity = 1.0;
//         });
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController searchController = TextEditingController();
//     return Scaffold(
//         appBar: AppBar(
//           toolbarHeight: 66,
//           backgroundColor: AppColors.primaryColor,
//           automaticallyImplyLeading: false,
//           title: const Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'CURRENT LOCATION',
//                 style: TextStyle(fontSize: 14),
//               ),
//               Text('📍Maradu,Kochi', style: TextStyle(fontSize: 14))
//             ],
//           ),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.only(right: 20),
//               child: Container(
//                 height: 48,
//                 width: 48,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(25),
//                     border: Border.all(color: Colors.grey.shade400)),
//                 child: const Icon(
//                   Icons.notifications_active_outlined,
//                   size: 25,
//                 ),
//               ),
//             )
//           ],
//         ),
//         body: SingleChildScrollView(
//             child: Padding(
//           padding: const EdgeInsets.only(top: 3, bottom: 3, left: 3, right: 3),
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 1,
//               ),
//               Container(
//                 width: double.infinity,
//                 height: MediaQuery.of(context).size.height * .3,
//                 decoration: const BoxDecoration(
//                   borderRadius: BorderRadius.only(),
//                   color: AppColors.primaryColor,
//                   boxShadow: [
//                     BoxShadow(
//                         color: Color.fromARGB(248, 185, 187, 192),
//                         offset: Offset(0, 0),
//                         spreadRadius: .2,
//                         blurRadius: .1)
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       AppConstants.kheight15,
//                       const Text(
//                         'HELLO NANDA 👋🏻',
//                         style: TextStyle(
//                             color: Color.fromRGBO(102, 108, 137, 1.0),
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       AppConstants.kheight5,
//                       const Text(
//                         'What you are looking for today',
//                         style: TextStyle(
//                             fontSize: 31, fontWeight: FontWeight.w800),
//                       ),
//                       AppConstants.kheight15,
//                       TextFeild(
//                          obscure: false,
//                         hinttext: 'Search for ${_categories[_currentIndex]}',
//                         controller: searchController,
//                         prefixIcon: const Icon(
//                           Icons.search_outlined,
//                           color: AppColors.mainBlueColor,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               AppConstants.kheight15,
//               Padding(
//                 padding: const EdgeInsets.only(left: 4),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Row(children: [
//                     Container(
//                       height: 20,
//                       decoration: BoxDecoration(
//                           color: AppColors.mainBlueColor,
//                           borderRadius: BorderRadius.circular(14)),
//                       width: 5,
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     const Text(
//                       'Categories',
//                       style: TextStyle(
//                           fontWeight: FontWeight.w800,
//                           fontSize: 19,
//                           color: Color.fromARGB(255, 0, 0, 0)),
//                     )
//                   ]),
//                 ),
//               ),
//               AppConstants.kheight20,
//               Container(
//                 height: MediaQuery.of(context).size.height * .36,
//                 width: double.infinity,
//                 decoration: const BoxDecoration(
//                   color: AppColors.primaryColor,
//                   boxShadow: [
//                     BoxShadow(
//                         color: Color.fromARGB(248, 185, 187, 192),
//                         offset: Offset(0, 0),
//                         spreadRadius: .2,
//                         blurRadius: .1)
//                   ],
//                 ),
//                 child: Padding(
//                     padding: const EdgeInsets.only(
//                         top: 10, bottom: 0, left: 0, right: 0),
//                     child: GridView.builder(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemCount: 8,
//                       gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//                           maxCrossAxisExtent: 95,
//                           mainAxisSpacing: 10.0,
//                           crossAxisSpacing: 5,
//                           mainAxisExtent: 125),
//                       itemBuilder: (context, index) {
//                         return HomeCatgeories(
//                             imgurl: 'assets/ac.png',
//                             color: const Color.fromRGBO(255, 188, 153, 1.0),
//                             scale: 4,
//                             heading: 'AC Repair');
//                       },
//                     )),
//               ),
//               AppConstants.kheight15,
//               Padding(
//                 padding: const EdgeInsets.only(left: 4),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Row(children: [
//                     Container(
//                       height: 20,
//                       decoration: BoxDecoration(
//                           color: AppColors.mainBlueColor,
//                           borderRadius: BorderRadius.circular(14)),
//                       width: 5,
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     const Text(
//                       'Top Services',
//                       style: TextStyle(
//                           fontWeight: FontWeight.w800,
//                           fontSize: 19,
//                           color: Color.fromARGB(255, 0, 0, 0)),
//                     )
//                   ]),
//                 ),
//               ),
//               AppConstants.kheight15,
//               CarouselWithBuilder(
//                 itemCount: 3,
//                 itemBuilder: (context, index) {
//                   return Container(
//                       height: 260,
//                       width: 400,
//                       margin: const EdgeInsets.all(8.0),
//                       decoration: const BoxDecoration(
//                         color: Colors.transparent,
//                       ),
//                       child: ClipRRect(
//                           borderRadius: BorderRadius.circular(12),
//                           child: Image.network(
//                             images[index],
//                             fit: BoxFit.cover,
//                           )));
//                 },
//               ),
//               AppConstants.kheight15,
//               Padding(
//                 padding: const EdgeInsets.only(left: 4),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Row(children: [
//                     Container(
//                       height: 20,
//                       decoration: BoxDecoration(
//                           color: AppColors.mainBlueColor,
//                           borderRadius: BorderRadius.circular(14)),
//                       width: 5,
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     const Text(
//                       'New And Notable',
//                       style: TextStyle(
//                           fontWeight: FontWeight.w800,
//                           fontSize: 19,
//                           color: Color.fromARGB(255, 0, 0, 0)),
//                     )
//                   ]),
//                 ),
//               ),
//               AppConstants.kheight20,
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     NewNotable(
//                       imageurl:
//                           'https://s3-ap-southeast-1.amazonaws.com/urbanclap-prod/images/growth/home-screen/1602245928963-5094c6.jpeg',
//                       text: 'Home Painting',
//                     ),
//                     const SizedBox(
//                       width: 20,
//                     ),
//                     NewNotable(
//                         imageurl:
//                             'https://img.freepik.com/free-photo/man-florist-working-green-house_1303-29878.jpg',
//                         text: 'Gardening'),
//                     const SizedBox(
//                       width: 20,
//                     ),
//                     NewNotable(
//                         imageurl:
//                             'https://media.istockphoto.com/id/1128872850/photo/repairman-fixing-refrigerator-with-screwdriver.jpg?s=612x612&w=0&k=20&c=F6fgkzj1e_2x-diaozUqVhHuN967oY5bmlbaO5kD5Xk=',
//                         text: 'Fridge')
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         )));
//   }
// }

// class NewNotable extends StatelessWidget {
//   String imageurl;
//   String text;
//   NewNotable({
//     required this.imageurl,
//     required this.text,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 6),
//       child: Container(
//         height: 150,
//         width: 130,
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
//         child: Column(
//           children: [
//             SizedBox(
//               height: 130,
//               width: 130,
//               child: ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: Image.network(
//                     imageurl,
//                     fit: BoxFit.cover,
//                   )),
//             ),
//             Text(
//               text,
//               style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }













































  //  Positioned(
  //           bottom: 560,
  //           left: 0,
  //           right: 0,
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Center(
  //               child: SmoothPageIndicator(
  //                 controller: _pageController,
  //                 count: images.length,
  //                 effect: ScaleEffect(
  //                   dotHeight: 7,
  //                   activeDotColor: AppColors.mainBlueColor,
  //                   dotWidth: 7,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //         Positioned(
  //           top: MediaQuery.of(context).size.height * .31,
  //           left: MediaQuery.of(context).size.width * .06,
  //           child: Align(
  //             child: Container(
  //               width: MediaQuery.of(context).size.width * 0.88,
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(30),
  //                 boxShadow: const [
  //                   BoxShadow(
  //                     color: Color.fromARGB(250, 142, 144, 149),
  //                     offset: Offset(0, 0),
  //                     spreadRadius: .5,
  //                     blurRadius: .5,
  //                   ),
  //                 ],
  //               ),
  //               child: TextFormField(
  //                 decoration: InputDecoration(
  //                   prefixIcon: const Icon(Icons.search),
  //                   hintText: 'Search for AC Repair',
  //                   errorBorder: const OutlineInputBorder(
  //                     borderRadius: BorderRadius.all(Radius.circular(30)),
  //                     borderSide:
  //                         BorderSide(color: Color.fromARGB(255, 214, 214, 214)),
  //                   ),
  //                   focusedErrorBorder: const OutlineInputBorder(
  //                     borderRadius: BorderRadius.all(Radius.circular(30)),
  //                     borderSide:
  //                         BorderSide(color: Color.fromARGB(255, 214, 214, 214)),
  //                   ),
  //                   enabledBorder: const OutlineInputBorder(
  //                     borderRadius: BorderRadius.all(Radius.circular(30)),
  //                     borderSide:
  //                         BorderSide(color: Color.fromARGB(255, 214, 214, 214)),
  //                   ),
  //                   focusedBorder: const OutlineInputBorder(
  //                     borderRadius: BorderRadius.all(Radius.circular(30)),
  //                     borderSide:
  //                         BorderSide(color: Color.fromARGB(255, 214, 214, 214)),
  //                   ),
  //                   fillColor: AppColors.primaryColor,
  //                   filled: true,
  //                   border: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(30),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //         Positioned(
  //           top: 40,
  //           left: 20,
  //           child: Text(
  //             'HELLO NANDA 👋🏻',
  //             style: const TextStyle(
  //               color: Color.fromRGBO(0, 0, 0, 1),
  //               fontSize: 16,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //         ),