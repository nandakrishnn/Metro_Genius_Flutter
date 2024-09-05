import 'package:flutter/material.dart';
import 'package:metrogeniusapp/utils/colors.dart';

class ReferFriend extends StatelessWidget {
  const ReferFriend({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.20,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: AppColors.greyColor.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                  blurStyle:
                      BlurStyle.normal
                  ),
            ],
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(30)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.network(
            'https://www.shutterstock.com/image-vector/refer-friend-concept-man-holding-260nw-1434782945.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}