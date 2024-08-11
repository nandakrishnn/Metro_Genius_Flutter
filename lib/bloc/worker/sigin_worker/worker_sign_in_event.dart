part of 'worker_sign_in_bloc.dart';

@immutable
sealed class WorkerSignInEvent{}

final class WorkerEmailChanges extends WorkerSignInEvent{
  WorkerEmailChanges(this.email);
  final String email;
}

final class WorkerPassChanges extends WorkerSignInEvent{
  WorkerPassChanges(this.password);
  final String password;
}

final class WorkerFormSubmit extends WorkerSignInEvent{}