part of 'order_summary_bloc_bloc.dart';

enum RequestStatus { pending, accepted, rejected }

enum FormStatus { inital, pending, sucess, failure }

@immutable
final class OrderSummaryBlocState {
  OrderSummaryBlocState(
      {this.description = '',
      this.userId = '',
      this.createAt = '',
      this.serviceTitle = '',
      this.totalPrice = 0,
      this.dateTime = '',
      this.checkbox='',
      this.workerId = '',
      this.machineServiceTitle = '',
      this.adress = '',
      this.categoryName='',
      this.discountPrice = 0,
      this.status = FormStatus.inital,
      this.requestStatus = RequestStatus.pending,
      this.errorMsg});
  final String adress;
  final String checkbox;
  final String categoryName;
  final String description;
  final String userId;
  final String createAt;
  final String serviceTitle;
  final int totalPrice;
  final int discountPrice;
  final String dateTime;
  final String workerId;
  final String machineServiceTitle;
  final String? errorMsg;
  final FormStatus status;
  final RequestStatus requestStatus;
  OrderSummaryBlocState copyWith(
          {String? adress,
          String? categoryName,
          String? description,
          String? machineServiceTitle,
          String? userId,
          int? discountPrice,
          String? createAt,
          String? serviceTitle,
           String? checkbox,
          int? totalPrice,
          String? dateTime,
          String? workerId,
          FormStatus? status,
          RequestStatus? requestStatus,
          }) =>
      OrderSummaryBlocState(
        checkbox: checkbox??this.checkbox,
          discountPrice: discountPrice ?? this.discountPrice,
          adress: adress ?? this.adress,
          categoryName: categoryName ?? this.categoryName,
          description: description ?? this.description,
          userId: userId ?? this.userId,
          createAt: createAt ?? this.createAt,
          serviceTitle: serviceTitle ?? this.serviceTitle,
          totalPrice: totalPrice ?? this.totalPrice,
          dateTime: dateTime ?? this.dateTime,
          workerId: workerId ?? this.workerId,
          machineServiceTitle: machineServiceTitle ?? this.machineServiceTitle,
          status: status ?? this.status,
          requestStatus: requestStatus ?? this.requestStatus);
}
