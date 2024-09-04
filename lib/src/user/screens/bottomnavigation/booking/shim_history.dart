import 'package:flutter/material.dart';
import 'package:metrogeniusapp/utils/colors.dart';
import 'package:shimmer/shimmer.dart';

class HistoryUserBookingShimmer extends StatelessWidget {
  const HistoryUserBookingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]??AppColors.greyColor,
      highlightColor: Colors.grey[100]??AppColors.greyColor,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 0),
              spreadRadius: 0.9,
              blurRadius: 1,
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row for category and subcategory
            Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.grey[350], // Slightly darker for avatar
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 10,
                      color: Colors.grey[400], // Medium grey for title
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 60,
                      height: 10,
                      color: Colors.grey[350], // Lighter shade for subtitle
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Status Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 80,
                  height: 10,
                  color: Colors.grey[400], // Medium grey for status text
                ),
                Container(
                  width: 80,
                  height: 20,
                  color: Colors.grey[350], // Lighter shade for status box
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Schedule and Time
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey[300], // Consistent grey for icons
                  child: Icon(Icons.calendar_month, color: Colors.grey[400]), // Icon color matches layout
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 10,
                      color: Colors.grey[400], // Medium grey for larger text
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 60,
                      height: 10,
                      color: Colors.grey[350], // Slightly lighter for variation
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Service Provider Information
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey[350], // Slightly darker for service provider
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 10,
                      color: Colors.grey[400], // Medium grey for provider name
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 60,
                      height: 10,
                      color: Colors.grey[350], // Light grey for details
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.grey[400], // Distinct grey for action button
                  ),
                  height: 40,
                  width: 100,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
