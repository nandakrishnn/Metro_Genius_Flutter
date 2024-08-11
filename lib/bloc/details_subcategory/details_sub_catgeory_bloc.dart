import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
part 'details_sub_catgeory_event.dart';
part 'details_sub_catgeory_state.dart';

class DetailsSubCatgeoryBloc extends Bloc<DetailsSubCatgeoryEvent, DetailsSubCatgeoryState> {
  DetailsSubCatgeoryBloc() : super(DetailsSubCatgeoryState()) {
   on<AmountChnages>(_amountChanges);
   on<TotalAmountChanges>(_totalAmountChanges);
   on<NumberOfUnits>(_numberOfUnits);
   on<CheckBoxChnages>(_checkBoxChanges);
   on<SubCatgeoryFormSubmit>(_formSubmit);
   on<IncrementUnits>(_addbuttonClicked);
   on<DecrementUnits>(_subButtonClicked);
  }
  void _amountChanges(AmountChnages event,Emitter<DetailsSubCatgeoryState>emit){
    emit(state.copyWith(amount: event.amount));
  }
    void _totalAmountChanges(TotalAmountChanges event,Emitter<DetailsSubCatgeoryState>emit){
    emit(state.copyWith(totalAmount: event.totalAmount));
  }
      void _numberOfUnits(NumberOfUnits event,Emitter<DetailsSubCatgeoryState>emit){
    emit(state.copyWith(numberOfUnits: event.numberUnits));
  }
        void _checkBoxChanges(CheckBoxChnages event,Emitter<DetailsSubCatgeoryState>emit){
     Map<String, bool> updatedCheckboxes = Map.from(state.checkBox);
          updatedCheckboxes[event.id] = event.isChecked;
          print(event.id);
          print(event.isChecked);
          emit(state.copyWith(checkBox: updatedCheckboxes));
  }
  void _addbuttonClicked(IncrementUnits event,Emitter<DetailsSubCatgeoryState>emit){

    final currentuUnits=state.numberOfUnits??0;
   if(currentuUnits<10){
     emit(state.copyWith(numberOfUnits: currentuUnits+1)); 
   }
  }
  void _subButtonClicked(DecrementUnits event,Emitter<DetailsSubCatgeoryState>emit){
    final currentNumber=state.numberOfUnits??0;
    if(currentNumber>1){
    emit(state.copyWith(numberOfUnits: currentNumber-1));
    }

  }
  void _formSubmit(SubCatgeoryFormSubmit event,Emitter<DetailsSubCatgeoryState>emit){
  }
}
