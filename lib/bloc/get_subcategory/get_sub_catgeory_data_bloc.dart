
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:metrogeniusapp/services/admin/applications/admin_services.dart';

part 'get_sub_catgeory_data_event.dart';
part 'get_sub_catgeory_data_state.dart';

class GetSubCatgeoryDataBloc extends Bloc<GetSubCatgeoryDataEvent, GetSubCatgeoryDataState> {
  final AdminServices adminServices;
  List<DocumentSnapshot>wholeData1=[];
  GetSubCatgeoryDataBloc(this.adminServices) : super(GetSubCatgeoryDataInitial()) {
   on<FetchSubCategoryData>(_fetchData);
   on<DataFetchedSubCatgeory>(_onDataFetched);
   on<SearchSucCategryData>(_onSearch);

  }

  Future<void> _fetchData(FetchSubCategoryData event,Emitter<GetSubCatgeoryDataState>emit)async{
    emit(GetSubCatgeoryDataLoading());
    try {
      Stream<QuerySnapshot>catgeoryStream=await adminServices.getSubCategories(event.catgeoryId);
      catgeoryStream.listen((snapshots){
        final data=snapshots.docs;
        add(DataFetchedSubCatgeory(data));
      });
    } catch (e) {
      emit(GetSubCatgeoryDataFailure(e.toString()));
    }
  }
  void _onDataFetched(DataFetchedSubCatgeory event,Emitter<GetSubCatgeoryDataState>emit){
     wholeData1=event.data;
    emit(GetSubCatgeoryDataLoaded(wholeData1));
  }
FocusNode searchFocusNode = FocusNode();

void _onSearch(SearchSucCategryData event, Emitter<GetSubCatgeoryDataState> emit) {
  final query = event.query.toLowerCase();
  print('Search event received: ${event.query}');

  if (query.isEmpty) {
    emit(GetSubCatgeoryDataLoaded(wholeData1));
    return;
  }

  final filteredData = wholeData1.where((item) {
    final catName = item['CatName']?.toString().toLowerCase() ?? '';
    return catName.contains(query);
  }).toList();

  if (filteredData.isEmpty) {
    // Keep the focus on the search field if no results are found
    searchFocusNode.requestFocus();
  }

  emit(GetSubCatgeoryDataLoaded(filteredData));
}


}
