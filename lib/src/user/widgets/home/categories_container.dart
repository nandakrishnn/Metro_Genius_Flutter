import 'package:flutter/material.dart';
import 'package:metrogeniusapp/utils/constants.dart';

class HomeCatgeories extends StatelessWidget {
  final String imgurl;
  final double scale;
  final String heading;

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
        ClipRRect(
          borderRadius: BorderRadius.circular(45), // Half of height/width to ensure circle
          child: Container(
            height: 90, // Ensure height and width are the same
            width: 90,
            color: Colors.black12, // Fallback color if image fails to load
            child: Image.network(
              imgurl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        AppConstants.kheight5,
        Text(
          heading,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
