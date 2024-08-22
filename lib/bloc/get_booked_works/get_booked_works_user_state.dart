part of 'get_booked_works_user_bloc.dart';

sealed class GetBookedWorksUserState extends Equatable {
  const GetBookedWorksUserState();

  @override
  List<Object> get props => [];
}

final class GetBookedWorksUserInitial extends GetBookedWorksUserState {}

final class GetBookedWorksUserLoading extends GetBookedWorksUserState {}

final class GetBookedWorksUserLoaded extends GetBookedWorksUserState {
  List<DocumentSnapshot> data;
  GetBookedWorksUserLoaded(this.data);
  @override
  List<Object> get props => [data];
}

final class GetBookedWorksUserFailure extends GetBookedWorksUserState {}

// final class GetUsersEmployeeInital extends GetBookedWorksUserState {}

// final class GetUsersEmployeeLoading extends GetBookedWorksUserState {}

// final class GetUsersEmployeeLoaded extends GetBookedWorksUserState {
//   List<DocumentSnapshot> data;
//   GetUsersEmployeeLoaded(this.data);
//   @override
//   List<Object> get props => [data];
// }
// final class GetUsersEmployeeLoadingFailure extends GetBookedWorksUserState {}
