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

static Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getRequests() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('WorkerId');

    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('EmployeesList')
        .doc(id)
        .get();

    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    final workType = data['ApplicantWorkType'];
    final formStatus = 'RequestStatus.pending';

    // Explicitly cast the stream to the desired type
    return FirebaseFirestore.instance
        .collectionGroup('UserOrders')
        .where('CategoryName', isEqualTo: workType)
        .where('RequestStatus', isEqualTo: formStatus)
        .snapshots()
        .cast<QuerySnapshot<Map<String, dynamic>>>(); // Cast here
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
static Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getRequestsByDate(String dateString) async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? workerId = prefs.getString('EmployeAssigned');
    String status='RequestStatus.accepted';
    // Print to verify the date string and worker ID
    print('Fetching works for date: $dateString for worker $workerId');

    // Firestore query: Matching documents where DateTime field starts with the date string
    return FirebaseFirestore.instance
        .collectionGroup('UserOrders')
        .where('DateTime', isGreaterThanOrEqualTo: dateString)  // Assuming 'DateTime' field is stored as string
        .where('DateTime', isLessThan: dateString + '\uf8ff') // Range query to match dates starting with dateString
        .where('WorkerId', isEqualTo: workerId).where('RequestStatus',isEqualTo: status)
        .snapshots()
        .cast<QuerySnapshot<Map<String, dynamic>>>();
  } catch (e) {
    print('Error fetching requests: $e');
    return Stream.empty();
  }
}



}
