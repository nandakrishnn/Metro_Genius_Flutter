import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:metrogeniusapp/bloc/worker/get_works/fetch_available_works_bloc.dart';

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
            return Center(child: Text('Details are being fetched'));
          },  
        ),
      ),
    );
  }
}



class EmployeRequests3 extends StatelessWidget {
  final String dateTime;
  final String seriveType;
  final String serviceTitile;
  final String requestTime;
  final String id;
  final String adress;

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
    // Parse the requestTime to DateTime
    DateTime parsedDateTime = DateTime.parse(requestTime);

    // Format the time as 'h:mm a'
    String formattedTime = DateFormat('h:mm a').format(parsedDateTime);

    // Format the date as 'dd-MMMM-yyyy, EEEE' (e.g., 22-June-2023, Saturday)
    String formattedDate = DateFormat('dd-MMMM-yyyy, EEEE').format(parsedDateTime);

    // Get today's date
    DateTime today = DateTime.now();
    String todayFormatted = DateFormat('dd-MMMM-yyyy').format(today);

    // Determine if the request date is today, tomorrow, or a past date
    String dateStatus;
    if (formattedDate.startsWith(todayFormatted)) {
      dateStatus = "Today";
    } else if (formattedDate.startsWith(DateFormat('dd-MMMM-yyyy').format(today.add(Duration(days: 1))))) {
      dateStatus = "Tomorrow";
    } else {
      dateStatus = formattedDate;
    }

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
        color: Colors.white, // Use a color that fits your design
      ),
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
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Text(
                  formattedTime,
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              dateStatus,
              style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold), // Highlight today or tomorrow
            ),
            SizedBox(height: 4),
            Text(
              serviceTitile,
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              adress,
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
