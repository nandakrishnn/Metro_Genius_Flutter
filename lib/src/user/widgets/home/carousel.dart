import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusapp/bloc/fetch_rating_new_notable.dart/new_notable_ratings_fetch_bloc.dart';
import 'package:metrogeniusapp/services/home/home_service.dart';

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
        listener: (context, state) {
          // Handle any state changes if needed
        },
        builder: (context, state) {
          if (state is NewNotableRatingsFetchLoaded) {
            final List<Map<String, dynamic>> items = state.data
                .map((item) => {
                      'imageUrl': item['CatImage'] as String,
                      'title': item['CatName'] ?? 'Default Title',
                      'rating': item['CatRating'] ??
                          'Default Title', // Example of additional data
                    })
                .toList();

            return Scaffold(
              body: Center(
                child: CarouselSlider(
                  items: items.map((item) {
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.network(
                            item['imageUrl'],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                                sigmaX: 0.5,
                                sigmaY: 0.5), // Adjust blur strength
                            child: Container(
                              alignment: Alignment.center,
                              color: Colors.black.withOpacity(
                                  0.3), // Tint color with some transparency
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10.0,
                          left: 10.0,
                          right: 10.0,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    item['title'],
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
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
                                        item['rating'].toString(),
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
                      // Optional: handle page change
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
