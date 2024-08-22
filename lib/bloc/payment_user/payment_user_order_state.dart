part of 'payment_user_order_bloc.dart';

abstract class UpiPaymentState extends Equatable {
  const UpiPaymentState();

  @override
  List<Object> get props => [];
}

class UpiPaymentInitial extends UpiPaymentState {}

class UpiAppsLoading extends UpiPaymentState {}

class UpiAppsFetched extends UpiPaymentState {
  final List<UpiApp> apps;

  const UpiAppsFetched(this.apps);

  @override
  List<Object> get props => [apps];
}

class UpiPaymentLoading extends UpiPaymentState {}

class UpiPaymentSuccess extends UpiPaymentState {
  final UpiResponse  response;

  const UpiPaymentSuccess(this.response);

  @override
  List<Object> get props => [response];
}

class UpiPaymentError extends UpiPaymentState {
  final String error;

  const UpiPaymentError(this.error);

  @override
  List<Object> get props => [error];
}