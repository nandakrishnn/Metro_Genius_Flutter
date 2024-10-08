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
final class UserNameChanges extends UserSignupEvent{
  UserNameChanges(this.userName);
  final String userName;
}
final class UserImageChanges extends UserSignupEvent{
  UserImageChanges(this.userImage);
  final String userImage;
}
final class UpdateFormSubmit extends UserSignupEvent{}
final class FormSubmit extends UserSignupEvent{}