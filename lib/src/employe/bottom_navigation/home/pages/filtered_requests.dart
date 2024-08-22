import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:metrogeniusapp/src/employe/bottom_navigation/home/pages/requests_jobs.dart';
import 'package:metrogeniusapp/utils/colors.dart';

class GroupedRequestsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> requests;

  GroupedRequestsWidget({required this.requests});

  @override
  Widget build(BuildContext context) {
    final groupedRequests = _groupRequestsByDate(requests);

    return ListView(
      children: groupedRequests.entries.map((entry) {
        // Determine if the current entry is "Today"
        final isToday = entry.key == 'Today';

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                entry.key,
                style: isToday
                    ? TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: AppColors.greyColor, // Example customization for "Today"
                      )
                    : TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
              ),
            ),
            ...entry.value.map((request) {
              return EmployeRequests(
                id: request['Id'],
                requestTime: request['CreateAt'],
                serviceTitile: request['ServiceTitle'],
                seriveType: request['ServiceType'],
                dateTime: request['DateTime'],
                adress: request['AddressLine1'],
              );
            }).toList(),
          ],
        );
      }).toList(),
    );
  }

  Map<String, List<Map<String, dynamic>>> _groupRequestsByDate(List<Map<String, dynamic>> requests) {
    final groupedRequests = <String, List<Map<String, dynamic>>>{};

    for (var request in requests) {
      final requestTime = DateTime.parse(request['CreateAt']);
      final today = DateTime.now();
      final yesterday = today.subtract(Duration(days: 1));

      String formattedDate;
      if (_isSameDay(requestTime, today)) {
        formattedDate = 'Today';
      } else if (_isSameDay(requestTime, yesterday)) {
        formattedDate = 'Yesterday';
      } else {
        formattedDate = DateFormat('yyyy-MM-dd').format(requestTime);
      }

      if (groupedRequests.containsKey(formattedDate)) {
        groupedRequests[formattedDate]!.add(request);
      } else {
        groupedRequests[formattedDate] = [request];
      }
    }

    return groupedRequests;
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
