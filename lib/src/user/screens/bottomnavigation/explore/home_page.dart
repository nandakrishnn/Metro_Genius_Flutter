import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusapp/animations/route_animations.dart';
import 'package:metrogeniusapp/bloc/Admin/get_category/get_category_bloc.dart';
import 'package:metrogeniusapp/services/admin/applications/admin_services.dart';
import 'package:metrogeniusapp/src/user/screens/bottomnavigation/data.dart';
import 'package:metrogeniusapp/src/user/screens/bottomnavigation/explore/all_catgroies.dart';
import 'package:metrogeniusapp/src/user/widgets/home/carousel.dart';
import 'package:metrogeniusapp/src/user/widgets/home/categories_container.dart';
import 'package:metrogeniusapp/src/user/widgets/home/new_notable.dart';
import 'package:metrogeniusapp/utils/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../../utils/colors.dart';

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
                      height: MediaQuery.of(context).size.height * .35,
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
                            return Image.network(
                              images[index],
                              fit: BoxFit.cover,
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
                  bottom: 70,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: images.length,
                        effect: const ScaleEffect(
                          dotHeight: 7,
                          activeDotColor: AppColors.mainBlueColor,
                          dotWidth: 7,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * .31,
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
                  top: 40,
                  left: 10,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.menu_rounded)),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'HELLO NANDA 👋🏻',
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
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
                  AppConstants.kheight20
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
                            return HomeCatgeories(
                              imgurl: data[index]['CategoryImage'],
                              scale: 0,
                              heading: data[index]['CatgeoryName'],
                            );
                          } else if (index == 5) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(createRoute(AllCatgeories()));
                                },
                                child: HomeCatgeories(
                                    imgurl:
                                        'https://i.pinimg.com/originals/96/28/28/9628288cf4023b3b5dc553421f8507cf.jpg',
                                    scale: 0,
                                    heading: 'All Categories'));
                          }
                          return SizedBox.shrink(); // Fallback for empty states
                        },
                        childCount: 6, // Add 1 for the "See All" item
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
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppConstants.kheight20,
                  const Text(
                    'New And Notable',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 19,
                        color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  AppConstants.kheight20,
                  AppConstants.kheight5,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        NewNotable(
                          imageurl:
                              'https://s3-ap-southeast-1.amazonaws.com/urbanclap-prod/images/growth/home-screen/1602245928963-5094c6.jpeg',
                          text: 'Home Painting',
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        NewNotable(
                            imageurl:
                                'https://img.freepik.com/free-photo/man-florist-working-green-house_1303-29878.jpg',
                            text: 'Gardening'),
                        const SizedBox(
                          width: 20,
                        ),
                        NewNotable(
                            imageurl:
                                'https://media.istockphoto.com/id/1128872850/photo/repairman-fixing-refrigerator-with-screwdriver.jpg?s=612x612&w=0&k=20&c=F6fgkzj1e_2x-diaozUqVhHuN967oY5bmlbaO5kD5Xk=',
                            text: 'Fridge')
                      ],
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
                  CarouselWithBuilder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 260,
                        width: 400,
                        margin: const EdgeInsets.all(0.0),
                        decoration: const BoxDecoration(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            images[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
