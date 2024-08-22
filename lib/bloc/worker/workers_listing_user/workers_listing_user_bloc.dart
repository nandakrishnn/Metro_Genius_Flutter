import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:metrogeniusapp/bloc/worker/sigin_worker/worker_sign_in_bloc.dart';
import 'package:metrogeniusapp/services/workers/workers_list.dart';

part 'workers_listing_user_event.dart';
part 'workers_listing_user_state.dart';

class WorkersListingUserBloc extends Bloc<WorkersListingUserEvent, WorkersListingUserState> {
  WorkersListingUserBloc() : super(WorkersListingUserInitial()) {
on<WorkersFetchData>(_fetchData);
on<WorkersFetchedData>(_fetchedData);
on<WorkersDataCleared>(_dataCleared);
  }
   Future<void>_fetchData(WorkersFetchData event,Emitter<WorkersListingUserState>emit)async{
    emit(WorkersListingUserLoading());
    try {
      Stream<DocumentSnapshot>workerDetails=await WorkersDetails.getWorkerDetails();
     
    workerDetails.listen((DocumentSnapshot documentSnapshot){
      if(documentSnapshot.exists){
       
      add(WorkersFetchedData(documentSnapshot));
      }
    });

    } catch (e) {
      emit(WorkersListingUserFailure(e.toString()));
    }
   }
   void _fetchedData(WorkersFetchedData event,Emitter<WorkersListingUserState>emit){
    emit(WorkersListingUserLoaded(event.workerSnapshot));
   }
      void _dataCleared(WorkersDataCleared event,Emitter<WorkersListingUserState>emit){
    emit(WorkersListingUserInitial());
   }
}
