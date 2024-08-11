import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkersDetails {
  Future<Stream<QuerySnapshot>> getSubCategories(String categoryId) async {
    return FirebaseFirestore.instance
        .collection("CatgeoryDetails")
        .doc(categoryId)
        .collection("SubCategories")
        .snapshots();
  }

  Future<bool> checkEmailAndWorkCode(String email, String workCode) async {
    try {
      CollectionReference workersCollection =
          FirebaseFirestore.instance.collection('EmployeesList');

      QuerySnapshot querySnapshot = await workersCollection
          .where('ApplicantEmail', isEqualTo: email)
          .where('ApplciantCode', isEqualTo: workCode)
          .get();
      final dynamic documentId = querySnapshot.docs.first.id;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('WorkerId', documentId);
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print("Error checking email and work code: $e");
      return false;
    }
  }

 static Future<Stream<DocumentSnapshot>>getWorkerDetails()async{
  SharedPreferences pref=await SharedPreferences.getInstance();
  String?employeId=pref.getString('WorkerId');
  return FirebaseFirestore.instance
      .collection("EmployeesList")
      .doc(employeId)
      .snapshots();
 }
}
