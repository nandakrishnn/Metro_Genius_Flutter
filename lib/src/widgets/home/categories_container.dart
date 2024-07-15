import 'package:flutter/material.dart';
import 'package:metrogeniusapp/utils/constants.dart';

class HomeCatgeories extends StatelessWidget {
  String imgurl;

  Color color;
  double scale;
  String heading;
  HomeCatgeories({
    required this.imgurl,
    required this.color,
    required this.scale,
    required this.heading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 78,
          width: 78,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(90),
              
               color: color),
          child: Image.asset(
            imgurl,
            scale: scale,
          ),
        ),
        AppConstants.kheight10,
        Text(
          heading,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}
