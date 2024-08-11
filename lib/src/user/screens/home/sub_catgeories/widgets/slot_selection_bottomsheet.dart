import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:metrogeniusapp/animations/route_animations.dart';
import 'package:metrogeniusapp/src/user/screens/Logins/users/login_user.dart';
import 'package:metrogeniusapp/src/user/screens/home/sub_catgeories/details_subcatgeory.dart';
import 'package:metrogeniusapp/src/user/screens/home/sub_catgeories/summary_booking.dart';
import 'package:metrogeniusapp/utils/colors.dart';
import 'package:metrogeniusapp/utils/constants.dart';

class SlotSelectionBottomSheet extends StatefulWidget {
  final data;
  final String catgeoryName;
  final List<String> timeSlots;
    // final List<String> selectedCheckboxes; 
 final ValueNotifier<String?> selectedCheckboxNotifier;
  const SlotSelectionBottomSheet({Key? key, required this.timeSlots,required this.data, required this.selectedCheckboxNotifier, required this.catgeoryName}) : super(key: key);

  @override
  _SlotSelectionBottomSheetState createState() => _SlotSelectionBottomSheetState();
}

class _SlotSelectionBottomSheetState extends State<SlotSelectionBottomSheet> {
  String? selectedDay;
  String? selectedTime;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * .86,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 10),
              child: const Text(
                'Select Date',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            AppConstants.kheight10,
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                'Your Service will take approx.2 hrs 20 mins',
                style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.greyColor, fontSize: 15),
              ),
            ),
            AppConstants.kheight20,
            DayContainerBottomSheet(
              selectedDay: selectedDay,
              onDaySelected: (day) {
                setState(() {
                  selectedDay = day;
                });
              },
            ),
            AppConstants.kheight20,
            const Divider(thickness: 1, endIndent: 6, indent: 6),
            AppConstants.kheight20,
            const Text('Time to Start the service',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            AppConstants.kheight20,
            TimeSelector(
              timeSlots: widget.timeSlots,
              selectedTime: selectedTime,
              onTimeSelected: (time) {
                setState(() {
                  selectedTime = time;
                });
              },
            ),
            AppConstants.kheight10,
            GestureDetector(
              onTap: (){
               
                if(selectedDay!=null&&selectedTime!=null){
 Navigator.of(context).push(createRoute(SummaryBooking(data: widget.data,selectedDay: getFormattedDateTime(),selectedTime: selectedTime,selectedCheckboxNotifier: widget.selectedCheckboxNotifier,catgeoryName: widget.catgeoryName,)));
                }
               
              },
              child: LoginContainer(content: 'Continue'))
          ],
        ),
      ),
    );
  }
String getFormattedDateTime() {
  if (selectedDay == null || selectedTime == null) return '';

  try {
    final dateFormat = DateFormat('yyyy-MM-dd'); // Match this format
    final date = dateFormat.parse(selectedDay!);
    final formattedDate = DateFormat('E, MMM dd').format(date);

    return '$formattedDate - $selectedTime';
  } catch (e) {
    print('Error formatting date: $e'); // Debug print
    return '';
  }
}


}