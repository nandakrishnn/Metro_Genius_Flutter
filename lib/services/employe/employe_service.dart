import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';

class EmployeJobApplication{
    Future<bool> addEmployeApplications(Map<String,dynamic>employeeApplicationInfo)async{
   try {
      String id = randomAlphaNumeric(7);
     await FirebaseFirestore.instance.collection("EmployeApplications").doc(id).set(employeeApplicationInfo);
     return true;
   } catch (e) {
     return false;
   }
  }
   Map<String, dynamic>EmployeApplicationsInfo({
     required String img,
  required String name,
  required int phone,
  required String email,
  required String work,
  required int experi,
  required String proof
}){
  Map<String,dynamic>employeeApplicationInfo={
    'ApplicantImage':img,
    'ApplicantName':name,
    'ApplicantPhone':phone,
    'ApplicantEmail':email,
    'ApplicantWorkType':work,
    'ApplicantExperience':experi,
    'ApplicantProof':proof
  };
  return employeeApplicationInfo;
}

}