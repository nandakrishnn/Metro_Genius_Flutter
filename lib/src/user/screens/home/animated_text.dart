import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class AnimatedTextKitWidgetHome extends StatelessWidget {
  const AnimatedTextKitWidgetHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300, // Adjust width as needed to ensure alignment consistency
        child: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              'MetroGenius: Your Home, Our Priority!',
              textStyle: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                shadows: [
                  Shadow(
                    blurRadius: 5.0,
                    color: Colors.black26,
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
              speed: const Duration(milliseconds: 100),
              cursor: ' ', // Removes the underscore cursor
            ),
            TypewriterAnimatedText(
              'Expert Services at Your Doorstep.',
              textStyle: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                shadows: [
                  Shadow(
                    blurRadius: 5.0,
                    color: Colors.black26,
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
              speed: const Duration(milliseconds: 100),
              cursor: ' ', // Removes the underscore cursor
            ),
            TypewriterAnimatedText(
              'Book Now and Experience the Best!',
              textStyle: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
                color: Colors.black,
                shadows: [
                  Shadow(
                    blurRadius: 5.0,
                    color: Colors.black26,
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
              speed: const Duration(milliseconds: 100),
              cursor: ' ', // Removes the underscore cursor
            ),
          ],
          repeatForever: true, // Loop the animation infinitely
          pause: const Duration(milliseconds: 800), // Short pause between animations
          displayFullTextOnTap: true,
          stopPauseOnTap: true,
        ),
      ),
    );
  }
}

