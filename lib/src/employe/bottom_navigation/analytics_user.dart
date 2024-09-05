import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart'; // for haptic feedback on selection
import 'package:animate_do/animate_do.dart';
import 'package:metrogeniusapp/animations/route_animations.dart';
import 'package:metrogeniusapp/bloc/order_summary/order_summary_bloc_bloc.dart';
import 'package:metrogeniusapp/bloc/worker/get_works/fetch_available_works_bloc.dart';
import 'package:metrogeniusapp/src/employe/bottom_navigation/calender_top.dart';
import 'package:metrogeniusapp/src/employe/bottom_navigation/graph_analytics.dart';
import 'package:metrogeniusapp/src/employe/bottom_navigation/home/pages/chat_employe.dart';
import 'package:metrogeniusapp/src/employe/bottom_navigation/text_analytics.dart';
import 'package:metrogeniusapp/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/constants.dart'; // For advanced animations

class AnalyticsWorker extends StatefulWidget {
  const AnalyticsWorker({super.key});

  @override
  _AnalyticsWorkerState createState() => _AnalyticsWorkerState();
}

class _AnalyticsWorkerState extends State<AnalyticsWorker> {
  DateTime? selectedDate;
  int numberOfWorks = 0;

  // Function to format the date to a simplified format
  String formatSelectedDate(DateTime date) {
    return DateFormat('EEE, MMM dd').format(date); // Format as 'Mon, Sep 02'
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Analytics',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        flexibleSpace: Container(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              FadeInUp(child: LineChartGraphWidget()),
              AppConstants.kheight20,
              FadeInUp(
                child: TimelineCalendar(
                  onDateChange: (date) {
                    setState(() {
                      selectedDate = date;
                    });

                    if (selectedDate != null) {
                      final formattedDate = formatSelectedDate(selectedDate!);
                      print('Selected date: $formattedDate');

                      // Trigger the event when a date is selected
                      BlocProvider.of<FetchAvailableWorksBloc>(context)
                          .add(FetchWorksByDate(formattedDate));
                    }
                  },
                ),
              ),
              BlocBuilder<FetchAvailableWorksBloc, FetchAvailableWorksState>(
                builder: (context, state) {
                  if (state is FetchAvailableWorksLoaded) {
                    numberOfWorks = state.data.length;

                    if (state.data.isEmpty) {
                      return const Center(
                        child: Text(
                          'No Works assigned for today',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      );
                    }
                    return Column(
                      children: [
                        AnimatedTextKitWidget(
                          text1: 'Welcome Worker',
                          text2: 'Total works today: $numberOfWorks',
                        ),
                        SlideInUp(
                          child: Container(
                            height: 400, // Height of the wheel
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListWheelScrollView.useDelegate(
                              itemExtent: 250, // Adjust this value as needed
                              diameterRatio:
                                  5.0, // Increase this value to flatten the wheel
                              perspective:
                                  0.005, // Subtle perspective for a smoother look
                              physics: const FixedExtentScrollPhysics(),
                              onSelectedItemChanged: (index) {
                                HapticFeedback.selectionClick();
                              },
                              childDelegate: ListWheelChildBuilderDelegate(
                                builder: (context, index) {
                                  final request = state.data[index];
                                  return ZoomIn(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: EmployeRequests2(
                                        ontapChat: () async {
                                          final SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          print(state.data[index]['Id']);
                                          String? employecode = await prefs
                                              .getString('EmployeAssigned');
                                          print(employecode);

                                          // Navigate to chat screen
                                          // ignore: use_build_context_synchronously
                                          Navigator.of(context).push(
                                            createRoute(
                                              ChatScreenEmploye(
                                                userId: state.data[index]
                                                    ['UserId'],
                                                workerId: employecode!,
                                              ),
                                            ),
                                          );
                                        },
                                        ontapCompleted: () async {
                                          final SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          String? employecode = await prefs
                                              .getString('EmployeAssigned');
                                          FirebaseFirestore.instance
                                              .collectionGroup("UserOrders")
                                              .where('Id',
                                                  isEqualTo: state.data[index]
                                                      ['Id'])
                                              .get()
                                              .then((QuerySnapshot) {
                                            for (var document
                                                in QuerySnapshot.docs) {
                                              document.reference.update({
                                                'WorkerId': employecode,
                                                'RequestStatus': RequestStatus
                                                    .compleated
                                                    .toString(),
                                              });
                                            }
                                            print('data changed');
                                          });
                                        },
                                        ontapStartWork: () {},
                                        id: request['Id'],
                                        adress: request['AddressLine1'],
                                        dateTime: request['DateTime'],
                                        seriveType: request['ServiceType'],
                                        serviceTitile: request['ServiceTitle'],
                                        requestTime: request['CreateAt'],
                                      ),
                                    ),
                                  );
                                },
                                childCount: state.data.length,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EmployeRequests2 extends StatelessWidget {
  String dateTime;
  String seriveType;
  String serviceTitile;
  String requestTime;
  String id;
  String adress;
  void Function()? ontapChat;
  void Function()? ontapStartWork;
  void Function()? ontapCompleted;
  EmployeRequests2(
      {required this.id,
      required this.adress,
      required this.dateTime,
      required this.seriveType,
      required this.serviceTitile,
      required this.requestTime,
      super.key,
      this.ontapChat,
      this.ontapCompleted,
      this.ontapStartWork});

  @override
  Widget build(BuildContext context) {
    DateTime parsedDateTime = DateTime.parse(requestTime);

    String formattedTime = DateFormat('h:mm a').format(parsedDateTime);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: Offset(2, 2),
            blurRadius: 4,
            spreadRadius: 0,
          )
        ],
      ),
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      seriveType,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      formattedTime,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                AppConstants.kheight5,
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 22,
                    ),
                    AppConstants.kwidth5,
                    Text(
                      dateTime,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ],
                ),
                AppConstants.kheight5,
                Row(
                  children: [
                    Icon(Icons.work_outline),
                    AppConstants.kwidth5,
                    Text(serviceTitile,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14)),
                  ],
                ),
                AppConstants.kheight5,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_city),
                    AppConstants.kwidth5,
                    Expanded(child: Text(adress)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: ontapChat,
                      child: Text('Chat'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppColors.mainBlueColor, // Text color
                        splashFactory: InkRipple.splashFactory, // Ink effect
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: ontapStartWork,
                      child: Text('Start Work'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.amber, // Text color
                        splashFactory: InkRipple.splashFactory, // Ink effect
                        padding: EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10), // Adjust padding here
                      ),
                    ),
                    ElevatedButton(
                      onPressed: ontapCompleted,
                      child: Text('Completed'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green, // Text color
                        splashFactory: InkRipple.splashFactory,
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        // Ink effect
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
