part of 'get_cart_details_user_bloc.dart';

sealed class GetCartDetailsUserEvent extends Equatable {
  const GetCartDetailsUserEvent();

  @override
  List<Object> get props => [];
}
final class FetchCartData  extends GetCartDetailsUserEvent{
  final String userId;
  FetchCartData(this.userId);
}
final class FetchedCartData extends GetCartDetailsUserEvent{
  List<DocumentSnapshot>data;
  FetchedCartData(this.data);
 @override
  List<Object> get props => [data];
}