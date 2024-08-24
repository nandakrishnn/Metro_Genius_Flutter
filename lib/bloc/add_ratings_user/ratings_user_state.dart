part of 'ratings_user_bloc.dart';

enum RatingStatus { inital, pending, sucess, error }

class RatingsUserState {
  RatingsUserState(
      {this.serviceRatingDes = '',
      this.catgeoryType = '',
      this.userId = '',
      this.workerId = '',
      this.ratingStarCount=0,
      this.index=-1,
      this.dateTime,
      this.status = RatingStatus.inital});
  String? serviceRatingDes;
  DateTime?dateTime;
  String? workerId;
  int? index;
  double?ratingStarCount;
  final RatingStatus? status;
  String? catgeoryType;
  String? userId;
  
  RatingsUserState copyWith({
    int?index,
          final RatingStatus? status,
            double?ratingStarCount,
              DateTime?dateTime,
          String? serviceRatingDes,
          String? catgeoryType,
          String? userId,
          String? workerId}) =>
      RatingsUserState(
        index: index??this.index,
        dateTime: dateTime??this.dateTime,
        ratingStarCount: ratingStarCount??this.ratingStarCount,
          status: status ?? this.status,
          serviceRatingDes: serviceRatingDes ?? this.serviceRatingDes,
          catgeoryType: catgeoryType ?? this.catgeoryType,
          userId: userId ?? this.userId,
          workerId: workerId ?? this.workerId);
}
