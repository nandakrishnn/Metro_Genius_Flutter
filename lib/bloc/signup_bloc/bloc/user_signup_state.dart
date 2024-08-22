part of 'user_signup_bloc.dart';


enum FormStatus {
  inital,
  pending,
  success,
  error,
}

@immutable
final class UserSignupState {
  UserSignupState({
     this.email="",
   this.password="",
      this.userName='',
  this.status=FormStatus.inital,
    this.errorMsg,
    this.userImage='',
  });
  final String email;
  final String password;
  final String userName;
  final FormStatus status;
  final String userImage;
  final String? errorMsg;

  UserSignupState copyWith({
    String? email,
    String?userName,
    String?userImage,
    String? password,
    FormStatus? status,
    String? errorMsg,
  }) =>
      UserSignupState(
        userImage: userImage??this.userImage,
        userName: userName??this.userName,
          email: email ?? this.email,
          password: password ?? this.password,
          status: status ?? this.status,
          errorMsg: errorMsg ?? this.errorMsg);
}