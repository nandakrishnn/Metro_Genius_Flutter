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

  static Future<Stream<DocumentSnapshot>> getWorkerDetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? employeId = pref.getString('WorkerId');
    return FirebaseFirestore.instance
        .collection("EmployeesList")
        .doc(employeId)
        .snapshots();
  }

  static Future<Stream<QuerySnapshot>> getRequests() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final id = prefs.getString('WorkerId');

      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('EmployeesList')
          .doc(id)
          .get();

      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      final workType = data['ApplicantWorkType'];
      final formStatus = 'RequestStatus.pending';

      return FirebaseFirestore.instance
          .collectionGroup('UserOrders')
          .where('CategoryName', isEqualTo: workType)
          .where('RequestStatus', isEqualTo: formStatus)
          .snapshots();
    } catch (e) {
      print('Error fetching requests: $e');

      return Stream.empty();
    }
  }
    static Future<Stream<QuerySnapshot>>getAcceptedRequests() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final id = prefs.getString('WorkerId');
      print(id);

      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('EmployeesList')
          .doc(id)
          .get();

      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      final workType = data['ApplicantWorkType'];
      final formStatus = 'RequestStatus.accepted';

      return FirebaseFirestore.instance
          .collectionGroup('UserOrders')
          .where('CategoryName', isEqualTo: workType)
          .where('RequestStatus', isEqualTo: formStatus)
          .snapshots();
    } catch (e) {
      print('Error fetching requests: $e');

      return Stream.empty();
    }
  }
      static Future<Stream<QuerySnapshot>> getCompleatedRequests() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final id = prefs.getString('WorkerId');
      print(id);
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('EmployeesList')
          .doc(id)
          .get();

      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      final workType = data['ApplicantWorkType'];
      final formStatus = 'RequestStatus.compleated';
      return FirebaseFirestore.instance
          .collectionGroup('UserOrders')
          .where('CategoryName', isEqualTo: workType)
          .where('RequestStatus', isEqualTo: formStatus)
          .snapshots();
    } catch (e) {
      print('Error fetching requests: $e');

      return Stream.empty();
    }
  }
}
