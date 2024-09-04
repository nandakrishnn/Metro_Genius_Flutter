
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:metrogeniusapp/animations/route_animations.dart';
import 'package:metrogeniusapp/bloc/order_summary/order_summary_bloc_bloc.dart';
import 'package:metrogeniusapp/bloc/worker/get_works/fetch_available_works_bloc.dart';
import 'package:metrogeniusapp/src/employe/bottom_navigation/home/pages/chat_employe.dart';
import 'package:metrogeniusapp/src/employe/bottom_navigation/home/pages/shim_upcomming.dart';
import 'package:redacted/redacted.dart';
import 'package:metrogeniusapp/utils/colors.dart';
import 'package:metrogeniusapp/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';





class UpCommingWorks extends StatelessWidget {
  const UpCommingWorks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider(
          create: (context) =>
              FetchAvailableWorksBloc()..add(FetchAcceptedJobsData()),
          child: BlocConsumer<FetchAvailableWorksBloc, FetchAvailableWorksState>(
            listener: (context, state) {
          
            },
            builder: (context, state) {
              if (state is FetchAvailableWorksLoading) {
            
                return const Center(
                  child: EmployeRequests2Shimmer(),
                );
              }

              if (state is FetchAvailableWorksLoaded) {
                if (state.data.isEmpty) {
              
                  return const Center(child: Text('No Upcoming works'));
                }

              
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      final data = state.data;

                      return Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: EmployeRequests2(
                          id: data[index]['Id'],
                          ontapChat: () async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            print(data[index]['Id']);
                            String? employecode =
                                await prefs.getString('EmployeAssigned');
                            print(employecode);

                            // Navigate to chat screen
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).push(
                              createRoute(
                                ChatScreenEmploye(
                                  userId: data[index]['UserId'],
                                  workerId: employecode!,
                                ),
                              ),
                            );
                          },
                          ontapCompleted: () async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            String? employecode =
                                await prefs.getString('EmployeAssigned');
                            FirebaseFirestore.instance
                                .collectionGroup("UserOrders")
                                .where('Id', isEqualTo: data[index]['Id'])
                                .get()
                                .then((QuerySnapshot) {
                              for (var document in QuerySnapshot.docs) {
                                document.reference.update({
                                  'WorkerId': employecode,
                                  'RequestStatus':
                                      RequestStatus.compleated.toString(),
                                });
                              }
                              print('data changed');
                            });
                          },
                          ontapStartWork: () {},
                          requestTime: data[index]['CreateAt'],
                          serviceTitile: data[index]['ServiceTitle'],
                          seriveType: data[index]['ServiceType'],
                          dateTime: data[index]['DateTime'],
                          adress: data[index]['AddressLine1'],
                        ),
                      );
                    },
                  ),
                );
              }

              // Default widget when no specific state is met
              return const Center();
            },
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
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: Offset(2, 2),
              blurRadius: 4,
              spreadRadius: 0,
            )
          ],
          color: AppColors.primaryColor),
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
                AppConstants.kheight10,
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
                            padding: EdgeInsets.symmetric(vertical:5,horizontal: 10),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: ontapStartWork,
                      child: Text('Start Work'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.amber, // Text color
                        splashFactory: InkRipple.splashFactory, // Ink effect
                          padding: EdgeInsets.symmetric(vertical:5,horizontal: 10), // Adjust padding here

                      ),
                    ),
                    ElevatedButton(
                      onPressed: ontapCompleted,
                      child: Text('Completed'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green, // Text color
                        splashFactory: InkRipple.splashFactory, 
                            padding: EdgeInsets.symmetric(vertical:5,horizontal: 10),
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
