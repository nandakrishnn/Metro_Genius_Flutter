import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusapp/bloc/payment_user/payment_user_order_bloc.dart';
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
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (BuildContext context) {
      return BlocProvider(
        create: (_) => PaymentUserOrderBloc()..add(FetchUpiAppsEvent()),
        child: BlocBuilder<PaymentUserOrderBloc, UpiPaymentState>(
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Column(
              mainAxisSize: MainAxisSize.min,
                children: [
                  if (state is UpiAppsLoading)
                    const Center(child: CircularProgressIndicator())
                  else if (state is UpiAppsFetched)
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 300, // Adjust this height as needed
                      ),
                      child: Column(
                        children: [
                    
                          Expanded(
                            child: ListView.builder(
                                            
                              itemCount: state.apps.length,
                              itemBuilder: (context, index) {
                                final app = state.apps[index];
                                return ListTile(
                                  title: Text(app.name),
                                  leading: Image.memory(app.icon),
                                  onTap: () {
                                    context.read<PaymentUserOrderBloc>().add(
                                          InitiateUpiPaymentEvent(
                                            upiApp: app,
                                            receiverUpiId: receiverUpiId,
                                            receiverName: receiverName,
                                            transactionRefId: transactionRefId,
                                            amount: amount,
                                            transactionNote: transactionNote,
                                          ),
                                        );
                                    Navigator.pop(context); // Close the bottom sheet
                                  },
                                );
                              },
                            ),
                          ),
                                Text('djkfbdshgfsd'),
                                AppConstants.kheight40
                        ],
                      ),
                    )
                  else if (state is UpiPaymentLoading)
                    const Center(child: CircularProgressIndicator())
                  else if (state is UpiPaymentSuccess)
                    Center(
                      child: Text('Payment Success: ${state.response.transactionId}'),
                    )
                  else if (state is UpiPaymentError)
                    Center(child: Text('Error: ${state.error}'))
                  else
                    Container(),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
