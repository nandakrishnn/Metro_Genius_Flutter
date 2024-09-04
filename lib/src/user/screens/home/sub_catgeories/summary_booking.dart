import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusapp/bloc/get_adress_user/get_user_adresses_bloc.dart';
import 'package:metrogeniusapp/bloc/order_summary/order_summary_bloc_bloc.dart';
import 'package:metrogeniusapp/services/user/user_services.dart';
import 'package:metrogeniusapp/src/user/screens/Logins/users/login_user.dart';
import 'package:metrogeniusapp/src/user/screens/home/payment/payment_order.dart';

import 'package:metrogeniusapp/src/user/screens/home/sub_catgeories/widgets/adress_selector.dart';
import 'package:metrogeniusapp/src/user/screens/home/sub_catgeories/widgets/widgets_insidecategory.dart';
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
      required this.selectedCheckboxNotifier,
      required this.catgeoryName});

  @override
  Widget build(BuildContext context) {
    print(catgeoryName);
    context
        .read<OrderSummaryBlocBloc>()
        .add(DescriptionChanges(data['CatDes']));
    context
        .read<OrderSummaryBlocBloc>()
        .add(UserIdChanges(FirebaseAuth.instance.currentUser!.uid));
    context
        .read<OrderSummaryBlocBloc>()
        .add(MachineServiceType(data['CatName']));
    context.read<OrderSummaryBlocBloc>().add(CatgeoryNameChnages(catgeoryName));
    context
        .read<OrderSummaryBlocBloc>()
        .add(ServiceTitileChanges(selectedCheckboxNotifier.value!));

    return BlocConsumer<OrderSummaryBlocBloc, OrderSummaryBlocState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Summary'),
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
                      child: const AddressSelector()),
                  AppConstants.kheight20,
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromRGBO(230, 234, 255, 1.0)),
                    height: 200,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppConstants.kheight10,
                          const Text(
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
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    data['CatName'].toUpperCase(),
                                  ),
                                  AppConstants.kheight5,
                                  Text(
                                    '₹ ' + data['CatPrice'].toString(),
                                    style: const TextStyle(
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
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis),
                          ),
                          Row(
                            children: [
                              const Text(
                                '•',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              AppConstants.kwidth10,
                              Text(
                                selectedCheckboxNotifier.value!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
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
                                  style: const TextStyle(
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
                                context.read<OrderSummaryBlocBloc>().add(
                                    CreateAtChnages(DateTime.now().toString()));
                                context
                                    .read<OrderSummaryBlocBloc>()
                                    .add(WorkerIdChnages(''));
                                context
                                    .read<OrderSummaryBlocBloc>()
                                    .add(DateTimeChnages(selectedDay));
                                context.read<OrderSummaryBlocBloc>().add(
                                    TotalPriceChnages(int.parse(
                                        (data['CatPrice'] + 50).toString())));
                                context.read<OrderSummaryBlocBloc>().add(
                                    CategoryImageChanges(data['CatImage']));
                                context
                                    .read<OrderSummaryBlocBloc>()
                                    .add(DiscountChnages(0));
                                
                                showUpiAppsBottomSheet(
                                  context,
                                  receiverUpiId: 'unandakrishnan@okaxis',
                                  transactionRefId: '',
                                  amount: state.totalPrice.toDouble(),
                                  receiverName: 'Metrogenius.Pvt.Ltd',
                                  transactionNote: 'Payment',
                                );
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
