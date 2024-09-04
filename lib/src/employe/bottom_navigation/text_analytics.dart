import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:metrogeniusapp/utils/colors.dart'; // Ensure correct path for colors

class AnimatedTextKitWidget extends StatelessWidget {
  final String text1;
  final String text2;

  const AnimatedTextKitWidget({
    super.key,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9, // Container width
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.15),
          //     blurRadius: 15,
          //     spreadRadius: 5,
          //     offset: const Offset(0, 10),
          //   ),
          // ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedTextKit(
              animatedTexts: [
                // Typing animation for text1
                TyperAnimatedText(
                  text1,
                  textStyle: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: AppColors.mainBlueColor,
                  ),
                  speed: const Duration(milliseconds: 200),
                ),
                // Typing animation for text2
                TyperAnimatedText(
                  text2,
                  textStyle: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                    color: AppColors.mainBlueColor,
                  ),
                  speed: const Duration(milliseconds: 200),
                ),
              ],
              pause: const Duration(milliseconds: 500),
              displayFullTextOnTap: true,
              stopPauseOnTap: true,
              isRepeatingAnimation: true, // Ensures the animation repeats indefinitely
            ),
          ],
        ),
      ),
    );
  }
}
