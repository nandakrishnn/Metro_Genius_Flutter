import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:metrogeniusapp/bloc/get_booked_works/get_booked_works_user_bloc.dart';
import 'package:metrogeniusapp/src/user/screens/bottomnavigation/booking/history_refactored.dart';
import 'package:metrogeniusapp/src/user/screens/bottomnavigation/booking/shim_history.dart';


class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => GetBookedWorksUserBloc()
        ..add(FetchOrderSummaryUserHistory(FirebaseAuth.instance.currentUser!.uid)),
      child: BlocConsumer<GetBookedWorksUserBloc, GetBookedWorksUserState>(
        listener: (context, state) {},
        builder: (context, state) {
          if(state is GetBookedWorksUserLoading){
            return const Center(child: HistoryUserBookingShimmer());
            
          }
          if (state is GetBookedWorksUserLoaded) {
         
          var data = state.data;

             
              final DateFormat dateFormat = DateFormat('EEE, MMM dd - hh:mm a');

            
              data.sort((a, b) {
             
                DateTime dateA = dateFormat.parse(a['DateTime']);
                DateTime dateB = dateFormat.parse(b['DateTime']);
                return dateB.compareTo(dateA); 
              });


            if(data.isEmpty){
              return Center(child: Text('No History'),);
            }
            return Padding(
                padding: const EdgeInsets.only(
                    left: 0, right: 0, bottom: 0, top: 10),
                child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: HistoryUserBookingWidget(
                          index: index,
                          status: data[index]['RequestStatus'],
                          time: data[index]['DateTime'],
                          categoryImage: data[index]['CatImage'],
                          catgeoryName: data[index]['CategoryName'],
                          subCategoryName: data[index]['ServiceType'],
                          workerId: data[index]['WorkerId'],
                          userId: FirebaseAuth.instance.currentUser!.uid,
                        ),
                      );
                    }));
          }
          return Container(
              child: const Center(
            child: CupertinoActivityIndicator(),
          ));
        },
      ),
    ));
  }
}
