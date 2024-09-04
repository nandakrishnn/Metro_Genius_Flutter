part of 'new_notable_ratings_fetch_bloc.dart';

sealed class NewNotableRatingsFetchEvent extends Equatable {
  const NewNotableRatingsFetchEvent();

  @override
  List<Object> get props => [];
}
class FetchRatingData extends NewNotableRatingsFetchEvent{

}
class FetchNewlyAdded extends NewNotableRatingsFetchEvent{

}
class FetchedRatingData extends NewNotableRatingsFetchEvent{
  List<DocumentSnapshot>data;
  FetchedRatingData(this.data);
    @override
  List<Object> get props => [data];
}