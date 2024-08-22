
import 'package:cloud_firestore/cloud_firestore.dart';

class AddressServiceUser {
  Future<bool> addAddressUser(
      Map<String, dynamic> userAdressInfo, dynamic id, String userId) async {
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userId)
          .collection("UserAddress")
          .add(userAdressInfo);
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
      'AdressType': adressType
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

  Stream<DocumentSnapshot<Object?>> getUserDetails(String userId) {
    return FirebaseFirestore.instance
        .collection('UserDetails')
        .doc(userId)
        .snapshots();
  }

  static Future<Stream<QuerySnapshot>> getUserRequests(String userId) async {
    try {
      final List<String> statuses = [
        'RequestStatus.pending',
        'RequestStatus.accepted'
      ];

      return FirebaseFirestore.instance
          .collectionGroup('UserOrders')
          .where('UserId', isEqualTo: userId)
          .where('RequestStatus', whereIn: statuses)
          .snapshots();
    } catch (e) {
      print('Error fetching requests: $e');
      return Stream.empty();
    }
  }

  static Future<Map<String, dynamic>?> fetchEmployeeDetailsForUser(
      String workerId) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('EmployeesList')
          .where('ApplciantCode', isEqualTo: workerId)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching employee details: $e');
      return null;
    }
  }

  Future<bool> createUserCart(
      Map<String, dynamic> usercartInfo, String randomId) async {
    try {
      await FirebaseFirestore.instance
          .collection("UserCartDetails")
          .doc(randomId)
          .set(usercartInfo);
      return true;
    } catch (e) {
      return false;
    }
  }

  Map<String, dynamic> usercartInfo({
    required String catName,
    required String id,
    required String catImage,
    required String catDes,
    required String cathead,
    required int catPrice,
    required String userId,
    required Map<String,bool> selectedCheckboxes, 
  }) {
    Map<String, dynamic> usercartInfo = {
      'Id': id,
      'ServiceType': catName,
      'CatImage':catImage,
      'CatName': cathead,
      'CatPrice': catPrice,
      'CatDes':catDes,
      'UserId': userId,
      'CheckBox': selectedCheckboxes,
    };
    return usercartInfo;
  }

Stream<QuerySnapshot<Object?>> getUserCartDetails(String userId) {
  return FirebaseFirestore.instance
      .collection("UserCartDetails")
      .where("UserId", isEqualTo: userId)
      .snapshots();
}
 Future<bool>removeUserSaved(String itemid)async{
   try {
      await FirebaseFirestore.instance.collection("UserCartDetails").doc(itemid).delete();
    return true;
   } catch (e) {
     return false;
   }
}

 Future<bool> isAlreadyFavourited(String catName, String userId) async {
  try {
   
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("UserCartDetails")
        .where("UserId", isEqualTo: userId)
        .where("CatName", isEqualTo: catName)
        .get();
    return querySnapshot.docs.isNotEmpty?true:false;
  } catch (e) {
    print("Error checking favorite: $e");
    return false;
  }
}
}
