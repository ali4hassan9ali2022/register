import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_app/Cubit/Register_cubit/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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

  IconData suffix = Icons.visibility_off_outlined;
  bool isObsecure = true;
  void changePasswordVisibility() {
    isObsecure = !isObsecure;

    suffix = isObsecure
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    emit(ChangePassworsVisibailitystate());
  }
final passwordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@#$%^])[A-Za-z\d@#$%^]{6,}$',
    );
bool hasUpperCase = false;
bool hasLowerCase = false;
bool hasNumber = false;
bool hasSpecialChar = false;
bool hasMinLength = false;

void checkPasswordStrength(String password) {
  hasUpperCase = password.contains(RegExp(r'[A-Z]'));
  hasLowerCase = password.contains(RegExp(r'[a-z]'));
  hasNumber = password.contains(RegExp(r'[0-9]'));
  hasSpecialChar = password.contains(RegExp(r'[@#$%^]'));
  hasMinLength = password.length >= 6;

  emit(ChangePassworsVisibailitystate()); // نستخدم نفس الستيت عشان نعمل rebuild
}
}
