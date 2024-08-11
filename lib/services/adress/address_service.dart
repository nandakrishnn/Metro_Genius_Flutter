import 'package:cloud_firestore/cloud_firestore.dart';

class AddressServiceUser {
  Future<bool> addAddressUser(
      Map<String, dynamic> userAdressInfo, dynamic id, String userId) async {
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userId)
          .collection("UserAddress").add(userAdressInfo);
      return true;
    } catch (e) {
      return false;
    }
  }

  Map<String, dynamic> userAdressInfo({
    required String id,
    required String name,
    required String adress,
    required String city,
    required int phoneno,
    required String state,
    required int postCode,
    required String adressType,
  }) {
    Map<String, dynamic> userAdressInfo = {
      'Id': id,
      'AddressName': name,
      'AddressLine1': adress,
      'AddressCity': city,
      'AddressPhone': phoneno,
      'AddressState': state,
      'AddressPostCode': postCode,
      'AdressType':adressType
    };
    return userAdressInfo;
  }
     Future<Stream<QuerySnapshot>> getUserAdress(String userId) async {
    return FirebaseFirestore.instance
        .collection("Users")  
        .doc(userId)          
        .collection("UserAddress") 
        .snapshots();            
  }
}
