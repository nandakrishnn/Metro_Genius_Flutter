import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:metrogeniusapp/services/order_summary/order_service.dart';
import 'package:random_string/random_string.dart';

part 'order_summary_bloc_event.dart';
part 'order_summary_bloc_state.dart';

class OrderSummaryBlocBloc
    extends Bloc<OrderSummaryBlocEvent, OrderSummaryBlocState> {
  final UserOrderService userOrderService;
  OrderSummaryBlocBloc(this.userOrderService) : super(OrderSummaryBlocState()) {
    on<AddressChanges>(_adressChanges);
    on<DescriptionChanges>(_descriptionChanges);
    on<UserIdChanges>(_userIdChanges);
    on<CreateAtChnages>(_createAtChanges);
    on<ServiceTitileChanges>(_serviceTitleChanges);
    on<TotalPriceChnages>(_totalPriceChanges);
    on<DateTimeChnages>(_dateTimeChanges);
    on<WorkerIdChnages>(_workerIdChanges);
    on<CatgeoryNameChnages>(_catgeoryNameChanges);
    on<DiscountChnages>(_discountChanges);
    on<MachineServiceType>(_machineTypeChanges);
    on<CategoryImageChanges>(_catImageChanges);
        on<PaymentMeathod>(_paymentMeathodChanges);
    on<FormSubmit>(_formSubmit);
  }
  void _adressChanges(
      AddressChanges event, Emitter<OrderSummaryBlocState> emit) {
    emit(state.copyWith(adress: event.address));
  }

  void _descriptionChanges(
      DescriptionChanges event, Emitter<OrderSummaryBlocState> emit) {
    emit(state.copyWith(description: event.description));
  }

  void _userIdChanges(
      UserIdChanges event, Emitter<OrderSummaryBlocState> emit) {
    emit(state.copyWith(userId: event.userId));
  }

  void _createAtChanges(
      CreateAtChnages event, Emitter<OrderSummaryBlocState> emit) {
    emit(state.copyWith(createAt: event.createAt));
  }

  void _serviceTitleChanges(
      ServiceTitileChanges event, Emitter<OrderSummaryBlocState> emit) {
    emit(state.copyWith(serviceTitle: event.serviceTitle));
  }

  void _totalPriceChanges(
      TotalPriceChnages event, Emitter<OrderSummaryBlocState> emit) {
    emit(state.copyWith(totalPrice: event.totalPrice));
  }

  void _dateTimeChanges(
      DateTimeChnages event, Emitter<OrderSummaryBlocState> emit) {
    emit(state.copyWith(dateTime: event.dateTime));
  }

  void _workerIdChanges(
      WorkerIdChnages event, Emitter<OrderSummaryBlocState> emit) {
    emit(state.copyWith(workerId: event.workerId));
  }

  void _catgeoryNameChanges(
      CatgeoryNameChnages event, Emitter<OrderSummaryBlocState> emit) {
    emit(state.copyWith(categoryName: event.categoryName));
  }

  void _discountChanges(
      DiscountChnages event, Emitter<OrderSummaryBlocState> emit) {
    emit(state.copyWith(discountPrice: event.discountPrice));
  }

  void _machineTypeChanges(
      MachineServiceType event, Emitter<OrderSummaryBlocState> emit) {
    emit(state.copyWith(machineServiceTitle: event.machineServiceTitle));
  }
  
  void _paymentMeathodChanges(
      PaymentMeathod event, Emitter<OrderSummaryBlocState> emit) {
    emit(state.copyWith(paymentMeathod: event.paymentMeathod));
  }

  void _catImageChanges(
      CategoryImageChanges event, Emitter<OrderSummaryBlocState> emit) {
    emit(state.copyWith(catImage: event.catImage));
  }
  //   void _checkBoxChanges(
  //     UserCheckboxChanges event, Emitter<OrderSummaryBlocState> emit) {
  //   emit(state.copyWith(checkbox: event.usercheckboxChanges));
  // }

  void _formSubmit(FormSubmit event, Emitter<OrderSummaryBlocState> emit) {
    emit(state.copyWith(status: FormStatus.pending));
    try {
      final randomId = randomAlphaNumeric(10);
      final details = userOrderService.userOrderInfo(
        paymentMeathod: state.paymentMeathod,
          catimage: state.catImage,
          id: randomId,
          adress: state.adress,
          description: state.description,
          userId: FirebaseAuth.instance.currentUser!.uid,
          createAt: state.createAt,
          serviceTitle: state.serviceTitle,
          totalPrice: state.totalPrice,
          discountPrice: state.discountPrice,
          dateTime: state.dateTime,
          workerId: state.workerId,
          machineServiceTitle: state.machineServiceTitle,
          requestStatus: RequestStatus.pending.toString(),
          categoryName: state.categoryName);
      final added = UserOrderService.userOrderDetails(
          details, randomId, FirebaseAuth.instance.currentUser!.uid);
      if (added == true) {
        emit(state.copyWith(status: FormStatus.sucess));
      } else {
        emit(state.copyWith(status: FormStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(status: FormStatus.failure));
    }
  }
}
