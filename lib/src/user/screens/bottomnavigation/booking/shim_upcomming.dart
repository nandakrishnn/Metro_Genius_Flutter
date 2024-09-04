import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metrogeniusapp/utils/colors.dart';
import 'package:metrogeniusapp/utils/constants.dart';
import 'package:shimmer/shimmer.dart';

class UpcommingUserBookingShimmer extends StatelessWidget {
  const UpcommingUserBookingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]??AppColors.greyColor,
      highlightColor: Colors.white, // Brighter highlight for a sparkling effect
      period: Duration(milliseconds: 2000), // Adjust speed for a glitter-like effect
      child: Container(
        height: 260,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.primaryColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.greyColor.withOpacity(0.2),
              offset: const Offset(0, 0),
              spreadRadius: 0.9,
              blurRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppConstants.kheight15,
            Row(
              children: [
                AppConstants.kwidth20,
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.grey[400], // Slightly darker grey for the avatar
                ),
                AppConstants.kwidth20,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 16,
                      width: 120,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.grey[400]??AppColors.greyColor, Colors.grey[200]??AppColors.greyColor],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ), // Gradient for glitter effect
                    ),
                    AppConstants.kheight5,
                    Container(
                      height: 16,
                      width: 150,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.grey[350]??AppColors.greyColor, Colors.grey[150]??AppColors.greyColor],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        ),
                      ), // Gradient variation for difference
                    ),
                  ],
                ),
              ],
            ),
            AppConstants.kheight15,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Wrap(
                children: List.generate(50, (index) {
                  return Container(
                    width: 4,
                    height: 1,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    color: AppColors.greyColor,
                  );
                }),
              ),
            ),
            AppConstants.kheight10,
            Row(
              children: [
                AppConstants.kwidth10,
                Container(
                  height: 16,
                  width: 50,
                  color: Colors.grey[400], // Different shade for status label
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 7),
                  child: Container(
                    height: 35,
                    width: 100,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.grey[300]??AppColors.greyColor, Colors.grey[400]??AppColors.greyColor],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
            AppConstants.kheight10,
            Row(
              children: [
                AppConstants.kwidth20,
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey[350], // Matching grey for small avatar
                ),
                AppConstants.kwidth10,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 16,
                      width: 100,
                      color: Colors.grey[400], // Darker shade for larger text
                    ),
                    AppConstants.kheight5,
                    Container(
                      height: 16,
                      width: 80,
                      color: Colors.grey[350], // Slightly lighter shade
                    ),
                  ],
                ),
              ],
            ),
            AppConstants.kheight10,
            Row(
              children: [
                AppConstants.kwidth20,
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey[350], // Consistent shade for icons
                ),
                AppConstants.kwidth10,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 16,
                      width: 100,
                      color: Colors.grey[400], // Differentiated shade for text
                    ),
                    AppConstants.kheight5,
                    Container(
                      height: 16,
                      width: 80,
                      color: Colors.grey[350],
                    ),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 7),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      gradient: LinearGradient(
                        colors: [Colors.grey[300]??AppColors.greyColor, Colors.grey[200]??AppColors.greyColor], // Glitter-like gradient
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    height: 40,
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_sharp,
                          color: Colors.grey[300], // Lighter grey for icon
                        ),
                        AppConstants.kwidth5,
                        Container(
                          height: 16,
                          width: 40,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.grey[350]??AppColors.greyColor, Colors.grey[200]??AppColors.greyColor],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ), // Differentiated for button text
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
