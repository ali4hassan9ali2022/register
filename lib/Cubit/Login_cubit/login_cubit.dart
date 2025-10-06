import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_app/Cubit/Login_cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  login() async {
    emit(LoginLoadingState());
    try {
      var user = FirebaseAuth.instance;
      UserCredential credential = await user.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      log("User: ${credential.user}");
      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailureState(errMessage: "No user found for that email."));
      } else if (e.code == 'wrong-password') {
        emit(
          LoginFailureState(
            errMessage: "Wrong password provided for that user.",
          ),
        );
      }
    } catch (e) {
      emit(LoginFailureState(errMessage: "Error"));
    }
  }
}
