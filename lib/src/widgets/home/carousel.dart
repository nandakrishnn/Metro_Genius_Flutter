import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselWithBuilder extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  CarouselWithBuilder({required this.itemCount, required this.itemBuilder});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(
          color: Colors.black,
          offset: Offset(0, 0),
          blurRadius: 4,
          spreadRadius: 5
        )]
      ),
      height: 190,
      width: 455,
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
            aspectRatio: 16 / 11,
            viewportFraction: .95,
            ),
      ),
    );
  }
}
