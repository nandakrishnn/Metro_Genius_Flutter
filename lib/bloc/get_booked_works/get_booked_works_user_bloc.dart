import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:metrogeniusapp/services/user/user_services.dart';

part 'get_booked_works_user_event.dart';
part 'get_booked_works_user_state.dart';

class GetBookedWorksUserBloc extends Bloc<GetBookedWorksUserEvent, GetBookedWorksUserState> {

  GetBookedWorksUserBloc() : super(GetBookedWorksUserInitial()) {
    on<FetchOrderSummaryUser>(_fetchorderDetails);
    on<FetchedOrderSummaryUser>(_fetchedUserOrderDetails);
    on<FetchOrderSummaryUserHistory>(_fetchorderHistory);
  }
  void _fetchorderDetails(FetchOrderSummaryUser event,Emitter<GetBookedWorksUserState>emit)async{
      try{
        emit(GetBookedWorksUserLoading());
  Stream<QuerySnapshot<Object?>>?catgeoryStream=await AddressServiceUser.getUserRequests(FirebaseAuth.instance.currentUser!.uid);
      catgeoryStream.listen((snapshots){
        final data=snapshots.docs;
        add(FetchedOrderSummaryUser(data));
      });
      }catch(e){
            emit(GetBookedWorksUserFailure());
      }
  }
    void _fetchorderHistory(FetchOrderSummaryUserHistory event,Emitter<GetBookedWorksUserState>emit)async{
      try{
        emit(GetBookedWorksUserLoading());
  Stream<QuerySnapshot<Object?>>?catgeoryStream=await AddressServiceUser.getUserOrderHistory(FirebaseAuth.instance.currentUser!.uid);
      catgeoryStream.listen((snapshots){
        final data=snapshots.docs;
        add(FetchedOrderSummaryUser(data));
      });
      }catch(e){
            emit(GetBookedWorksUserFailure());
      }
  }
  void _fetchedUserOrderDetails(FetchedOrderSummaryUser event,Emitter<GetBookedWorksUserState>emit)async{
      emit(GetBookedWorksUserLoaded(event.data));
  }
}
