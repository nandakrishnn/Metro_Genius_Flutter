import 'package:flutter/material.dart';
import 'package:metrogeniusapp/utils/colors.dart';
import 'package:metrogeniusapp/utils/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    late PageController _pageController = PageController();

    List<String> images = [
      'https://plus.unsplash.com/premium_photo-1664300619226-cc9cc0f41399?fm=jpg&w=3000&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Y2xlYW5pbmclMjBob3VzZXxlbnwwfHwwfHx8MA%3D%3D',
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

    return Scaffold(
      drawer: Drawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(32),
                                  bottomRight: Radius.circular(32),
                                ),
                                // color: AppColors.mainBlueColor,
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromARGB(250, 142, 144, 149),
                                      offset: Offset(0, 0),
                                      spreadRadius: 2.0,
                                      blurRadius: 1)
                                ]),
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * .35,
                            child: ClipRRect(
                                borderRadius: BorderRadius.only(
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
                                    }))),
                        Positioned(
                          bottom: 35,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: SmoothPageIndicator(
                                controller: _pageController,
                                count: images.length,
                                effect: ScaleEffect(
                                  dotHeight: 7,
                                  activeDotColor: AppColors.mainBlueColor,
                                  dotWidth: 7,
                                ), // Choose your preferred effect
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 40,
                          left: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'HELLO NANDA 👋🏻',
                                style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              AppConstants.kheight5,
                              Text(
                                'What you are looking for today',
                                style: TextStyle(
                                    fontSize: 23, fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .65,
                      color: AppColors.primaryColor,
                    )
                  ],
                ),
                Positioned(
                    top: MediaQuery.of(context).size.height * .31,
                    left: MediaQuery.of(context).size.width * .06,
                    child: Align(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(250, 142, 144, 149),
                                  offset: Offset(0, 0),
                                  spreadRadius: .5,
                                  blurRadius: .5)
                            ]),
                        width: 350,
                        child: TextFormField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search),
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
                              // focusColor: Colors.grey,
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
                              )),
                        ),
                      ),
                    )),
                    
              ],
            ),
            
          ],
        ),

      ),
    );
  }
}
