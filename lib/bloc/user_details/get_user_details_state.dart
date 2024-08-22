part of 'get_user_details_bloc.dart';

sealed class GetUserDetailsState extends Equatable {
  const GetUserDetailsState();
  
  @override
  List<Object> get props => [];
}

final class GetUserDetailsInitial extends GetUserDetailsState {}
final class GetUserDetailsLoading extends GetUserDetailsState {}
final class GetUserDetailsLoaded extends GetUserDetailsState {
  final List<DocumentSnapshot>data;
  GetUserDetailsLoaded(this.data);
  @override
  List<Object> get props => [data];
}
final class GetUserDetailsLoadingFailure extends GetUserDetailsState {
  final String errorMsg;
  GetUserDetailsLoadingFailure(this.errorMsg);
    @override
  List<Object> get props => [errorMsg];
}
