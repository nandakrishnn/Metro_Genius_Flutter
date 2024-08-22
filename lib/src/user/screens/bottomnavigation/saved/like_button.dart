import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';


class CustomLikeButton extends StatelessWidget {
  final bool isFavorited;
  final Future<bool> Function(bool) onLikeButtonTapped;

  CustomLikeButton({
    super.key,
    required this.isFavorited,
    required this.onLikeButtonTapped,
  });

  @override
  Widget build(BuildContext context) {
    return LikeButton(
      isLiked: isFavorited,
      circleColor: const CircleColor(
        start: Color(0xff00ddff),
        end: Color(0xff0099cc),
      ),
      bubblesColor: const BubblesColor(
        dotPrimaryColor: Colors.pink,
        dotSecondaryColor: Colors.white,
      ),
      likeBuilder: (bool isLiked) {
        return Icon(
          Icons.favorite,
          color: isLiked ? Colors.red : Colors.white,
          size: 25,
        );
      },
      onTap: onLikeButtonTapped,
    );
  }
}