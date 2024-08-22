import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:upi_india/upi_india.dart';
part 'payment_user_order_event.dart';
part 'payment_user_order_state.dart';


class PaymentUserOrderBloc extends Bloc<UpiPaymentEvent, UpiPaymentState> {
    final UpiIndia _upiIndia = UpiIndia();
  PaymentUserOrderBloc() : super(UpiPaymentInitial()) {
 on<FetchUpiAppsEvent>(_onFetchUpiApps);
    on<InitiateUpiPaymentEvent>(_onInitiateUpiPayment);
  }
   Future<void> _onFetchUpiApps(
      FetchUpiAppsEvent event, Emitter<UpiPaymentState> emit) async {
    emit(UpiAppsLoading());
    try {
      final apps = await _upiIndia.getAllUpiApps(mandatoryTransactionId: false);
      if (apps.isNotEmpty) {
        emit(UpiAppsFetched(apps));
      } else {
        emit(UpiPaymentError('No UPI apps found'));
      }
    } catch (e) {
      emit(UpiPaymentError(e.toString()));
    }
  }

  Future<void> _onInitiateUpiPayment(
      InitiateUpiPaymentEvent event, Emitter<UpiPaymentState> emit) async {
    emit(UpiPaymentLoading());
    try {
      final response = await _upiIndia.startTransaction(
        app: event.upiApp,
        receiverUpiId: event.receiverUpiId,
        receiverName: event.receiverName,
        transactionRefId: event.transactionRefId,
        transactionNote: event.transactionNote,
        amount: event.amount,
      );
      if (response.status == UpiPaymentStatus.SUCCESS) {
        emit(UpiPaymentSuccess(response));
      } else {
        emit(UpiPaymentError('Transaction failed: ${response.status}'));
      }
    } catch (e) {
      emit(UpiPaymentError('Transaction failed: $e'));
    }
  }
}
