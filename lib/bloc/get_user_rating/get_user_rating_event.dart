part of 'get_user_rating_bloc.dart';

sealed class GetUserRatingEvent extends Equatable {
  const GetUserRatingEvent();

  @override
  List<Object> get props => [];
}
class FetchUserRaingData extends GetUserRatingEvent{
 final String categoryType;
 FetchUserRaingData(this.categoryType); 
}
class FetchedUserRaingData extends GetUserRatingEvent{
List<DocumentSnapshot>data;
FetchedUserRaingData(this.data);
 @override
  List<Object> get props => [data];
}