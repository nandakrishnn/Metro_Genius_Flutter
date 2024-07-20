import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:metrogeniusapp/services/auth_signin.dart';
part 'user_login_event.dart';
part 'user_login_state.dart';

class UserLoginBloc extends Bloc<UserLoginEvent,UserLoginState>{
UserLoginBloc(this._authRepo):super(UserLoginState()){
  on<EmailChanges>(emailChanged);
  on<PassChanges>(passChanges);
  on<FormSubmit>(formSubmit);
}
final UserSigninAuth _authRepo;

  void emailChanged(EmailChanges event, Emitter<UserLoginState> emit) {
    final newValueForEmail=event.email;
    final newState=state.copyWith(email: newValueForEmail);
    emit(newState);
  }
  void passChanges(PassChanges event, Emitter<UserLoginState> emit) {
    emit(state.copyWith(password: event.password));
  }
  Future<void> formSubmit(FormSubmit event, Emitter<UserLoginState> emit)async {
    //check for empty values
    final email=state.email;
    final pass=state.password;
    if(email.isEmpty||pass.isEmpty) {
      emit(state.copyWith(status: FormStatus.error, errorMsg: 'Email and password cannot be empty.'));
      return;
    }
 try {
      final user = await _authRepo.signInWithEmailAndPassword(email, pass);
      if (user != null) {
        emit(state.copyWith(status: FormStatus.sucess));
      } else {
        emit(state.copyWith(status: FormStatus.error, errorMsg: 'Login failed.'));
      }
    } catch (e) {
      emit(state.copyWith(status: FormStatus.error, errorMsg: e.toString()));
    }
  }
}