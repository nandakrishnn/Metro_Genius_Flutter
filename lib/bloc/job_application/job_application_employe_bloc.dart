import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metrogeniusapp/services/employe/employe_service.dart';
import 'package:random_string/random_string.dart';

part 'job_application_employe_event.dart';
part 'job_application_employe_state.dart';

class JobApplicationEmployeBloc
    extends Bloc<JobApplicationEmployeEvent, JobApplicationEmployeState> {
  JobApplicationEmployeBloc() : super(JobApplicationEmployeState()) {
    on<ImageChanges>(imageChanged);
    on<UNameChanges>(userNameChanged);
    on<UserPhone>(userPhoneChanged);
    on<UserEmail>(userEmailChanged);
    on<UserWorkType>(userWorkChanged);
    on<UserExperience>(userExperiencChanged);
    on<IdProof>(userIdProofChanged);
    on<FormSubmit>(onFormSubmit);
      // on<FormUpdate>(__onUpdateFormSubmit);
    on<FormReset>(onFormRest);
  }

  void imageChanged(
      ImageChanges event, Emitter<JobApplicationEmployeState> emit) {
    final newValueForImage = event.userImg;
    final newState = state.copyWith(imgUser: newValueForImage);
    emit(newState);
  }

  void userNameChanged(
      UNameChanges event, Emitter<JobApplicationEmployeState> emit) {
    final newValueForName = event.userName;
    final newState = state.copyWith(nameUser: newValueForName);
    emit(newState);
  }

  void userPhoneChanged(
      UserPhone event, Emitter<JobApplicationEmployeState> emit) {
    final newValueForPhone = event.userPhone;
    final newState = state.copyWith(phoneUser: newValueForPhone);
    emit(newState);
  }

  void userEmailChanged(
      UserEmail event, Emitter<JobApplicationEmployeState> emit) {
    final newValueForEmail = event.userEmail;
    final newState = state.copyWith(emailUser: newValueForEmail);
    print(event.userEmail);
    emit(newState);
  }

  void userWorkChanged(
      UserWorkType event, Emitter<JobApplicationEmployeState> emit) {
    final newValueForWork = event.userWork;
    final newState = state.copyWith(workUser: newValueForWork);
    emit(newState);
    print(event.userWork);
  }

  void userExperiencChanged(
      UserExperience event, Emitter<JobApplicationEmployeState> emit) {
    final newValueForExp = event.userExper;
    final newState = state.copyWith(experiUser: newValueForExp);
    emit(newState);
  }

  void userIdProofChanged(
      IdProof event, Emitter<JobApplicationEmployeState> emit) {
    final newValueForIdProof = event.userIdProof;
    final newstate = state.copyWith(proofUser: newValueForIdProof);
    emit(newstate);
  }

  void onFormSubmit(
      FormSubmit event, Emitter<JobApplicationEmployeState> emit) async {
        emit(state.copyWith(status: FormStatus.pending));
    try {
      String id = randomAlphaNumeric(7);
      final submitted =  EmployeJobApplication().employeApplicationsInfo(
        id: id,
          img: state.imgUser!,
          name: state.nameUser!,
          phone: state.phoneUser!,
          email: state.emailUser!,
          work: state.workUser!,
          experi: state.experiUser!,
          proof: state.proofUser!);



      final added =
          await EmployeJobApplication().addEmployeApplications(submitted,id);
          print(added);
      if (added == true) {
        emit(state.copyWith(status: FormStatus.sucess));
      } else {
        emit(state.copyWith(status: FormStatus.error,errorMsg: 'Details not added'));
      }
    } catch (e) {
      emit(state.copyWith(status: FormStatus.error,errorMsg: e.toString()));
    }
  }
  void onFormRest(FormReset event,Emitter<JobApplicationEmployeState>emit){
    emit(state.copyWith(status: FormStatus.inital));
  }

}
