

import 'package:bloc/bloc.dart';
import 'package:metrogeniusapp/services/auth_signin.dart';

part 'frogot_password_event.dart';
part 'frogot_password_state.dart';

class FrogotPasswordBloc extends Bloc<FrogotPasswordEvent, FrogotPasswordState> {
  FrogotPasswordBloc() : super(FrogotPasswordState()) {
   on<UserEmailChanges>(_passChanges);
   on<PassFormSubmit>(_formSubmit);

  }
void _passChanges(UserEmailChanges event,Emitter<FrogotPasswordState>emit){
  emit(state.copyWith(email: event.email));
}
void _formSubmit(PassFormSubmit event,Emitter<FrogotPasswordState>emit)async{
  emit(state.copyWith(status: UserFormStatus.inital));
  try {
   final emailsent=await UserSigninAuth().forogotPasswordRest(state.email!);
   if(emailsent){
    emit(state.copyWith(status: UserFormStatus.sucess));
   }
  } catch (e) {
    emit(state.copyWith(status: UserFormStatus.error));
  }
}
}
