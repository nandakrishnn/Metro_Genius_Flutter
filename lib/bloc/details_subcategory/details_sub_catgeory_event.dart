part of 'details_sub_catgeory_bloc.dart';

sealed class DetailsSubCatgeoryEvent{}
                                     
                                       
final class AmountChnages  extends DetailsSubCatgeoryEvent{
  final int amount;
  AmountChnages(this.amount);
}
final class TotalAmountChanges extends DetailsSubCatgeoryEvent{
  final int totalAmount;
  TotalAmountChanges(this.totalAmount);
}
final class NumberOfUnits extends DetailsSubCatgeoryEvent{
  final int numberUnits;
  NumberOfUnits(this.numberUnits);
}
final class CheckBoxChnages extends DetailsSubCatgeoryEvent{
  final String id; 
  final bool isChecked;
    CheckBoxChnages(this.id, this.isChecked);
}

final class IncrementUnits extends DetailsSubCatgeoryEvent {}

final class DecrementUnits extends DetailsSubCatgeoryEvent {}

final class SubCatgeoryFormSubmit extends DetailsSubCatgeoryEvent{}