import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:metrogeniusapp/bloc/details_subcategory/details_sub_catgeory_bloc.dart';
import 'package:metrogeniusapp/src/user/screens/home/sub_catgeories/widgets/slot_selection_bottomsheet.dart';
import 'package:metrogeniusapp/src/user/screens/home/widgets/content_subcatgeory.dart';
import 'package:metrogeniusapp/src/user/screens/home/widgets/header_subcatgeory.dart';
import 'package:metrogeniusapp/src/user/widgets/custom_snackbar.dart';
import 'package:metrogeniusapp/utils/colors.dart';
import 'package:metrogeniusapp/utils/constants.dart';
import '../widgets/footer_subcategory.dart';

class InsideSubCatgeory extends StatelessWidget {
  final data;
  final String categoryType;
   final ValueNotifier<String?> selectedCheckboxNotifier = ValueNotifier<String?>(null);
   InsideSubCatgeory({super.key, this.data, required this.categoryType});

  @override
  Widget build(BuildContext context) {
    List<String> _generateTimeSlots() {
    List<String> timeSlots = [];
    DateTime startTime = DateTime(0, 1, 1, 8, 0); // Start at 8:00 AM
    DateTime endTime = DateTime(0, 1, 1, 18, 0); // End at 6:00 PM
    while (startTime.isBefore(endTime) || startTime == endTime) {
      String time = DateFormat('hh:mm a').format(startTime); // 12-hour format with AM/PM
      timeSlots.add(time);
      startTime = startTime.add(const Duration(minutes: 60));
    }
    return timeSlots;
  }
  List<String> timeSlots=_generateTimeSlots();
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final String userId = user?.uid ?? 'NO User ID';
    print(userId);
    Map<String, dynamic> dataMap = data.data() as Map<String, dynamic>;

    Map<String, bool> checkBoxData =
        (dataMap['CheckBox'] as Map<String, dynamic>?)
                ?.map((key, value) => MapEntry(key, value as bool)) ??
            {};

    List<String> trueKeys = checkBoxData.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: BlocConsumer<DetailsSubCatgeoryBloc, DetailsSubCatgeoryState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Stack(
            children: [
              SubCatgeoryViewHeader(data: data),
              SubCategoryViewContent(data: data, trueKeys: trueKeys,selectedCheckboxNotifier: selectedCheckboxNotifier,),
              
              SubCategoryViewFooter(
                bookNow: () {
                final selectedCheckbox = selectedCheckboxNotifier.value;
                  if (selectedCheckbox != null) {
                    SlotSelectionUserBottomModel(context, timeSlots, selectedCheckbox);
                  } else {
                    customSnack('Select an option', 'You must select an option to continue', Icon(Icons.error), Colors.black);
                  }
                

            
                },
                cartNow: () {},
                data: data,
                state: state,
              )
            ],
          );
        },
      ),
    );
  }

  Future<dynamic> SlotSelectionUserBottomModel(BuildContext context, List<String> timeSlots,String selectedCheckbox) {
    return showModalBottomSheet(
                  backgroundColor: AppColors.primaryColor,
                  isScrollControlled: true,
                  enableDrag: true,
                  isDismissible: true,
                  context: context,
                  builder: (context) {
                    return  SlotSelectionBottomSheet(timeSlots: timeSlots,data: data,selectedCheckboxNotifier: selectedCheckboxNotifier,catgeoryName: categoryType,);
                  },
                );
  }
}
class TimeSelector extends StatelessWidget {
  final List<String> timeSlots;
  final String? selectedTime;
  final ValueChanged<String> onTimeSelected;

  const TimeSelector({
    Key? key,
    required this.timeSlots,
    required this.selectedTime,
    required this.onTimeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 2,
        ),
        itemCount: timeSlots.length,
        itemBuilder: (context, index) {
          String timeSlot = timeSlots[index];
          bool isSelected = selectedTime == timeSlot;

          return GestureDetector(
            onTap: () => onTimeSelected(timeSlot),
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? AppColors.mainBlueColor : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.mainBlueColor),
              ),
              child: Center(
                child: Text(
                  timeSlot,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DayContainerBottomSheet extends StatelessWidget {
  final String? selectedDay;
  final ValueChanged<String> onDaySelected;

  const DayContainerBottomSheet({
    Key? key,
    required this.selectedDay,
    required this.onDaySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(3, (index) {
        DateTime date = DateTime.now().add(Duration(days: index + 1));
        String day = DateFormat('yyyy-MM-dd').format(date); // Ensure format
        bool isSelected = selectedDay == day;

        return GestureDetector(
          onTap: () => onDaySelected(day),
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? AppColors.mainBlueColor : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.mainBlueColor),
              ),
              height: 80,
              width: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(DateFormat('EEEE').format(date),
                      style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
                  AppConstants.kheight10,
                  Text(DateFormat('dd').format(date),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: isSelected ? Colors.white : Colors.black)),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

