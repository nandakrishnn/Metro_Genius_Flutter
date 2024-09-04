import 'package:cloud_firestore/cloud_firestore.dart';

class HomeService{
   Stream<QuerySnapshot<Object?>> getPopularService() {
    return FirebaseFirestore.instance.collectionGroup('SubCategories').orderBy('CatRating', descending: true).limit(5).snapshots();
  }



Stream<List<DocumentSnapshot>> getNewlySortedStream() {
  return FirebaseFirestore.instance
      .collectionGroup('SubCategories')
      .snapshots() 
      .map((QuerySnapshot snapshot) {
        List<DocumentSnapshot> documents = snapshot.docs;

        documents.sort((a, b) {
          DateTime dateA = DateTime.parse(a['CreateAt']);
          DateTime dateB = DateTime.parse(b['CreateAt']);
          return dateB.compareTo(dateA);
        });

    
        return documents.take(5).toList(); 
      });
}



// Stream<List<Map<String, dynamic>>> getMostBookedServices() {
//   return FirebaseFirestore.instance
//       .collectionGroup('UserOrders')
//       .snapshots()
//       .map((snapshot) {
//         final Map<String, int> bookingCounts = {};

//         for (var doc in snapshot.docs) {
//           var serviceName = doc['ServiceType'] ?? 'Unknown';

//           if (bookingCounts.containsKey(serviceName)) {
//             bookingCounts[serviceName] = bookingCounts[serviceName]! + 1;
//           } else {
//             bookingCounts[serviceName] = 1;
//           }
//         }

//         final List<Map<String, dynamic>> sortedServices = bookingCounts.entries
//             .map((entry) => {'ServiceType': entry.key, 'count': entry.value})
//             .toList();

//         sortedServices.sort((a, b) => (b['count'] ?? 0).compareTo(a['count'] ?? 0));

//         return sortedServices.take(5).toList();
//       });
// }




//   Future<bool>workAllocatedOrnot(String employeId,DateTime timeDate)async{
//  try {
//     final querySnapshot=  await FirebaseFirestore.instance.collectionGroup("UserOrders").where('WorkerId',isEqualTo: employeId).where('DateTime',isEqualTo: timeDate).get();
//   if(querySnapshot.docs.isNotEmpty){
//     return true;
//   }
//   return false;
    
//  } catch (e) {
//   print('Sorry');
//   return false;
//  }
//   }
}