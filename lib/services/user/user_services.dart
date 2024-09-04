
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

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
  
  static Future<Stream<QuerySnapshot>> getUserOrderHistory(String userId) async {
    try {
      final List<String> statuses = [
        'RequestStatus.compleated',
          'RequestStatus.ordercancelled'
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
    required double rating,
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
      'CatRating':rating
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
Future<bool> addUserRating(
    Map<String, dynamic> userRatingInfo, dynamic id) async {
  try {
    await FirebaseFirestore.instance
        .collection("UserRatings")
        .doc(id)
        .set(userRatingInfo);

    // Fetch all ratings for the given service
    final snapshot = await FirebaseFirestore.instance
        .collection('UserRatings')
        .where('CatName', isEqualTo: userRatingInfo['CatName'])
        .get();

    final ratings = snapshot.docs
        .map((doc) => (doc['RatingStarCount'] as num).toDouble())
        .toList();

    if (ratings.isNotEmpty) {
      // Calculate the average rating and format to one decimal place
      final averageRating = ratings.reduce((a, b) => a + b) / ratings.length;

      // Format the average rating to one decimal place
      final formattedAverageRating =
          double.parse(averageRating.toStringAsFixed(1));

      // Fetch subcategories and update the 'CatRating' field
      final subcategorySnapshot = await FirebaseFirestore.instance
          .collectionGroup('SubCategories')
          .where('CatName', isEqualTo: userRatingInfo['CatName'])
          .get();

      for (var doc in subcategorySnapshot.docs) {
        await FirebaseFirestore.instance
            .doc(doc.reference.path)
            .update({'CatRating': formattedAverageRating});
      }

      debugPrint('SubCategory rating updated successfully');
    } else {
      debugPrint('No ratings found for this service');
    }

    return true;
  } catch (e) {
    debugPrint('Error adding rating and updating subcategory: $e');
    return false;
  }
}


  Map<String, dynamic> userRatingInfo({
    required String id,
    required int index,
    required String userId,
    required String categoryName,
    required double ratingStarCount,
    required String ratingDes,
    required String workerId,
    required DateTime dateTime

  }) {
    Map<String, dynamic> userRatingInfo = {
      'Id':id,
      'ItemIndex':index,
      'UserId': userId,
      'DateTime':dateTime,
      'CatName': categoryName,
      'RatingStarCount': ratingStarCount,
      'RatingDes': ratingDes,
      'WorkerId': workerId,
    };
    return userRatingInfo;
  }
Stream<QuerySnapshot<Object?>> getUserRatings(String categoryType) {
  return FirebaseFirestore.instance
      .collection("UserRatings")
      .where("CatName", isEqualTo: categoryType)
      .snapshots();
}
}
