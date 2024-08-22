import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:metrogeniusapp/services/auth.dart';
import 'package:metrogeniusapp/services/auth_signin.dart';

part 'user_signup_event.dart';
part 'user_signup_state.dart';

class UserSignupBloc extends Bloc<UserSignupEvent, UserSignupState> {
  UserSignupBloc(this._authRepo) : super(UserSignupState()) {
    on<EmailChanges>(emailChanged);
    on<PassChanges>(passChanges);
    on<UserNameChanges>(nameChanges);
    on<UserImageChanges>(imageChanges);
    on<UpdateFormSubmit>(udpateFormSubmit);
    on<FormSubmit>(formSubmit);
  }

  final AuthRepo _authRepo;

  void emailChanged(EmailChanges event, Emitter<UserSignupState> emit) {
    final newValueForEmail = event.email;
    final newState = state.copyWith(email: newValueForEmail);
    emit(newState);
  }

  void passChanges(PassChanges event, Emitter<UserSignupState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void nameChanges(UserNameChanges event, Emitter<UserSignupState> emit) {
    emit(state.copyWith(userName: event.userName));
    print(event.userName);
  }

  void imageChanges(UserImageChanges event, Emitter<UserSignupState> emit) {
    emit(state.copyWith(userImage: event.userImage));
    print(event.userImage);
  }

  Future<void> formSubmit(
      FormSubmit event, Emitter<UserSignupState> emit) async {
    //check for empty values
    final email = state.email;
    final pass = state.password;
    if (email.isEmpty || pass.isEmpty) return;
    final user = await _authRepo.createUserWithUsernamePassword(email, pass);
    final userDetails = UserSigninAuth().userDetailsInfo(
        id: FirebaseAuth.instance.currentUser!.uid,
        cpass: pass,
        email: email,
        name: state.userName,
        image: state.userImage);
    final added = UserSigninAuth()
        .userDetails(userDetails, FirebaseAuth.instance.currentUser!.uid);
    if (added == true) {
      print('UserDetailsCollected');
    }
    print(user);
    if (user != null) {
      emit(state.copyWith(status: FormStatus.success));
    }
  }
        Future<void> udpateFormSubmit(UpdateFormSubmit event, Emitter<UserSignupState> emit) async{
          final added=await UserSigninAuth().updatedUserDetails(FirebaseAuth.instance.currentUser!.uid, state.userName, state.userImage);
          print(state.userImage);
          print(state.userName);
          if(added==true){
            print('Details Updated');
          }else{
            print('Not updated');
          }
  }
}
