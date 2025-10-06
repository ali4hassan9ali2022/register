import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_app/Cubit/Register_cubit/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  Future<void> register() async {
    emit(RegisterLoadingState());
    try {
      var user = FirebaseAuth.instance;
      UserCredential credential = await user.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      log("Success: ${credential.user}");
      emit(RegisterSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(
          RegisterFailureState(
            errMessage: "The password provided is too weak.",
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        emit(
          RegisterFailureState(
            errMessage: "The account already exists for that email.",
          ),
        );
      }
    } catch (e) {
      emit(RegisterFailureState(errMessage: "Error"));
    }
  }
}
