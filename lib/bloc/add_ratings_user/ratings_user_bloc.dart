import 'package:bloc/bloc.dart';
import 'package:random_string/random_string.dart';

import '../../services/user/user_services.dart';

part 'ratings_user_event.dart';
part 'ratings_user_state.dart';

class RatingsUserBloc extends Bloc<RatingsUserEvent, RatingsUserState> {
  final AddressServiceUser serviceUser;
  RatingsUserBloc(this.serviceUser) : super(RatingsUserState()) {
  on<UserIdChanges>(_userIdChanges);
  on<CatgeoryType>(_categoryTypeChanges);
  on<ServiceRatingStarChanges>(_serviceRatingChanges);
  on<DateTimeChanges>(_dateTimeChanges);
    on<ItemIndex>(_itemIndexChanges);
  on<RatingDescritpion>(_serviceRatingDescription);
  on<FormSubmit>(_formSubmit);
  }
  void _userIdChanges(UserIdChanges event,Emitter<RatingsUserState>emit){
    emit(state.copyWith(userId: event.userId));
  }
  void _categoryTypeChanges(CatgeoryType event,Emitter<RatingsUserState>emit){
    emit(state.copyWith(catgeoryType: event.catgeoryType));
  }
    void _serviceRatingChanges(ServiceRatingStarChanges event,Emitter<RatingsUserState>emit){
    emit(state.copyWith(ratingStarCount: event.serviceRatingStar));
  }
      void _serviceRatingDescription(RatingDescritpion event,Emitter<RatingsUserState>emit){
    emit(state.copyWith(serviceRatingDes: event.ratingDescription));
  }
       void _dateTimeChanges(DateTimeChanges event,Emitter<RatingsUserState>emit){
    emit(state.copyWith(dateTime: event.dateTimeChnages));
  }
       void _itemIndexChanges(ItemIndex event,Emitter<RatingsUserState>emit){
    emit(state.copyWith(index: event.index));
  }
    _formSubmit(FormSubmit event,Emitter<RatingsUserState>emit){
    emit(state.copyWith(status: RatingStatus.inital));
    try{
      String id=randomAlphaNumeric(10);
      final dataMap=serviceUser.userRatingInfo(
        
        index: state.index!,
        dateTime: state.dateTime!,id: id, userId: state.userId!, categoryName: state.catgeoryType!, ratingStarCount: state.ratingStarCount!, ratingDes: state.serviceRatingDes!, workerId: state.workerId!);
      final added=serviceUser.addUserRating(dataMap, id);
      if(added==true){
        emit(state.copyWith(status: RatingStatus.sucess));
      }else{
        emit(state.copyWith(status: RatingStatus.error));
      }
    }catch(e){
 emit(state.copyWith(status: RatingStatus.error));
    }
  }
}
