import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metrogeniusapp/animations/route_animations.dart';
import 'package:metrogeniusapp/services/user/user_services.dart';
import 'package:metrogeniusapp/src/user/screens/bottomnavigation/booking/chat_screen_user.dart';
import 'package:metrogeniusapp/src/user/screens/bottomnavigation/booking/search.dart';
import 'package:metrogeniusapp/utils/colors.dart';
import 'package:metrogeniusapp/utils/constants.dart';




class UpcommingUserBookingWidget extends StatelessWidget {
  final String? orderId;
  final String? catgeoryName;
  final String? subCategoryName;
  final String? time;
  final String? workerId;
  final String? status;
  final String? categoryImage;

  UpcommingUserBookingWidget({
    this.orderId,
    this.categoryImage,
    this.catgeoryName,
    this.status,
    this.subCategoryName,
    this.time,
    this.workerId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print(workerId);
    String Status;
    if (status == 'RequestStatus.pending') {
      Status = 'Pending';
    } else {
      Status = 'Approved';
    }
    Color statusColor;
    if (status == 'RequestStatus.pending') {
      statusColor = Colors.blue.withOpacity(0.6);
    } else {
      statusColor = const Color.fromRGBO(127, 192, 156, .6); // Default color
    }
    return Container(
      height: 260,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.primaryColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.greyColor.withOpacity(0.2),
            offset: const Offset(0, 0),
            spreadRadius: 0.9,
            blurRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          AppConstants.kheight15,
          Row(
            children: [
              AppConstants.kwidth20,
              CircleAvatar(
                backgroundImage: NetworkImage(categoryImage!),
                radius: 35,
                backgroundColor: AppColors.greyColor,
              ),
              AppConstants.kwidth20,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(catgeoryName!),
                  Text(subCategoryName!),
                ],
              ),
              AppConstants.kheight15,
            ],
          ),
          AppConstants.kheight10,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Wrap(
              children: List.generate(50, (index) {
                return Container(
                  width: 4,
                  height: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  color: AppColors.greyColor,
                );
              }),
            ),
          ),
          AppConstants.kheight10,
          Row(
            children: [
              AppConstants.kwidth10,
              const Text(
                'Status',
                style: TextStyle(color: AppColors.greyColor, fontSize: 16),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 7),
                child: Container(
                  height: 35,
                  width: 100,
                  decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      Status,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              AppConstants.kheight5,
              AppConstants.kwidth20,
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.primaryColor,
                child: Icon(
                  Icons.calendar_month,
                  color: AppColors.greyColor,
                ),
              ),
              AppConstants.kwidth10,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(time!),
                  const Text(
                    'Schedule',
                    style: TextStyle(color: AppColors.greyColor),
                  ),
                ],
              )
            ],
          ),
          AppConstants.kheight10,
          Column(
            children: [
              if (workerId != null)
                FutureBuilder<Map<String, dynamic>?>(
                  future: AddressServiceUser.fetchEmployeeDetailsForUser(workerId!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Shimmer effect while loading
                      return const CupertinoActivityIndicator(); // Replace with the RedactedShimmerPlaceholder here
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text('Error fetching employee details'),
                      );
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      // final data=snapshot.data;
                      // String id=data!['Id'];
                      // print(i)
                      return SearchingWidget(orderId: orderId!,);
                    } else {
                      final employeeData = snapshot.data!;
                      print(employeeData);
                      return Row(
                        children: [
                          AppConstants.kheight5,
                          AppConstants.kwidth20,
                          CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                NetworkImage(employeeData['ApplicantImage']),
                            backgroundColor: AppColors.primaryColor,
                          ),
                          AppConstants.kwidth10,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(employeeData['ApplicantName'] ?? 'Unknown'),
                              const Text(
                                'Service Provider',
                                style: TextStyle(color: AppColors.greyColor),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 7),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(createRoute(
                                  ChatScreenUser(
                                    userId: FirebaseAuth.instance.currentUser!.uid,
                                    workerId: workerId!,
                                    employename: employeeData['ApplicantName'],
                                  ),
                                ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: AppColors.mainBlueColor,
                                ),
                                height: 40,
                                width: 100,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.chat_sharp,
                                      color: Colors.white,
                                    ),
                                    AppConstants.kwidth5,
                                    Text(
                                      "Chat",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
            ],
          ),
          AppConstants.kheight10
        ],
      ),
    );
  }
}

// Shimmer placeholder for redacted effect


