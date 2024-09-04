
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:metrogeniusapp/services/user/user_services.dart';

part 'add_cart_user_event.dart';
part 'add_cart_user_state.dart';

class AddCartUserBloc extends Bloc<AddCartUserEvent, AddCartUserState> {
  final AddressServiceUser userserice;
  AddCartUserBloc(this.userserice) : super(AddCartUserState()) {
    on<SubCatgeoryImage>(_imageChnages);
    on<SubCategoryHeading>(_headingChnages);
    on<CategoryName>(_catgeoryName);
    on<CartCheckBoxChnages>(_checkBoxChanges);
    on<ItemPrice>(_itemPrice);
    on<SubCategoryIdChanges>(_subCatgeoryIdChanges);
    on<CategoryDes>(_catgeoryDes);
    on<CartCheckBoxUnSave>(_unsaveItem);
    on<SubCategoryRating>(_catRating);
    on<FormSubmit>(_fromSubmit);
  }
  void _imageChnages(SubCatgeoryImage event, Emitter<AddCartUserState> emit) {
    emit(state.copyWith(catImage: event.catImage));
  }

  void _headingChnages(
      SubCategoryHeading event, Emitter<AddCartUserState> emit) {
    emit(state.copyWith(heading: event.catHeading));
  }

  void _catgeoryName(CategoryName event, Emitter<AddCartUserState> emit) {
    emit(state.copyWith(catName: event.catName));
  }

  void _itemPrice(ItemPrice event, Emitter<AddCartUserState> emit) {
    emit(state.copyWith(amount: event.itemPrice));
  }

  void _catRating(SubCategoryRating event, Emitter<AddCartUserState> emit) {
    emit(state.copyWith(catRating: event.catrating));
  }

  void _subCatgeoryIdChanges(
      SubCategoryIdChanges event, Emitter<AddCartUserState> emit) {
    emit(state.copyWith(catId: event.catId));
  }

  void _catgeoryDes(CategoryDes event, Emitter<AddCartUserState> emit) {
    emit(state.copyWith(catDes: event.catDes));
  }

  void _unsaveItem(
      CartCheckBoxUnSave event, Emitter<AddCartUserState> emit) async {
    try {
      final added = await userserice.removeUserSaved(event.id);
      if (added == true) {
        print('Deleted');
      }
    } catch (e) {
      print("Not deleted");
    }
  }

  void _checkBoxChanges(
      CartCheckBoxChnages event, Emitter<AddCartUserState> emit) {
    Map<String, bool> updatedCheckboxes = Map.from(state.checkBox);
    updatedCheckboxes[event.id] = event.isChecked;
    print(event.id);
    print(event.isChecked);
    emit(state.copyWith(checkBox: updatedCheckboxes));
  }

  void _fromSubmit(FormSubmit event, Emitter<AddCartUserState> emit) {
    emit(state.copyWith(status: AddCartUserStatus.inital));
    try {
      final usercartinfo = userserice.usercartInfo(
          rating: state.catRating,
          selectedCheckboxes: state.checkBox,
          catName: state.catName,
          catDes: state.catDes,
          id: state.catId,
          catImage: state.catImage,
          cathead: state.heading,
          catPrice: state.amount!,
          userId: FirebaseAuth.instance.currentUser!.uid);
      final added = userserice.createUserCart(usercartinfo, state.catId);
      if (added == true) {
        emit(state.copyWith(status: AddCartUserStatus.sucess));
      } else {
        emit(state.copyWith(status: AddCartUserStatus.error));
      }
    } catch (e) {
      emit(state.copyWith(status: AddCartUserStatus.error));
    }
  }
}
