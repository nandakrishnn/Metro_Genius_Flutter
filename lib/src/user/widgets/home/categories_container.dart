import 'package:flutter/material.dart';
import 'package:metrogeniusapp/utils/constants.dart';

class HomeCategories extends StatefulWidget {
  final String imgurl;
  final double scale;
  final String heading;

  HomeCategories({
    required this.imgurl,
    required this.scale,
    required this.heading,
    super.key,
  });

  @override
  State<HomeCategories> createState() => _HomeCategoriesState();
}

class _HomeCategoriesState extends State<HomeCategories>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
      reverseDuration: const Duration(milliseconds: 2300),
    )..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) _controller.reverse();
        if (status == AnimationStatus.dismissed) _controller.forward();
      });

    _animation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: const Offset(0, 0),
    ).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(45), // Half of height/width to ensure circle
            child: Container(
              height: 90, // Ensure height and width are the same
              width: 90,
              color: Colors.black12, // Fallback color if image fails to load
              child: Image.network(
                widget.imgurl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          AppConstants.kheight5,
          Text(
            widget.heading,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
