part of 'edit_employe_details_bloc.dart';
enum EditStatus{inital,pending,sucess,failure}
class EditEmployeDetailsState{
  EditEmployeDetailsState({
 this.workerExp,
this.workerName,
     this.workerImage,
     this.workerPhone,
    this.status=EditStatus.inital
  }
 
  );
  int?workerPhone;
  String?workerImage;
  int?workerExp;
 String?workerName;
  EditStatus? status;
  EditEmployeDetailsState copyWith({
final String? workerName,
final  String?workerImage,
final int?workerPhone,
final EditStatus?status,
 final int?workerExp,
  })=>EditEmployeDetailsState(
    workerPhone: workerPhone??this.workerPhone,
    workerExp: workerExp??this.workerExp,
workerName: workerName??this.workerName,
    status: status??this.status,
    workerImage: workerImage??this.workerImage
  );
}