import 'package:cloud_firestore/cloud_firestore.dart';

class AdminServices{


  Future<Stream<QuerySnapshot>>getJobApplications()async{
   return  FirebaseFirestore.instance.collection("EmployeApplications").snapshots();
  }

}