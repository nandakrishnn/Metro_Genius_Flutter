import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:metrogeniusapp/services/user/user_services.dart';
import 'package:random_string/random_string.dart';

part 'add_address_user_event.dart';
part 'add_address_user_state.dart';

class AddAddressUserBloc
    extends Bloc<AddAddressUserEvent, AddAddressUserState> {
      final AddressServiceUser addAdressUser;
  AddAddressUserBloc(this.addAdressUser) : super(AddAddressUserState()) {
    on<AddName>(_addName);
    on<AddAdress>(_addAddress);
    on<AddCity>(_addCity);
    on<AddPhone>(_addPhone);
    on<AddState>(_addState);
    on<AddZipcode>(_addZipCode);
     on<AdressType>(_addAdressType);
    on<AddressFormSubmit>(_formSubmit);
  }
  void _addName(AddName event, Emitter<AddAddressUserState> emit) {
    emit(state.copyWith(name: event.name));
  }

  void _addAddress(AddAdress event, Emitter<AddAddressUserState> emit) {
    emit(state.copyWith(adress: event.adress));
  }

  void _addCity(AddCity event, Emitter<AddAddressUserState> emit) {
    emit(state.copyWith(city: event.city));
  }

  void _addPhone(AddPhone event, Emitter<AddAddressUserState> emit) {
    emit(state.copyWith(userPhone: event.phoneno));
  }

  void _addState(AddState event, Emitter<AddAddressUserState> emit) {
    emit(state.copyWith(state: event.state));
  }

  void _addZipCode(AddZipcode event, Emitter<AddAddressUserState> emit) {
    emit(state.copyWith(postCode: event.postCode));
  }
   void _addAdressType(AdressType event, Emitter<AddAddressUserState> emit) {
    emit(state.copyWith(adressType: event.typeAdress));
  }


  void _formSubmit(
      AddressFormSubmit event, Emitter<AddAddressUserState> emit) {
      emit(state.copyWith(addresstatus: AddressFormStatus.pending));
        try {
          final mapId=randomAlphaNumeric(10);
          final addressInfo=addAdressUser.userAdressInfo(id:mapId, name: state.name!, adress: state.adress!, city: state.city!, phoneno: state.userPhone!, state: state.state!, postCode: state.postCode!,adressType: state.adressType!);
          final added=AddressServiceUser().addAddressUser(addressInfo, mapId, FirebaseAuth.instance.currentUser!.uid);
          if(added==true){
            emit(state.copyWith(addresstatus:AddressFormStatus.sucess));
          }else{
              emit(state.copyWith(addresstatus:AddressFormStatus.failure));
          }
        } catch (e) {
           emit(state.copyWith(addresstatus:AddressFormStatus.failure));
          }
        }
      }

