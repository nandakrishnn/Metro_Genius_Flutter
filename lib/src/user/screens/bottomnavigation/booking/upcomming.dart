import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusapp/bloc/get_booked_works/get_booked_works_user_bloc.dart';
import 'package:metrogeniusapp/src/user/screens/bottomnavigation/booking/refactored_upcomming.dart';
import 'package:metrogeniusapp/src/user/screens/bottomnavigation/booking/shim_upcomming.dart';

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
          if(state is GetBookedWorksUserLoading){
            return Center(child: UpcommingUserBookingShimmer());
          }
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
                          orderId: data[index]['Id'],
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
          return SizedBox(
            child:Center(child: CupertinoActivityIndicator(),)
          );
        },
      ),
    ));
  }
}
