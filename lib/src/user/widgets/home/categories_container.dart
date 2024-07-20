import 'package:flutter/material.dart';
import 'package:metrogeniusapp/utils/constants.dart';

class HomeCatgeories extends StatelessWidget {
  String imgurl;

  double scale;
  String heading;
  HomeCatgeories({
    required this.imgurl,
    required this.scale,
    required this.heading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(),
          child: Column(
            children: [
              Image.network(
                imgurl,
                height: 70,
                width: 95,
                fit: BoxFit.cover,
              ),
              AppConstants.kheight5,
              Text(
                heading,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
