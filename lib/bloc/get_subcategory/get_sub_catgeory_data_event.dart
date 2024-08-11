part of 'get_sub_catgeory_data_bloc.dart';

sealed class GetSubCatgeoryDataEvent extends Equatable {
  const GetSubCatgeoryDataEvent();

  @override
  List<Object> get props => [];
}
class FetchSubCategoryData extends GetSubCatgeoryDataEvent{
  final String catgeoryId;
  FetchSubCategoryData(this.catgeoryId);
}
class SearchSucCategryData extends GetSubCatgeoryDataEvent{
  final String query;
  SearchSucCategryData(this.query);
  @override
  List<Object> get props => [query];
  }

class DataFetchedSubCatgeory extends GetSubCatgeoryDataEvent{

  final List<DocumentSnapshot>data;
  DataFetchedSubCatgeory(this
  .data);
    @override
  List<Object> get props => [data];

}