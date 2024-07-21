part of 'job_application_employe_bloc.dart';

enum FormStatus { inital, pending, sucess, error }

@immutable
final class JobApplicationEmployeState {
  JobApplicationEmployeState({
    this.nameUser = "",
    this.emailUser = "",
    this.imgUser = "",
    this.proofUser = "",
    this.workUser = "",
    this.experiUser=0,
    this.phoneUser=0,
    this.status = FormStatus.inital,
    this.errorMsg,
  });
  final String? imgUser;
  final String? nameUser;
  final int? phoneUser;
  final String? emailUser;
  final String? workUser;
  final int? experiUser;
  final String? proofUser;

  final FormStatus status;
  final String? errorMsg;

  JobApplicationEmployeState copyWith({
    String? nameUser,
    int? phoneUser,
    String? emailUser,
    String? workUser,
    String? proofUser,

    String? imgUser,

    int? experiUser,
    FormStatus? status,
    String? errorMsg,
  }) =>
      JobApplicationEmployeState(
          nameUser: nameUser ?? this.nameUser,
          phoneUser: phoneUser ?? this.phoneUser,
          emailUser: emailUser ?? this.emailUser,
          workUser: workUser ?? this.workUser,
          experiUser: experiUser ?? this.experiUser,
          proofUser: proofUser ?? this.proofUser,
          imgUser: imgUser ?? this.imgUser,
          status: status ?? this.status,
          errorMsg: errorMsg ?? this.errorMsg);
}
