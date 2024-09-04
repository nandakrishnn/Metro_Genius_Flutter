part of 'new_notable_ratings_fetch_bloc.dart';

sealed class NewNotableRatingsFetchState extends Equatable {
  const NewNotableRatingsFetchState();
  
  @override
  List<Object> get props => [];
}

final class NewNotableRatingsFetchInitial extends NewNotableRatingsFetchState {}
final class NewNotableRatingsFetchLoading extends NewNotableRatingsFetchState {}
final class NewNotableRatingsFetchLoaded extends NewNotableRatingsFetchState {
List<DocumentSnapshot>data;
NewNotableRatingsFetchLoaded(this.data);
}
final class NewNotableRatingsFetchFailure extends NewNotableRatingsFetchState {}