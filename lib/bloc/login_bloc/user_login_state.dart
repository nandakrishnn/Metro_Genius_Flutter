part of 'user_login_bloc.dart';

enum FormStatus{
  inital,
  pending,
  sucess,
  error
}
@immutable
final class UserLoginState{
  UserLoginState({
 this.email="",
   this.password="",
  this.status=FormStatus.inital,
    this.errorMsg,
  });
   final String email;
  final String password;
  final FormStatus status;
  final String? errorMsg;

  UserLoginState copyWith({
       String? email,
    String? password,
    FormStatus? status,
    String? errorMsg,
  })=> UserLoginState(
          email: email ?? this.email,
          password: password ?? this.password,
          status: status ?? this.status,
          errorMsg: errorMsg ?? this.errorMsg);
}