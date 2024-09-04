part of 'add_cart_user_bloc.dart';

enum AddCartUserStatus { inital, pending, sucess, error }

@immutable
class AddCartUserState {
  AddCartUserState(
      {
        this.catRating=0.0,
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
    final double catRating;
  final String heading;
  final int? amount;
  final AddCartUserStatus status;
  AddCartUserState copyWith({
    int? amount,
     String? catId,
      double? catRating,
    String? heading,
    String?catDes,
    String? catImage,
    String?catName,
    AddCartUserStatus? status,
       Map<String, bool>? checkBox,
  }) =>
      AddCartUserState(
        catRating: catRating??this.catRating,
        catId: catId??this.catId,
        catDes: catDes??this.catDes,
        checkBox: checkBox ?? this.checkBox,
        catName: catName??this.catName,
          heading: heading ?? this.heading,
          catImage: catImage ?? this.catImage,
          amount: amount ?? this.amount,
          status: status ?? this.status);
}
