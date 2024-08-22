part of 'add_cart_user_bloc.dart';

enum AddCartUserStatus { inital, pending, sucess, error }

@immutable
class AddCartUserState {
  AddCartUserState(
      {
        
      this.heading = '',
this.catId='',
      this.checkBox = const {},
      this.catName='',
      this.catImage = '',
      this.catDes='',
      this.status = AddCartUserStatus.inital,
      this.amount});
       final Map<String, bool> checkBox;
  final String catImage;
    final String catName;
      final String catId;
    final String catDes;
  final String heading;
  final int? amount;
  final AddCartUserStatus status;
  AddCartUserState copyWith({
    int? amount,
     String? catId,
    String? heading,
    String?catDes,
    String? catImage,
    String?catName,
    AddCartUserStatus? status,
       Map<String, bool>? checkBox,
  }) =>
      AddCartUserState(
        catId: catId??this.catId,
        catDes: catDes??this.catDes,
        checkBox: checkBox ?? this.checkBox,
        catName: catName??this.catName,
          heading: heading ?? this.heading,
          catImage: catImage ?? this.catImage,
          amount: amount ?? this.amount,
          status: status ?? this.status);
}
