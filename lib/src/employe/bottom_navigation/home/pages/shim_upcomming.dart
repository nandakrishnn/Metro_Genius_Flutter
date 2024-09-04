import 'package:flutter/material.dart';
import 'package:metrogeniusapp/utils/colors.dart';
import 'package:redacted/redacted.dart';

class EmployeRequests2Shimmer extends StatelessWidget {
  const EmployeRequests2Shimmer({super.key});

  @override
  Widget build(BuildContext context) {
    // Creating a dummy version of the EmployeRequests2 widget with redacted placeholders
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: const Offset(2, 2),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
        color: AppColors.primaryColor,
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Redacted placeholder for service type text
              Container(
                height: 16,
                width: 120,
                color: Colors.grey[400], // Placeholder color
              ).redacted(context: context, redact: true),
              
              // Redacted placeholder for formatted time text
              Container(
                height: 16,
                width: 50,
                color: Colors.grey[300], // Placeholder color
              ).redacted(context: context, redact: true),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 22,
                color: Colors.grey[400], // Matching the redacted style
              ),
              const SizedBox(width: 5),
              // Redacted placeholder for date text
              Container(
                height: 16,
                width: 100,
                color: Colors.grey[350], // Placeholder color
              ).redacted(context: context, redact: true),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Icon(
                Icons.work_outline,
                color: Colors.grey[400],
              ),
              const SizedBox(width: 5),
              // Redacted placeholder for service title text
              Container(
                height: 16,
                width: 150,
                color: Colors.grey[400], // Placeholder color
              ).redacted(context: context, redact: true),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.location_city,
                color: Colors.grey[400],
              ),
              const SizedBox(width: 5),
              // Redacted placeholder for address text
              Expanded(
                child: Container(
                  height: 16,
                  color: Colors.grey[350], // Placeholder color
                ).redacted(context: context, redact: true),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Redacted placeholder for chat button
              ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.grey[400],
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                ),
                child: Text(''),
              ).redacted(context: context, redact: true),
              
              // Redacted placeholder for start work button
              ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.grey[400],
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                ),
             child: Text(''),
              ).redacted(context: context, redact: true),
              
              // Redacted placeholder for completed button
              ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.grey[400],
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                ),
             child: Text(''),
              ).redacted(context: context, redact: true),
            ],
          ),
        ],
      ),
    );
  }
}
