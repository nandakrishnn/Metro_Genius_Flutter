part of 'get_user_adresses_bloc.dart';

sealed class GetUserAdressesState extends Equatable {
  const GetUserAdressesState();

  @override
  List<Object> get props => [];
}

final class GetUserAdressesInitial extends GetUserAdressesState {}

final class GetUserAdressesLoading extends GetUserAdressesState {}

final class GetUserAdressesLoaded extends GetUserAdressesState {
  List<DocumentSnapshot> data;
  GetUserAdressesLoaded(this.data);
  @override
  List<Object> get props => [data];
}
final class GetUserAdressesFailure extends GetUserAdressesState {
  String errorMsg;
  GetUserAdressesFailure(this.errorMsg);
  @override
  List<Object> get props => [errorMsg];
}