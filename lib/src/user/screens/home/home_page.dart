import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusapp/animations/route_animations.dart';
import 'package:metrogeniusapp/bloc/Admin/get_category/get_category_bloc.dart';
import 'package:metrogeniusapp/bloc/fetch_rating_new_notable.dart/new_notable_ratings_fetch_bloc.dart';
import 'package:metrogeniusapp/services/admin/applications/admin_services.dart';
import 'package:metrogeniusapp/services/home/home_service.dart';
import 'package:metrogeniusapp/src/user/screens/home/animated_text.dart';
import 'package:metrogeniusapp/src/user/screens/home/categories/all_catgroies.dart';
import 'package:metrogeniusapp/src/user/screens/home/sub_catgeories/details_subcatgeory.dart';
import 'package:metrogeniusapp/src/user/screens/home/sub_catgeories/sub_category_view.dart';
import 'package:metrogeniusapp/src/user/widgets/home/carousel.dart';
import 'package:metrogeniusapp/src/user/widgets/home/categories_container.dart';
import 'package:metrogeniusapp/src/user/widgets/home/sub_catgeory/home_new_notable.dart';
import 'package:metrogeniusapp/utils/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../utils/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late PageController _pageController;

  List<String> images = [
    'https://s3media.angieslist.com/s3fs-public/house-cleaners-cleaning.jpeg',
    'https://img.freepik.com/premium-photo/house-cleaning-service-container-with-spray-bottle-rubber-gloves-scrub-home-living-room-apartment-interior-spring-clean-day-career-housekeeping-with-household-products-table_590464-85948.jpg',
    'https://img.freepik.com/premium-photo/young-tired-man-cleaning-home-with-mop-vacuum-cleaner-living-room-housekeeping-home-cleaning-concept_116547-3612.jpg'
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(32),
                          bottomRight: Radius.circular(32),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(250, 142, 144, 149),
                            offset: Offset(0, 0),
                            spreadRadius: 2.0,
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * .30,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(32),
                          bottomRight: Radius.circular(32),
                        ),
                        child: PageView.builder(
                          controller: _pageController,
                          scrollDirection: Axis.horizontal,
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.network(
                                  images[index],
                                  fit: BoxFit.cover,
                                ),
                                BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 3.5, sigmaY: 3.5),
                                  child: Container(
                                    color: Colors
                                        .transparent, // This maintains the blur effect
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .031,
                      width: double.infinity,
                      color: AppColors.primaryColor,
                    )
                  ],
                ),
                Positioned(
                  bottom: 60,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: images.length,
                        effect: const ScaleEffect(
                          dotHeight: 4,
                          activeDotColor: AppColors.mainBlueColor,
                          dotWidth: 4,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * .26,
                  left: MediaQuery.of(context).size.width * .06,
                  right: MediaQuery.of(context).size.width * .06,
                  child: Align(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.88,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(250, 142, 144, 149),
                            offset: Offset(0, 0),
                            spreadRadius: .5,
                            blurRadius: .5,
                          ),
                        ],
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'Search for AC Repair',
                          errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 214, 214, 214)),
                          ),
                          focusedErrorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 214, 214, 214)),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 214, 214, 214)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 214, 214, 214)),
                          ),
                          fillColor: AppColors.primaryColor,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 140,
                    left: 10,
                    right: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AnimatedTextKitWidgetHome(),
                    ))
               
              ],
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppConstants.kheight20,
                  Text(
                    'All Categories',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 19,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  AppConstants.kheight5
                ],
              ),
            ),
          ),
          BlocProvider(
            create: (context) =>
                GetCategoryBloc(AdminServices())..add(FetchDataCategory()),
            child: BlocConsumer<GetCategoryBloc, GetCategoryState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is GetCategoryStateLoading) {
                    return SliverToBoxAdapter(
                        child: CupertinoActivityIndicator());
                  }
                  if (state is GetCategoryStateLoaded) {
                    final data = state.data;
                    return SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 130,
                        crossAxisSpacing: 9,
                        mainAxisSpacing: 0,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          if (index < 5) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .push(createRoute(SubCatgeoryDetails(
                                  data: data[index],
                                )));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: HomeCategories(
                                  imgurl: data[index]['CategoryImage'],
                                  scale: 0,
                                  heading: data[index]['CatgeoryName'],
                                ),
                              ),
                            );
                          } else if (index == 5) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(createRoute(AllCatgeories()));
                                },
                                child: HomeCategories(
                                    imgurl:
                                        'https://i.pinimg.com/originals/96/28/28/9628288cf4023b3b5dc553421f8507cf.jpg',
                                    scale: 0,
                                    heading: 'All Categories'));
                          }
                          return SizedBox.shrink();
                        },
                        childCount: 6,
                      ),
                    );
                  } else {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text('hey'),
                      ),
                    );
                  }
                }),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                left: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  AppConstants.kheight20,
                  Text(
                    'Recently Added',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 19,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  AppConstants.kheight10,
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
                height: MediaQuery.of(context).size.height * .24,
                width: double.infinity,
                child: AnimatedCarousel()),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppConstants.kheight10,
                  const Text(
                    'New And Notable',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 19,
                        color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  AppConstants.kheight10,
                  BlocProvider(
                    create: (context) =>
                        NewNotableRatingsFetchBloc(HomeService())
                          ..add(FetchRatingData()),
                    child: BlocConsumer<NewNotableRatingsFetchBloc,
                        NewNotableRatingsFetchState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is NewNotableRatingsFetchLoaded) {
                          return SizedBox(
                            height: 160,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.data.length,
                                itemBuilder: (context, index) {
                                  final data = state.data;
                                  final Map<String, bool>? checkBoxData =
                                      data[index]['CheckBox'] != null
                                          ? Map<String, bool>.from(
                                              data[index]['CheckBox'])
                                          : null;
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 5),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(createRoute(
                                            InsideSubCatgeory(
                                                data: data[index],
                                                checkBoxData: checkBoxData,
                                                categoryType: data[index]
                                                    ['Category'])));
                                      },
                                      child: NewNotableHome(
                                          rating: data[index]['CatRating']
                                              .toString(),
                                          imageurl: data[index]['CatImage'],
                                          text: data[index]['CatName']),
                                    ),
                                  );
                                }),
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                  AppConstants.kheight20,
                  AppConstants.kheight5,
                  const Padding(
                    padding: EdgeInsets.only(left: 0),
                    child: Text(
                      'Top Services',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 19,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                  AppConstants.kheight15,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
