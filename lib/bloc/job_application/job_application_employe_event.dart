part of 'job_application_employe_bloc.dart';

@immutable
sealed class JobApplicationEmployeEvent {}

final class ImageChanges extends JobApplicationEmployeEvent {
  ImageChanges(this.userImg);
  final String userImg;
}

final class UNameChanges extends JobApplicationEmployeEvent {
  UNameChanges(this.userName);
  final String userName;
}

final class UserPhone extends JobApplicationEmployeEvent {
  UserPhone(this.userPhone);
  final int userPhone;
}

final class UserEmail extends JobApplicationEmployeEvent {
  UserEmail(this.userEmail);
  final String userEmail;
}

final class UserWork extends JobApplicationEmployeEvent {
  UserWork(this.userWork);
  final String userWork;
}

final class UserExperience extends JobApplicationEmployeEvent {
  UserExperience(this.userExper);
  final int userExper;
}

final class IdProof extends JobApplicationEmployeEvent {
  IdProof(this.userIdProof);
  final String userIdProof;
}



final class FormSubmit extends JobApplicationEmployeEvent {}

final class FormReset extends JobApplicationEmployeEvent {}
