import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'fetch_available_works_event.dart';
part 'fetch_available_works_state.dart';

class FetchAvailableWorksBloc extends Bloc<FetchAvailableWorksEvent, FetchAvailableWorksState> {
  FetchAvailableWorksBloc() : super(FetchAvailableWorksInitial()) {
    on<FetchAvailableWorksEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
