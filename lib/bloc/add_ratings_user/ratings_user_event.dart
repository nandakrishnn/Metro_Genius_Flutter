part of 'ratings_user_bloc.dart';

sealed class RatingsUserEvent {}
final class UserIdChanges extends RatingsUserEvent{
  final String userId;
  UserIdChanges(this.userId);
}
final class CatgeoryType extends RatingsUserEvent{
  final String catgeoryType;
  CatgeoryType(this.catgeoryType);
}
final class ServiceRatingStarChanges extends RatingsUserEvent{
  final double serviceRatingStar;
  ServiceRatingStarChanges(this.serviceRatingStar);
}
final class RatingDescritpion extends RatingsUserEvent{
  final String ratingDescription;
  RatingDescritpion(this.ratingDescription);
}
final class DateTimeChanges extends RatingsUserEvent{
  final DateTime dateTimeChnages;
  DateTimeChanges(this.dateTimeChnages);
}
final class ItemIndex extends RatingsUserEvent{
  final int index;
  ItemIndex(this.index);
}
final class FormSubmit extends RatingsUserEvent{}