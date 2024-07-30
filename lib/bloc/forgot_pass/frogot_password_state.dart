part of 'frogot_password_bloc.dart';

enum UserFormStatus{inital,pending,sucess,error}

final class FrogotPasswordState{
  FrogotPasswordState({
this.email='',
this.status=UserFormStatus.inital,
this.errorMsg,
  });
  final String? email;
  final UserFormStatus? status;
  final String? errorMsg;

  FrogotPasswordState copyWith({
    final String? email,
    final UserFormStatus? status,
      final String? errorMsg
  })=>FrogotPasswordState(
    email: email??this.email,
    status: status??this.status,
    errorMsg: errorMsg??this.errorMsg
  );
}