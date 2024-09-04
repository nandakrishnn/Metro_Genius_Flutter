import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimelineCalendar extends StatelessWidget {
  final void Function(DateTime selectedDate) onDateChange;

  const TimelineCalendar({super.key, required this.onDateChange});

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();

    return EasyDateTimeLine(
      initialDate: today, // Start from today's date
      onDateChange: (selectedDate) {
        onDateChange(selectedDate);
      },
      headerProps: const EasyHeaderProps(
        showHeader: false,
        monthPickerType: MonthPickerType.switcher,
        dateFormatter: DateFormatter.fullDateDMY(),
      ),
      dayProps: EasyDayProps(
        inactiveDayStyle: DayStyle(
          dayNumStyle: TextStyle(color: Colors.black), // Make the date color visible
          dayStrStyle: TextStyle(color: Colors.black), // Make the day name color visible
        ),
        activeDayStyle: DayStyle(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(62, 91, 185, 1),
                        Color.fromRGBO(44, 63, 105, 1),
              ],
            ),
          ),
          dayNumStyle: TextStyle(color: Colors.white), // Visible color for active date number
          dayStrStyle: TextStyle(color: Colors.white), // Visible color for active day name
        ),
        dayStructure: DayStructure.dayStrDayNum, // Adjust this if needed
      ),
    );
  }
}
