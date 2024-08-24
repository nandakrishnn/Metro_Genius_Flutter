import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:metrogeniusapp/services/user/user_services.dart';
part 'get_user_rating_event.dart';
part 'get_user_rating_state.dart';

class GetUserRatingBloc extends Bloc<GetUserRatingEvent, GetUserRatingState> {
  final AddressServiceUser ratingService;
  GetUserRatingBloc(this.ratingService) : super(GetUserRatingInitial()) {
   on<FetchUserRaingData>(_fetchRatingUserData);
   on<FetchedUserRaingData>(_ratingDataFetched);
  }
 Future _fetchRatingUserData(FetchUserRaingData event,Emitter<GetUserRatingState>emit)async{
  emit(GetUserRatingLoading());
  try{
         Stream<QuerySnapshot>catgeoryStream= ratingService.getUserRatings(event.categoryType);
      catgeoryStream.listen((snapshots){
        final data=snapshots.docs;
        add(FetchedUserRaingData(data));
      });
  }catch(e){
    emit(GetUserRatingFailure(e.toString()));
  }
 }
  void _ratingDataFetched(FetchedUserRaingData event,Emitter<GetUserRatingState>emit){
      emit(GetUserRatingLoaded(event.data));
  }
}
