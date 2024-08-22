import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices{
  Stream<DocumentSnapshot<Object?>> getUserDetails(String userId)  {
  return FirebaseFirestore.instance
      .collection('UserDetails')  
      .doc(userId)               
      .snapshots();
}
  
}