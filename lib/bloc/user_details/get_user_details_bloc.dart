import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:metrogeniusapp/services/user/user_services.dart';
import 'package:metrogeniusapp/src/user/screens/bottomnavigation/profile/user_service.dart';

part 'get_user_details_event.dart';
part 'get_user_details_state.dart';

class GetUserDetailsBloc extends Bloc<GetUserDetailsEvent, GetUserDetailsState> {
  final UserServices userServices;
  GetUserDetailsBloc(this.userServices) : super(GetUserDetailsInitial()) {
   on<UserDataFetchData>(_fetchUserData);
   on<UserdataFetached>(_fetchData);
  }
  void _fetchUserData(UserDataFetchData event,Emitter<GetUserDetailsState>emit)async{
    emit(GetUserDetailsLoading());
      try {
        Stream<DocumentSnapshot<Object?>>catgeoryStream= userServices.getUserDetails(event.userId);
         catgeoryStream.listen((snapshots){
        
        add(UserdataFetached([snapshots]));
      });
      } catch (e) {
        emit(GetUserDetailsLoadingFailure(e.toString()));
      }
  }
  void _fetchData(UserdataFetached event,Emitter<GetUserDetailsState>emit){
    emit(GetUserDetailsLoaded(event.data));
  }
}
