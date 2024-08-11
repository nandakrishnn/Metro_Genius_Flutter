part of 'details_sub_catgeory_bloc.dart';

enum SubCatgeoryStatus { inital, pending, sucess, error }

@immutable
class DetailsSubCatgeoryState {
  DetailsSubCatgeoryState(
      {this.checkBox = const {},
      this.totalAmount,
      this.numberOfUnits=1,
      this.status = SubCatgeoryStatus.inital,
      this.amount});
 final Map<String, bool> checkBox;
 final int? totalAmount;
 final int? amount;
  int? numberOfUnits=1;
  final SubCatgeoryStatus status;
  DetailsSubCatgeoryState copyWith({
    Map<String, bool>? checkBox,
    int? totalAmount,
    int? amount,
    int? numberOfUnits=1,
    SubCatgeoryStatus?status,

  }) =>
      DetailsSubCatgeoryState(
          totalAmount: totalAmount ?? this.totalAmount,
          checkBox: checkBox ?? this.checkBox,
          amount: amount ?? this.amount, 
          numberOfUnits: numberOfUnits ?? this.numberOfUnits,
          status: status ?? this.status);
}
