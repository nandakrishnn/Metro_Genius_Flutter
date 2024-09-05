import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:metrogeniusapp/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LineChartGraphWidget extends StatelessWidget {
  const LineChartGraphWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<DateTime, int>>(
      future: fetchCompletedJobsByDay(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading data'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No completed jobs data available'));
        }

        final completedJobsByDay = snapshot.data!;
        final spots = _generateFlSpots(completedJobsByDay);
        
        // Find the maximum Y value to set maxY
        final maxYValue = (spots.map((spot) => spot.y).reduce((a, b) => a > b ? a : b)).ceil().toDouble();
        // Ensure maxY covers the highest expected label
        final maxY = (maxYValue + 2).toDouble(); // Adjust to cover labels like 2, 4, 6, 8
        final yInterval = 2.0;

        return Container(
          height: 350, // Adjusted height
          decoration: BoxDecoration(
            color: Colors.blue[700]!.withOpacity(.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 25, top: 25, left: 5, bottom: 10),
            child: Column(
              children: [
                Expanded(
                  child: LineChart(
                    LineChartData(
                      gridData: const FlGridData(show: false),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              final style = TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              );
                              // Display titles at intervals of yInterval
                              if (value % yInterval == 0) {
                                return SideTitleWidget(
                                  axisSide: meta.axisSide,
                                  child: Text('${value.toInt()}', style: style),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                            reservedSize: 28,
                            interval: yInterval, // Set interval for Y-axis labels
                          ),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              final DateFormat formatter = DateFormat('MMM dd');
                              final style = const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              );
                              final dateIndex = value.toInt();
                              if (dateIndex >= 0 && dateIndex < spots.length) {
                                final date = completedJobsByDay.keys.elementAt(dateIndex);
                                return SideTitleWidget(
                                  axisSide: meta.axisSide,
                                  space: 4,
                                  child: Text(formatter.format(date), style: style),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                            reservedSize: 28,
                            interval: 1, // Keep labels readable
                          ),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      minX: 0,
                      maxX: spots.length.toDouble() - 1,
                      minY: 0,
                      maxY: maxY, // Ensure maxY covers expected labels
                      lineBarsData: [
                        LineChartBarData(
                          spots: spots,
                          isCurved: true,
                          barWidth: 3,
                          isStrokeCapRound: true,
                          dotData: const FlDotData(show: true),
                          color: AppColors.mainBlueColor.withOpacity(0.6),
                          belowBarData: BarAreaData(
                            show: true,
                            color: AppColors.mainBlueColor.withOpacity(0.2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8), // Space between chart and text
                Text(
                  'Number of works per day',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<FlSpot> _generateFlSpots(Map<DateTime, int> completedJobsByDay) {
    final sortedEntries = completedJobsByDay.entries.toList()..sort((a, b) => a.key.compareTo(b.key));
    return List.generate(
      sortedEntries.length,
      (index) => FlSpot(index.toDouble(), sortedEntries[index].value.toDouble()),
    );
  }

  Future<Map<DateTime, int>> fetchCompletedJobsByDay() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? workerId = prefs.getString('EmployeAssigned');
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collectionGroup('UserOrders')
        .where('WorkerId', isEqualTo: workerId)
        .where('RequestStatus', isEqualTo: 'RequestStatus.compleated')
        .get();

    Map<DateTime, int> completedJobsByDay = {};
    DateFormat customFormat = DateFormat('EEE, MMM dd - hh:mm a');

    for (var document in querySnapshot.docs) {
      String completionDateString = document['DateTime'];
      try {
        DateTime completionDate = customFormat.parse(completionDateString);
        DateTime dateOnly = DateTime(completionDate.year, completionDate.month, completionDate.day);

        if (completedJobsByDay.containsKey(dateOnly)) {
          completedJobsByDay[dateOnly] = completedJobsByDay[dateOnly]! + 1;
        } else {
          completedJobsByDay[dateOnly] = 1;
        }
      } catch (e) {
        print('Error parsing date: $completionDateString, Error: $e');
      }
    }

    return completedJobsByDay;
  }
}
