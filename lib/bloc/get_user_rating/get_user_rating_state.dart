part of 'get_user_rating_bloc.dart';


sealed class GetUserRatingState extends Equatable {
  const GetUserRatingState();

  @override
  List<Object> get props => [];
}

final class GetUserRatingInitial extends GetUserRatingState {}

final class GetUserRatingLoading extends GetUserRatingState {}

final class GetUserRatingLoaded extends GetUserRatingState {
  List<DocumentSnapshot> data;
  GetUserRatingLoaded(this.data);
  @override
  List<Object> get props => [data];
}
final class GetUserRatingFailure extends GetUserRatingState {
  String errorMsg;
 GetUserRatingFailure(this.errorMsg);
  @override
  List<Object> get props => [errorMsg];
}