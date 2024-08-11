import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusapp/animations/route_animations.dart';
import 'package:metrogeniusapp/bloc/get_adress_user/get_user_adresses_bloc.dart';
import 'package:metrogeniusapp/bloc/order_summary/order_summary_bloc_bloc.dart';
import 'package:metrogeniusapp/services/adress/address_service.dart';
import 'package:metrogeniusapp/src/user/screens/Logins/users/login_user.dart';

import 'package:metrogeniusapp/src/user/screens/home/sub_catgeories/widgets/adress_selector.dart';
import 'package:metrogeniusapp/utils/colors.dart';
import 'package:metrogeniusapp/utils/constants.dart';

class SummaryBooking extends StatelessWidget {
  final data;
  final String selectedDay;
  final String catgeoryName;
  final String? selectedTime;
  // final String selectedCheckboxes;
  final ValueNotifier<String?> selectedCheckboxNotifier;
  SummaryBooking(
      {super.key,
      this.data,
     required this.selectedDay,
      this.selectedTime,
      required this.selectedCheckboxNotifier,required this.catgeoryName});

  @override
  Widget build(BuildContext context) {
    print(catgeoryName);
    context.read<OrderSummaryBlocBloc>().add(DescriptionChanges(data['CatDes']));
    context.read<OrderSummaryBlocBloc>().add(UserIdChanges(FirebaseAuth.instance.currentUser!.uid));
    context.read<OrderSummaryBlocBloc>().add(MachineServiceType(data['CatName']));
     context.read<OrderSummaryBlocBloc>().add(CatgeoryNameChnages(catgeoryName));
    context.read<OrderSummaryBlocBloc>().add(ServiceTitileChanges(selectedCheckboxNotifier.value!));


    
    return BlocConsumer<OrderSummaryBlocBloc, OrderSummaryBlocState>(
      
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Summary'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BlocProvider(
                    create: (context) =>
                        GetUserAdressesBloc(AddressServiceUser())
                          ..add(FetchDataAdress(
                              FirebaseAuth.instance.currentUser!.uid)),
                    child:AddressSelector()
                  ),
                  AppConstants.kheight20,
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppConstants.kheight10,
                          Text(
                            'Selected Service',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16, // Adjust text size
                              color: Colors.black87,
                            ),
                          ),
                          AppConstants.kheight10,
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  data['CatImage'],
                                  height: 80,
                                  width: 120,
                                  fit: BoxFit.cover, // Adjust the fit as needed
                                ),
                              ),
                              AppConstants.kwidth10,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    data['CatName'].toUpperCase(),
                                  ),
                                  AppConstants.kheight5,
                                  Text(
                                    '₹ ' + data['CatPrice'].toString(),
                                    style: TextStyle(
                                        color: AppColors.mainBlueColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  )
                                ],
                              )
                            ],
                          ),
                          AppConstants.kheight10,
                          Text(
                            data['CatDes'],
                            style: TextStyle(overflow: TextOverflow.ellipsis),
                          ),
                          Row(
                            children: [
                              Text(
                                '•',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              AppConstants.kwidth10,
                              Text(
                                selectedCheckboxNotifier.value!,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              
                            ],
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(230, 234, 255, 1.0)),
                    height: 200,
                    width: double.infinity,
                  ),
                  AppConstants.kheight20,
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white,
                          Colors.grey.shade100
                        ], // Subtle gradient
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius:
                          BorderRadius.circular(16), // Rounded corners
                      border: Border.all(
                          color: AppColors.greyColor.withOpacity(0.2),
                          width: 1.5), // Subtle border
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1), // Shadow color
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Payment Summary',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16, // Adjust text size
                              color: Colors.black87,
                            ),
                          ),
                          AppConstants.kheight20,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextSummaryPage(
                                heading: 'Item Total',
                              ),
                              Text('₹' + data['CatPrice'].toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16, // Adjust text size
                                    color: Colors.black87,
                                  ))
                            ],
                          ),
                          AppConstants.kheight10,
                          DetailsPaymentSummary(
                            item: 'Discount',
                            price: 0,
                          ),
                          AppConstants.kheight10,
                          DetailsPaymentSummary(
                            item: 'Service Fee',
                            price: '₹50',
                          ),
                          AppConstants.kheight40,
                          DetailsPaymentSummary(
                            item: 'Grand Total',
                            price: '₹' + (data['CatPrice'] + 50).toString(),
                          ),
                          AppConstants.kheight20,
                          GestureDetector(
                              onTap: () {
                               
                                 context.read<OrderSummaryBlocBloc>().add(CreateAtChnages(DateTime.now().toString()));
                                 context.read<OrderSummaryBlocBloc>().add(WorkerIdChnages(''));
                                  context.read<OrderSummaryBlocBloc>().add(DateTimeChnages(selectedDay!));
                                 context.read<OrderSummaryBlocBloc>().add(TotalPriceChnages(int.parse( (data['CatPrice'] + 50).toString())));
                                     context.read<OrderSummaryBlocBloc>().add(DiscountChnages(0));
                                     context.read<OrderSummaryBlocBloc>().add(FormSubmit());

                              },
                              child: LoginContainer(
                                content: 'Pay   ' +
                                    '₹' +
                                    (data['CatPrice'] + 50).toString(),
                              ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class DetailsPaymentSummary extends StatelessWidget {
  String? item;
  dynamic price;
  DetailsPaymentSummary({
    this.item,
    this.price,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextSummaryPage(
          heading: item,
        ),
        Text(price.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16, // Adjust text size
              color: Colors.black87,
            ))
      ],
    );
  }
}

class TextSummaryPage extends StatelessWidget {
  String? heading;
  TextSummaryPage({
    this.heading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(heading!,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16, // Adjust text size
          color: Colors.black87,
        ));
  }
}
