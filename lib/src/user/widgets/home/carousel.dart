import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusapp/bloc/fetch_rating_new_notable.dart/new_notable_ratings_fetch_bloc.dart';
import 'package:metrogeniusapp/services/home/home_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:metrogeniusapp/src/user/screens/home/sub_catgeories/details_subcatgeory.dart'; // Import Firestore package

class AnimatedCarousel extends StatefulWidget {
  @override
  _AnimatedCarouselState createState() => _AnimatedCarouselState();
}

class _AnimatedCarouselState extends State<AnimatedCarousel> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NewNotableRatingsFetchBloc(HomeService())..add(FetchNewlyAdded()),
      child:
          BlocConsumer<NewNotableRatingsFetchBloc, NewNotableRatingsFetchState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is NewNotableRatingsFetchLoaded) {
            final List<DocumentSnapshot> items = state.data; // Assuming data is a list of DocumentSnapshot

            return Scaffold(
              body: Center(
                child: CarouselSlider(
                  items: items.map((item) {
                    // Access index within the map
                    final index = items.indexOf(item);

                    return GestureDetector(
                      onTap: () {
                   
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InsideSubCatgeory(
                              categoryType: items[index]['Category'],
                              data: items[index],
                            ),
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.network(
                              item['CatImage'],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                  sigmaX: 0.5, sigmaY: 0.5),
                              child: Container(
                                alignment: Alignment.center,
                                color: Colors.black.withOpacity(0.3), // Tint color with transparency
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10.0,
                            left: 10.0,
                            right: 10.0,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      item['CatName'] ?? 'Default Title',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.4),
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                          size: 12,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          item['CatRating'].toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    enlargeCenterPage: true,
                    aspectRatio: 12 / 5,
                    viewportFraction: 0.8,
                    onPageChanged: (index, reason) {
                      // Optional: handle page change if needed
                    },
                  ),
                ),
              ),
            );
          }

          // Display a loading indicator while loading
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

