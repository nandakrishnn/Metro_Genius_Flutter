part of 'get_booked_works_user_bloc.dart';

sealed class GetBookedWorksUserEvent extends Equatable {
  const GetBookedWorksUserEvent();

  @override
  List<Object> get props => [];
}
final class FetchOrderSummaryUser extends GetBookedWorksUserEvent{
final String userId;
FetchOrderSummaryUser(this.userId);
}
final class FetchedOrderSummaryUser extends GetBookedWorksUserEvent{
List<DocumentSnapshot>data;
FetchedOrderSummaryUser(this.data);
  @override
  List<Object> get props => [data];
}
// final class FetchOrderEmploye extends GetBookedWorksUserEvent{
// final String workerId;
// FetchOrderEmploye(this.workerId);
// }
// final class FetchedOrderEmploye extends GetBookedWorksUserEvent{
// List<DocumentSnapshot>data;
// FetchedOrderEmploye(this.data);
//   @override
//   List<Object> get props => [data];
// }