part of 'get_user_adresses_bloc.dart';

sealed class GetUserAdressesEvent extends Equatable {
  const GetUserAdressesEvent();

  @override
  List<Object> get props => [];
}
class FetchDataAdress extends GetUserAdressesEvent{
 final String userId;
 FetchDataAdress(this.userId); 
}
class FetchedDataAdress extends GetUserAdressesEvent{
List<DocumentSnapshot>data;
FetchedDataAdress(this.data);
 @override
  List<Object> get props => [data];
}