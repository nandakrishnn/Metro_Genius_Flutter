import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusapp/services/user/user_services.dart';
import 'package:metrogeniusapp/src/user/screens/bottomnavigation/booking/search.dart';
import 'package:metrogeniusapp/src/user/screens/home/rating/star_widget.dart';
import 'package:metrogeniusapp/utils/colors.dart';
import '../../../../../bloc/add_ratings_user/ratings_user_bloc.dart';
import '../../../../../utils/constants.dart';

class HistoryUserBookingWidget extends StatefulWidget {
  final int? index;
  final String? userId;
  final String? catgeoryName;
  final String? subCategoryName;
  final String? time;
  final String? workerId;
  final String? status;
  final String? categoryImage;

  const HistoryUserBookingWidget({
    this.index,
    this.userId,
    this.categoryImage,
    this.catgeoryName,
    this.status,
    this.subCategoryName,
    this.time,
    this.workerId,
    super.key,
  });

  @override
  _HistoryUserBookingWidgetState createState() =>
      _HistoryUserBookingWidgetState();
}

class _HistoryUserBookingWidgetState extends State<HistoryUserBookingWidget> {
  bool _showRatingContainer = false;
  bool _isReviewSubmitted = false;

  @override
  void initState() {
    super.initState();
    chcekUserAlreadyRated(widget.userId!, widget.subCategoryName!, widget.index!);
  }

  @override
  Widget build(BuildContext context) {
    context.read<RatingsUserBloc>().add(UserIdChanges(widget.userId!));
    context.read<RatingsUserBloc>().add(CatgeoryType(widget.subCategoryName!));
    
    // Determine if the order should be marked as cancelled
    bool isOrderCancelled = widget.workerId == '' || widget.status == 'RequestStatus.ordercancelled';

    return Container(
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
                backgroundImage: NetworkImage(widget.categoryImage!),
                radius: 35,
                backgroundColor: AppColors.greyColor,
              ),
              AppConstants.kwidth20,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.catgeoryName!),
                  Text(widget.subCategoryName!),
                ],
              ),
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
                    color: isOrderCancelled ? Colors.red : Colors.green,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      isOrderCancelled ? 'Cancelled' : 'Completed',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              AppConstants.kheight5,
              AppConstants.kwidth20,
              const CircleAvatar(
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
                  Text(widget.time!),
                  const Text(
                    'Schedule',
                    style: TextStyle(color: AppColors.greyColor),
                  ),
                ],
              ),
            ],
          ),
          AppConstants.kheight10,
          if (!isOrderCancelled) _buildServiceProviderSection(context),
          AppConstants.kheight10,
        ],
      ),
    );
  }

  Widget _buildServiceProviderSection(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<Map<String, dynamic>?>(
          future: AddressServiceUser.fetchEmployeeDetailsForUser(widget.workerId!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error fetching employee details'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return SearchingWidget(orderId: '');
            } else {
              final employeeData = snapshot.data!;
              return Row(
                children: [
                  AppConstants.kheight5,
                  AppConstants.kwidth20,
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(employeeData['ApplicantImage']),
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
                  if (!_isReviewSubmitted)
                    Padding(
                      padding: const EdgeInsets.only(right: 7),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _showRatingContainer = !_showRatingContainer;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: AppColors.mainBlueColor,
                          ),
                          height: 40,
                          width: 100,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.star, color: Colors.amber),
                              AppConstants.kwidth5,
                              Text(
                                "Rating",
                                style: TextStyle(color: Colors.white),
                              ),
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
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: _showRatingContainer ? 180 : 0,
          child: SingleChildScrollView(
            child: _buildRatingContainer(),
          ),
        ),
        if (_isReviewSubmitted)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Review Submitted",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildRatingContainer() {
    return BlocConsumer<RatingsUserBloc, RatingsUserState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Rate the Service",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppConstants.kheight5,
                StarRatingWidget(),
                AppConstants.kheight5,
                const Text(
                  "Leave a comment",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                AppConstants.kheight5,
                TextField(
                  onChanged: (value) => context.read<RatingsUserBloc>().add(RatingDescritpion(value)),
                  maxLines: 2,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Write your comments here...',
                  ),
                ),
                AppConstants.kheight10,
                ElevatedButton(
                  style: ButtonStyle(
                     backgroundColor: WidgetStateProperty.all<Color>(AppColors.mainBlueColor), 
                  ),
                  onPressed: () {
                    setState(() {
                      _showRatingContainer = false;
                      _isReviewSubmitted = true;
                    });
                  },
                  child: const Text("Submit Review",style: TextStyle(color: AppColors.primaryColor),),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void chcekUserAlreadyRated(String userId, String catgeoryName, int index) {
    FirebaseFirestore.instance
        .collection('user')
        .doc(userId)
        .collection('bookinghistory')
        .where('category', isEqualTo: catgeoryName)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        setState(() {
          _isReviewSubmitted = true;
        });
      }
    }).catchError((error) {
      print('Error checking if user already rated: $error');
    });
  }
}


class CancelWidget extends StatelessWidget {
  const CancelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Cancelled'),
    );
  }
}