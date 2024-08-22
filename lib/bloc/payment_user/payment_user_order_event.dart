part of 'payment_user_order_bloc.dart';

abstract class UpiPaymentEvent extends Equatable {
  const UpiPaymentEvent();

  @override
  List<Object> get props => [];
}

class FetchUpiAppsEvent extends UpiPaymentEvent {}

class InitiateUpiPaymentEvent extends UpiPaymentEvent {
  final UpiApp upiApp;
  final String receiverUpiId;
  final String receiverName;
  final String transactionRefId;
  final double amount;
  final String transactionNote;

  const InitiateUpiPaymentEvent({
    required this.upiApp,
    required this.receiverUpiId,
    required this.receiverName,
    required this.transactionRefId,
    required this.amount,
    required this.transactionNote,
  });

  @override
  List<Object> get props => [
        upiApp,
        receiverUpiId,
        receiverName,
        transactionRefId,
        amount,
        transactionNote,
      ];
}