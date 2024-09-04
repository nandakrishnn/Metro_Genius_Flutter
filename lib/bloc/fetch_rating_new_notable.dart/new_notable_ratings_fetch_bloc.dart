

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:metrogeniusapp/services/home/home_service.dart';

part 'new_notable_ratings_fetch_event.dart';
part 'new_notable_ratings_fetch_state.dart';

class NewNotableRatingsFetchBloc extends Bloc<NewNotableRatingsFetchEvent, NewNotableRatingsFetchState> {
  final HomeService homeService;
  NewNotableRatingsFetchBloc(this.homeService) : super(NewNotableRatingsFetchInitial()) {
   on<FetchRatingData>(_fetchratingData);
   on<FetchNewlyAdded>(_fetchNewlyAdded);
      on<FetchedRatingData>(_fetchedRatingData);
  }
  void _fetchratingData(FetchRatingData event,Emitter<NewNotableRatingsFetchState>emit)async{
 
     try{
         emit(NewNotableRatingsFetchLoading());
  Stream<QuerySnapshot<Object?>>?catgeoryStream= homeService.getPopularService();
      catgeoryStream.listen((snapshots){
        final data=snapshots.docs;
        add(FetchedRatingData(data));
      });
      }catch(e){
            emit(NewNotableRatingsFetchFailure());
      }
  }
void _fetchNewlyAdded(FetchNewlyAdded event, Emitter<NewNotableRatingsFetchState> emit) async {
  try {
    emit(NewNotableRatingsFetchLoading());

    Stream<List<DocumentSnapshot>>? catgeoryStream = homeService.getNewlySortedStream();

    await emit.forEach(
      catgeoryStream,
      onData: (List<DocumentSnapshot> data) {
        return NewNotableRatingsFetchLoaded(data);
      },
      onError: (error, stackTrace) {
        return NewNotableRatingsFetchFailure();
      },
    );
  } catch (e) {
    emit(NewNotableRatingsFetchFailure());
  }
}

void _fetchedRatingData(FetchedRatingData event, Emitter<NewNotableRatingsFetchState> emit) {
  emit(NewNotableRatingsFetchLoaded(event.data));
}

}
