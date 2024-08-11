part of 'worker_sign_in_bloc.dart';


enum WorkerSigninFormStatus{
  inital,
  pending,
  sucess,
  error
}
@immutable
final class WorkerSignInState{
  WorkerSignInState({
 this.email="",
   this.password="",
  this.status=WorkerSigninFormStatus.inital,
    this.errorMsg,
  });
   final String email;
  final String password;
   WorkerSigninFormStatus status;
   String? errorMsg;

  WorkerSignInState copyWith({
       String? email,
    String? password,
    WorkerSigninFormStatus? status,
    String? errorMsg,
  })=> WorkerSignInState(
          email: email ?? this.email,
          password: password ?? this.password,
          status: status ?? this.status,
          errorMsg: errorMsg ?? this.errorMsg);
}