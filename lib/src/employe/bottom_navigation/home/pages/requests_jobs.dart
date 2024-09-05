import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:metrogeniusapp/bloc/order_summary/order_summary_bloc_bloc.dart';
import 'package:metrogeniusapp/bloc/worker/get_works/fetch_available_works_bloc.dart';
import 'package:metrogeniusapp/src/employe/bottom_navigation/home/pages/filtered_requests.dart';
import 'package:metrogeniusapp/src/user/screens/Logins/users/login_user.dart';
import 'package:metrogeniusapp/utils/colors.dart';
import 'package:metrogeniusapp/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class WorkRequests extends StatelessWidget {
  const WorkRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider(
          create: (context) => FetchAvailableWorksBloc()..add(FetchJobsData()),
          child:
              BlocConsumer<FetchAvailableWorksBloc, FetchAvailableWorksState>(
            listener: (context, state) {
             
            },
            builder: (context, state) {
               if (state is FetchAvailableWorksLoading) {
               return Center(
                  child: EmployeRequestsShimmer(),
                );
              }
              if (state is FetchAvailableWorksLoaded) {
                if(state.data.isEmpty){
                return  Center(child: Text('No work requests at the moment'),);
                }
                
                final documents = state.data as List<QueryDocumentSnapshot<Map<String, dynamic>>>;
                final requests = documents.map((doc) => doc.data()).toList();
                
                return GroupedRequestsWidget(requests: requests);
              }
            
              return Container(
                child: Center(child: CupertinoActivityIndicator()),
              );
            },
          ),
        ),
      ),
    );
  }
}

class EmployeRequests extends StatelessWidget {

  String dateTime;
  String seriveType;
  String serviceTitile;
  String requestTime;
  String id;
  String adress;
  EmployeRequests({
    required this.id,
    required this.adress,
    required this.dateTime,
    required this.seriveType,

    required this.serviceTitile,
    required this.requestTime,
    super.key,
  });

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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  seriveType,
                  style: TextStyle(color: Colors.black),
                ),
                    Text(
                  formattedTime,
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
            Text(dateTime),
            Text(serviceTitile),
            Text(adress),
            AppConstants.kheight20,
            GestureDetector(
                onTap: ()async {
                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                  String? employecode=await prefs.getString('EmployeAssigned');
                  FirebaseFirestore.instance
                                .collectionGroup("UserOrders")
                                .where('Id', isEqualTo:id)
                                .get()
                                .then((QuerySnapshot) {
                              for (var document in QuerySnapshot.docs) {
                                document.reference.update({
                                  'WorkerId': employecode,
                                  'RequestStatus':
                                      RequestStatus.accepted.toString(),
                                });
                              }
                              print('data changed');
                            });
                                 },
                child: LoginContainer(
                  content: 'Accept',
                )),
            AppConstants.kheight5
          ],
        ),
      ),
    );
  }
}

class EmployeRequestsShimmer extends StatelessWidget {
  const EmployeRequestsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100,
                  height: 15,
                  color: Colors.grey[200],  // Slightly darker shade
                ),
                Container(
                  width: 60,
                  height: 15,
                  color: Colors.grey[300],  // Base shade
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 15,
              color: Colors.grey[350],  // Another slight variation
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 15,
              color: Colors.grey[300],  // Base shade
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 15,
              color: Colors.grey[250],  // Slightly different
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[200],  // Different shade for button
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
