part of 'frogot_password_bloc.dart';

sealed class FrogotPasswordEvent {}

final class UserEmailChanges extends FrogotPasswordEvent{
  UserEmailChanges(this.email);
  final String email;
}
final class PassFormSubmit extends FrogotPasswordEvent{}