import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusapp/bloc/get_booked_works/get_booked_works_user_bloc.dart';
import 'package:metrogeniusapp/services/user/user_services.dart';
import 'package:metrogeniusapp/src/user/screens/bottomnavigation/booking/search.dart';
import 'package:metrogeniusapp/utils/colors.dart';
import 'package:metrogeniusapp/utils/constants.dart';

class UpComming extends StatelessWidget {
  const UpComming({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => GetBookedWorksUserBloc()
        ..add(FetchOrderSummaryUser(FirebaseAuth.instance.currentUser!.uid)),
      child: BlocConsumer<GetBookedWorksUserBloc, GetBookedWorksUserState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetBookedWorksUserLoaded) {
              
            final data = state.data;
            if(data.isEmpty){
            return  Center(child: Text('No Upcomming orders'),);
            }
            return Padding(
                padding: const EdgeInsets.only(
                    left: 0, right: 0, bottom: 0, top: 10),
                child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: UpcommingUserBookingWidget(
                          status: data[index]['RequestStatus'],
                          time: data[index]['DateTime'],
                          categoryImage: data[index]['CatImage'],
                          catgeoryName: data[index]['CategoryName'],
                          subCategoryName: data[index]['ServiceType'],
                          workerId: data[index]['WorkerId'],
                        ),
                      );
                    }));
          }
          return Container(
            child:Center(child: CupertinoActivityIndicator(),)
          );
        },
      ),
    ));
  }
}

class UpcommingUserBookingWidget extends StatelessWidget {
  String? catgeoryName;
  String? subCategoryName;
  String? time;
  String? workerId;
  String? status;

  String? categoryImage;

  UpcommingUserBookingWidget({
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
    if(status=='RequestStatus.pending'){
      Status='Pending';
    }else{
      Status='Approved';
    }
      Color statusColor;
     if (status == 'RequestStatus.pending') {
      statusColor = Colors.blue.withOpacity(0.6); 
    } else {
      statusColor = Color.fromRGBO(127, 192, 156, .6); // Default color
    }
    return Container(
      height: 260,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.primaryColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.greyColor
                .withOpacity(0.2), 
            offset: Offset(0, 0), 
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
                children: [Text(catgeoryName!), Text(subCategoryName!)],
              ),
              AppConstants.kheight15,
            ],
          ),
          AppConstants.kheight10,
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 15), // Indent from both edges
            child: Wrap(
              children: List.generate(50, (index) {
                return Container(
                  width: 4, 
                  height: 1, 
                  margin: EdgeInsets.symmetric(
                      horizontal: 2), // Space between dashes
                  color: AppColors.greyColor,
                );
              }),
            ),
          ),
          AppConstants.kheight10,
          Row(
            children: [
              AppConstants.kwidth10,
              Text(
                'Status',
                style: TextStyle(color: AppColors.greyColor, fontSize: 16),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 7),
                child: Container(
                  height: 35,
                  width: 100,
                  decoration: BoxDecoration(
                      color:statusColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(child: Text(Status,style: TextStyle(fontWeight: FontWeight.bold),)),
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
                  Text(
                    'Schedule',
                    style: TextStyle(color: AppColors.greyColor),
                  )
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
                  return Center(child: CupertinoActivityIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error fetching employee details'));
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return SearchingWidget();
                } else {
                  final employeeData = snapshot.data!;
                  
                  print(employeeData);
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
                          Text(
                            'Service Provider',
                            style: TextStyle(color: AppColors.greyColor),
                          ),
                        ],
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 7),
                        child: Container(
                          decoration: BoxDecoration(
                            
                            borderRadius: BorderRadius.circular(18),
                            color: AppColors.mainBlueColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.chat_sharp,color: Colors.white,),
                              AppConstants.kwidth5,
                              Text("Chat",style: TextStyle(color: Colors.white),)
                       
                            ],
                          ),
                          height: 40,
                          width: 100,
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
