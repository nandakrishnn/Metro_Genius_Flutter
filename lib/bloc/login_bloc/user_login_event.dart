part of 'user_login_bloc.dart';

@immutable
sealed class UserLoginEvent{}

final class EmailChanges extends UserLoginEvent{
  EmailChanges(this.email);
  final String email;
}

final class PassChanges extends UserLoginEvent{
  PassChanges(this.password);
  final String password;
}

final class FormSubmit extends UserLoginEvent{}