import 'package:cloud_firestore/cloud_firestore.dart';

class UserOrderService {
  static Future<bool> userOrderDetails(
      Map<String, dynamic> userOrderInfo, dynamic id, String userId) async {
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userId)
          .collection("UserOrders")
          .add(userOrderInfo);
      return true;
    } catch (e) {
      return false;
    }
  }

  Map<String, dynamic> userOrderInfo({
    required String id,
    required String adress,
    required String paymentMeathod,
    required String description,
    required String userId,
    required String createAt,
     String? serviceTitle,
    required int totalPrice,
    required int discountPrice,
    required String dateTime,
    required String workerId,
    required String machineServiceTitle,
    required String categoryName,
    String? requestStatus,
   required String catimage
    
  }) {
    Map<String, dynamic> userOrderInfo = {
      'Id': id,
      'AddressLine1': adress,
      'PaymentMeathod':paymentMeathod,
      'CategoryName': categoryName,
      'OrderDescription': description,
      'UserId': userId,
      'CatImage':catimage,
      'CreateAt': createAt,
      'ServiceTitle': serviceTitle,
      'TotalPrice': totalPrice,
      'DiscountPrice': discountPrice,
      'DateTime': dateTime,
      'WorkerId': workerId,
      'ServiceType': machineServiceTitle,
      'RequestStatus': requestStatus,
    };
    return userOrderInfo;
  }
}
