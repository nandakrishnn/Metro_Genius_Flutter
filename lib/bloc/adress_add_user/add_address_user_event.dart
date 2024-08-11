part of 'add_address_user_bloc.dart';

sealed class AddAddressUserEvent {}
final class AdressType extends AddAddressUserEvent{
  String typeAdress;
  AdressType(this.typeAdress);
}
final class AddName extends AddAddressUserEvent{
  String name;
  AddName(this.name);
}
final class AddAdress extends AddAddressUserEvent{
  String adress;
  AddAdress(this.adress);
}
final class AddCity extends AddAddressUserEvent{
    String city;
  AddCity(this.city);
}
final class AddPhone extends AddAddressUserEvent{
    int phoneno;
  AddPhone(this.phoneno);
}
final class AddState extends AddAddressUserEvent{
    String state;
  AddState(this.state);
}
final class AddZipcode extends AddAddressUserEvent{
    int postCode;
  AddZipcode(this.postCode);
}
final class AddressFormSubmit extends AddAddressUserEvent{}

