import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:metrogeniusapp/services/workers/workers_list.dart';

part 'fetch_available_works_event.dart';
part 'fetch_available_works_state.dart';

class FetchAvailableWorksBloc extends Bloc<FetchAvailableWorksEvent, FetchAvailableWorksState> {
  FetchAvailableWorksBloc() : super(FetchAvailableWorksInitial()) {
   on<FetchJobsData>(_fetchJobsData);
    on<FetchAcceptedJobsData>(_fetchAcceptedJobsData);
    on<FetchCompleatedJobsData>(_fetchCompleatedJobsData);
   on<FetchedJobsData>(_fetchedData);
  }
  void _fetchJobsData(FetchJobsData event,Emitter<FetchAvailableWorksState>emit)async{
    emit(FetchAvailableWorksLoading());
    try{
     Stream<QuerySnapshot<Object?>>?catgeoryStream=await WorkersDetails.getRequests();
      catgeoryStream.listen((snapshots){
        final data=snapshots.docs;
        add(FetchedJobsData(data));
      });
    }catch(e){
        emit(FetchAvailableWorksLoadingFailure(e.toString()));
    }
  }
  
    void _fetchAcceptedJobsData(FetchAcceptedJobsData event,Emitter<FetchAvailableWorksState>emit)async{
    emit(FetchAvailableWorksLoading());
    try{
     Stream<QuerySnapshot<Object?>>?catgeoryStream=await WorkersDetails.getAcceptedRequests();
      catgeoryStream.listen((snapshots){
        final data=snapshots.docs;
        add(FetchedJobsData(data));
      });
    }catch(e){
        emit(FetchAvailableWorksLoadingFailure(e.toString()));
    }
  }
      void _fetchCompleatedJobsData(FetchCompleatedJobsData event,Emitter<FetchAvailableWorksState>emit)async{
    emit(FetchAvailableWorksLoading());
    try{
     Stream<QuerySnapshot<Object?>>?catgeoryStream=await WorkersDetails.getCompleatedRequests();
      catgeoryStream.listen((snapshots){
        final data=snapshots.docs;
        add(FetchedJobsData(data));
      });
    }catch(e){
        emit(FetchAvailableWorksLoadingFailure(e.toString()));
    }
  }
  void _fetchedData(FetchedJobsData event,Emitter<FetchAvailableWorksState>emit){
      emit(FetchAvailableWorksLoaded(event.data));
  }
}
