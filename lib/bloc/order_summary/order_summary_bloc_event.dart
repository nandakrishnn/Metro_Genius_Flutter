part of 'order_summary_bloc_bloc.dart';

sealed class OrderSummaryBlocEvent {}

final class AddressChanges extends OrderSummaryBlocEvent {
  AddressChanges(this.address);
  final String address;
}

final class DescriptionChanges extends OrderSummaryBlocEvent {
  DescriptionChanges(this.description);
  final String description;
}

final class UserIdChanges extends OrderSummaryBlocEvent {
  UserIdChanges(this.userId);
  final String userId;
}

final class CreateAtChnages extends OrderSummaryBlocEvent {
  CreateAtChnages(this.createAt);
  final String createAt;
}

final class ServiceTitileChanges extends OrderSummaryBlocEvent {
  ServiceTitileChanges(this.serviceTitle);
  final String serviceTitle;
}
final class MachineServiceType extends OrderSummaryBlocEvent {
  MachineServiceType(this.machineServiceTitle);
  final String machineServiceTitle;
}


final class TotalPriceChnages extends OrderSummaryBlocEvent {
  TotalPriceChnages(this.totalPrice);
  final int totalPrice;
}

final class DateTimeChnages extends OrderSummaryBlocEvent {
  DateTimeChnages(this.dateTime);
  final String dateTime;
}

final class WorkerIdChnages extends OrderSummaryBlocEvent {
  WorkerIdChnages(this.workerId);
  final String workerId;
}

final class CatgeoryNameChnages extends OrderSummaryBlocEvent {
  CatgeoryNameChnages(this.categoryName);
  final String categoryName;
}

final class DiscountChnages extends OrderSummaryBlocEvent {
  DiscountChnages(this.discountPrice);
  final int discountPrice;
}
// final class UserCheckboxChanges extends OrderSummaryBlocEvent {
//   UserCheckboxChanges(this.usercheckboxChanges);
//   final String usercheckboxChanges;
// }

final class OrderStatus extends OrderSummaryBlocEvent {}

final class FormSubmit extends OrderSummaryBlocEvent {}
