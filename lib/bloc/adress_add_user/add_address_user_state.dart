part of 'add_address_user_bloc.dart';

enum AddressFormStatus { inital, pending, sucess, failure }

class AddAddressUserState {
  AddAddressUserState(
      {this.name = '',
      this.adress = '',
      this.addresstatus = AddressFormStatus.inital,
      this.city = '',
      this.adressType='',
      this.postCode,
      this.state = '',
      this.userPhone});
  String? name;
  String? adress;
  String? city;
  String?adressType;
  int? userPhone;
  String? state;
  int? postCode;
  final AddressFormStatus? addresstatus;
  AddAddressUserState copyWith(
          {String? name,
            String?adressType,
          String? adress,
          String? city,
          int? userPhone,
          final AddressFormStatus? addresstatus,
          String? state,
          int? postCode}) =>
      AddAddressUserState(
        adressType: adressType??this.adressType,
          addresstatus: addresstatus ?? this.addresstatus,
          name: name ?? this.name,
          adress: adress ?? this.adress,
          city: city ?? this.city,
          userPhone: userPhone ?? this.userPhone,
          state: state ?? this.state,
          postCode: postCode ?? this.postCode);
}
