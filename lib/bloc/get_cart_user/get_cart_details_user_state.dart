part of 'get_cart_details_user_bloc.dart';

sealed class GetCartDetailsUserState extends Equatable {
  const GetCartDetailsUserState();
  
  @override
  List<Object> get props => [];
}

final class GetCartDetailsUserInitial extends GetCartDetailsUserState {}
final class GetCartDetailsUserLoading extends GetCartDetailsUserState {}
final class GetCartDetailsUserLoaded extends GetCartDetailsUserState {
  final List<DocumentSnapshot>data;
  GetCartDetailsUserLoaded(this.data);
    @override
  List<Object> get props => [data];
}
final class GetCartDetailsUserLoadingFailure extends GetCartDetailsUserState {
  final String errorMsg;
  GetCartDetailsUserLoadingFailure(this.errorMsg);
    @override
  List<Object> get props => [errorMsg];
}