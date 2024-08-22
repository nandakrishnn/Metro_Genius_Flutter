import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:metrogeniusapp/services/user/user_services.dart';

part 'get_cart_details_user_event.dart';
part 'get_cart_details_user_state.dart';

class GetCartDetailsUserBloc extends Bloc<GetCartDetailsUserEvent, GetCartDetailsUserState> {
    final AddressServiceUser userServices;
  GetCartDetailsUserBloc(this.userServices) : super(GetCartDetailsUserInitial()) {
  
on<FetchCartData>(_fetchcartdata);
on<FetchedCartData>(_fetchedData);
  }
  void _fetchcartdata(FetchCartData event,Emitter<GetCartDetailsUserState>emit)async{
    emit(GetCartDetailsUserLoading());
    try {
      Stream<QuerySnapshot>cartStream= userServices.getUserCartDetails(event.userId);
      cartStream.listen((snapshots){
          final data=snapshots.docs;
          add(FetchedCartData(data));
      });
    } catch (e) {
      emit(GetCartDetailsUserLoadingFailure(e.toString()));
    }
  }
  void _fetchedData(FetchedCartData event,Emitter<GetCartDetailsUserState>emit){
    emit(GetCartDetailsUserLoaded(event.data));
  }
}
