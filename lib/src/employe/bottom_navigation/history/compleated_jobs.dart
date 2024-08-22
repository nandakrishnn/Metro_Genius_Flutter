import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:metrogeniusapp/bloc/worker/get_works/fetch_available_works_bloc.dart';
import 'package:metrogeniusapp/src/user/screens/Logins/users/login_user.dart';
import 'package:metrogeniusapp/utils/colors.dart';
import 'package:metrogeniusapp/utils/constants.dart';

class HistoryWorker extends StatelessWidget {
  const HistoryWorker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Work History'),
      ),
      body: BlocProvider(
        create: (context) =>
            FetchAvailableWorksBloc()..add(FetchCompleatedJobsData()),
        child: BlocConsumer<FetchAvailableWorksBloc, FetchAvailableWorksState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is FetchAvailableWorksLoading) {
              Center(
                child: CupertinoActivityIndicator(),
              );
            } else if (state is FetchAvailableWorksLoadingFailure) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Error: ')));
            }

            if (state is FetchAvailableWorksLoaded) {
              if (state.data.isEmpty) {
                return Center(child: Text('No completed works found.'));
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      final data = state.data;

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: EmployeRequests3(
                          id: data[index]['Id'],
                          requestTime: data[index]['CreateAt'],
                          serviceTitile: data[index]['ServiceTitle'],
                          seriveType: data[index]['ServiceType'],
                          dateTime: data[index]['DateTime'],
                          adress: data[index]['AddressLine1'],
                        ),
                      );
                    }),
              );
            }
            return Center(child: Text('Something went wrong'));
          },
        ),
      ),
    );
  }
}

class EmployeRequests3 extends StatelessWidget {
  String dateTime;
  String seriveType;
  String serviceTitile;
  String requestTime;
  String id;
  String adress;
  EmployeRequests3({
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
          
         
          ],
        ),
      ),
    );
  }
}
