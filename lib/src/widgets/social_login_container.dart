import 'package:flutter/material.dart';

class SocialLoginContainer extends StatelessWidget {
  String imageurl;
  SocialLoginContainer({
    required this.imageurl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 130,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color.fromARGB(255, 255, 255, 255),
          boxShadow: [
            BoxShadow(
                color: const Color.fromARGB(255, 227, 227, 227),
                spreadRadius: 2,
                offset: Offset(0, 0))
          ]),
      child: Center(
          child: Image.network(
        imageurl,
        height: 60,
        width: 60,
      )),
    );
  }
}
