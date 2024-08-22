part of 'get_user_details_bloc.dart';

sealed class GetUserDetailsEvent{}
final class UserDataFetchData extends GetUserDetailsEvent{
final String userId;
UserDataFetchData(this.userId);
}
final  class UserdataFetached extends GetUserDetailsEvent{
    final List<DocumentSnapshot>data;
  UserdataFetached(this.data);
    @override
  List<Object> get props => [data];
}