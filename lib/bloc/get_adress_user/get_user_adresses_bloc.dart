import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:metrogeniusapp/services/user/user_services.dart';

part 'get_user_adresses_event.dart';
part 'get_user_adresses_state.dart';

class GetUserAdressesBloc extends Bloc<GetUserAdressesEvent, GetUserAdressesState> {
  final AddressServiceUser adressService;
  GetUserAdressesBloc(this.adressService) : super(GetUserAdressesInitial()) {
   on<FetchDataAdress>(_fetchData);
   on<FetchedDataAdress>(_dataFetched);
  }
  Future _fetchData(FetchDataAdress event,Emitter<GetUserAdressesState>emit)async{
    emit(GetUserAdressesLoading());
    try {
       Stream<QuerySnapshot>catgeoryStream=await adressService.getUserAdress(event.userId);
      catgeoryStream.listen((snapshots){
        final data=snapshots.docs;
        add(FetchedDataAdress(data));
      });
    } catch (e) {
            emit(GetUserAdressesFailure(e.toString()));
    }
  }
  void _dataFetched(FetchedDataAdress event,Emitter<GetUserAdressesState>emit){
      emit(GetUserAdressesLoaded(event.data));
  }
}
