import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:metrogeniusapp/services/employe/employe_service.dart';
import 'package:random_string/random_string.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesState()) {
    on<CatgeoriesImageChanges>(_imageChanegs);
    on<TextChanges>(_textChanges);
    on<CategoriesFormSubmit>(_formSubmit);
  }
  void _imageChanegs(CatgeoriesImageChanges event, Emitter<CategoriesState> emit) {
    emit(state.copywith(image: event.image));
  }

  void _textChanges(TextChanges event, Emitter<CategoriesState> emit) {
    emit(state.copywith(text: event.text));
  }

  void _formSubmit(CategoriesFormSubmit event, Emitter<CategoriesState> emit) async {
    emit(state.copywith(uploadStatus: UploadStatus.pending));
    try {
      String id = randomAlphaNumeric(7);
      final addedDetails = EmployeJobApplication()
          .adminCatgeoryInfo(id: id, img: state.image!, name: state.text!);
      final added =
          await EmployeJobApplication().addCatgeoryAdmin(addedDetails, id);
          if(added){
            emit(state.copywith(uploadStatus: UploadStatus.sucess));
          }else{
            emit(state.copywith(uploadStatus: UploadStatus.error));
          }
    } catch (e) {
        emit(state.copywith(uploadStatus: UploadStatus.error));
    }
  }
}
