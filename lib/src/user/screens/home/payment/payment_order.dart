import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusapp/bloc/order_summary/order_summary_bloc_bloc.dart';
import 'package:metrogeniusapp/bloc/payment_user/payment_user_order_bloc.dart';
import 'package:metrogeniusapp/src/user/screens/Logins/users/login_user.dart';
import 'package:metrogeniusapp/src/user/screens/home/payment/animation_payment.dart';
import 'package:metrogeniusapp/src/user/screens/home/payment/listtile_payment.dart';
import 'package:metrogeniusapp/utils/colors.dart';
import 'package:metrogeniusapp/utils/constants.dart';

void showUpiAppsBottomSheet(
  BuildContext context, {
  required String receiverUpiId,
  required String receiverName,
  required String transactionRefId,
  required double amount,
  required String transactionNote,
}) {
  showModalBottomSheet(
    isDismissible: true,
    enableDrag: true,
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (BuildContext context) {
      return BlocProvider(
        create: (_) => PaymentUserOrderBloc()..add(FetchUpiAppsEvent()),
        child: BlocConsumer<PaymentUserOrderBloc, UpiPaymentState>(
          listener: (context, state) {
            if (state is UpiPaymentSuccess) {
              context
                  .read<OrderSummaryBlocBloc>()
                  .add(PaymentMeathod('Prepaid Through UPI'));
              context.read<OrderSummaryBlocBloc>().add(FormSubmit());
                 showBookingConfirmationDialog(context);
            }
          },
          builder: (context, state) {
            int? selectedIndex;

            return StatefulBuilder(
              builder: (context, setState) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * .8,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppConstants.kheight10,
                        Text(
                          'RECOMMENDED PAYMENT OPTIONS',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        AppConstants.kheight10,
                        Text(
                          'Please complete your payment for the service using one of the methods below.',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.greyColor.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        AppConstants.kheight20,
                        SelectableListTile(
                          onTap: () {
                            setState(() {
                              selectedIndex = -1;
                            });
                          },
                          title: 'Cash On Service',
                          isSelected: selectedIndex == -1,
                          leadingIcon: Icons.money_outlined,
                        ),
                        AppConstants.kheight15,
                        const Text(
                          'Pay Using UPI Apps',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        AppConstants.kheight10,
                        if (state is UpiAppsLoading)
                          const Center(child: CircularProgressIndicator())
                        else if (state is UpiAppsFetched)
                          Expanded(
                            child: ListView.builder(
                              itemCount: state.apps.length,
                              itemBuilder: (context, index) {
                                final app = state.apps[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(8),
                                    title: Text(app.name),
                                    leading: Image.memory(app.icon),
                                    selected: selectedIndex == index,
                                    selectedTileColor:
                                        AppColors.mainBlueColor.withOpacity(.3),
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = index;
                                      });
                                    },
                                  ),
                                );
                              },
                            ),
                          )
                        else if (state is UpiPaymentLoading)
                          const Center(child: CircularProgressIndicator())
                        else if (state is UpiPaymentError)
                          Center(child: Text('Error: ${state.error}')),
                        AppConstants.kheight20,
                        LoginContainer(
                          content:
                              selectedIndex == -1 ? 'Place Order' : 'Proceed',
                          ontap: () {
                            if (selectedIndex == -1) {
                              context
                                  .read<OrderSummaryBlocBloc>()
                                  .add(PaymentMeathod('Cash On Service'));
                              context
                                  .read<OrderSummaryBlocBloc>()
                                  .add(FormSubmit());

                              Navigator.pop(context);
                              showBookingConfirmationDialog(context);
                            } else if (selectedIndex != null &&
                                state is UpiAppsFetched) {
                              final selectedApp = state.apps[selectedIndex!];
                              context.read<PaymentUserOrderBloc>().add(
                                    InitiateUpiPaymentEvent(
                                      upiApp: selectedApp,
                                      receiverUpiId: receiverUpiId,
                                      receiverName: receiverName,
                                      transactionRefId: transactionRefId,
                                      amount: amount,
                                      transactionNote: transactionNote,
                                    ),
                                  );
                              Navigator.pop(context);
                            } else {}
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      );
    },
  );
}
