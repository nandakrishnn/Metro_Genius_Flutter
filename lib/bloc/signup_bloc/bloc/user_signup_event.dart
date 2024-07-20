part of 'user_signup_bloc.dart';

@immutable
sealed class UserSignupEvent{}

final class EmailChanges extends UserSignupEvent{
  EmailChanges(this.email);
  final String email;
}

final class PassChanges extends UserSignupEvent{
  PassChanges(this.password);
  final String password;
}

final class FormSubmit extends UserSignupEvent{}