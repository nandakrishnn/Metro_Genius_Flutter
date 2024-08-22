import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:metrogeniusapp/services/workers/workers_list.dart';

part 'worker_sign_in_event.dart';
part 'worker_sign_in_state.dart';

class WorkerSignInBloc extends Bloc<WorkerSignInEvent, WorkerSignInState> {
  final WorkersDetails workersDetails;
  WorkerSignInBloc(this.workersDetails) : super(WorkerSignInState()) {
     on<WorkerEmailChanges>(emailChanged);
  on<WorkerPassChanges>(passChanges);
  on<WorkerFormSubmit>(formSubmit);
on<WorkerReset>(reset);
  }


  void emailChanged(WorkerEmailChanges event, Emitter<WorkerSignInState> emit) {
    final newValueForEmail=event.email;
    final newState=state.copyWith(email: newValueForEmail);
    emit(newState);
  }
   void reset(WorkerReset event, Emitter<WorkerSignInState> emit) {
    emit(WorkerSignInState()); // Reset to initial state
  }
  void passChanges(WorkerPassChanges event, Emitter<WorkerSignInState> emit) {
    emit(state.copyWith(password: event.password));
  }
  Future<void> formSubmit(WorkerFormSubmit event, Emitter<WorkerSignInState> emit)async {
    //check for empty values
    final email=state.email;
    final pass=state.password;
    if(email.isEmpty||pass.isEmpty) {
      emit(state.copyWith(status: WorkerSigninFormStatus.error, errorMsg: 'Email and password cannot be empty.'));
      return;
    }
 try {
      final user = await workersDetails.checkEmailAndWorkCode(email, pass);
      if (user) {
        emit(state.copyWith(status: WorkerSigninFormStatus.sucess));
      } else {
        emit(state.copyWith(status: WorkerSigninFormStatus.error, errorMsg: 'Login failed.'));
      }
    } catch (e) {
      emit(state.copyWith(status: WorkerSigninFormStatus.error, errorMsg: e.toString()));
    }
  }


}
