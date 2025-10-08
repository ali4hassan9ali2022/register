import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:register_app/Cubit/Register_cubit/register_cubit.dart';
import 'package:register_app/Cubit/Register_cubit/register_state.dart';
import 'package:register_app/Screen/home_page.dart';
import 'package:register_app/Widgets/custom_button.dart';
import 'package:register_app/Widgets/custom_text_form_field.dart';
import 'package:register_app/Widgets/password_conditions_widget.dart';
import 'package:register_app/Widgets/toast_widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    var register = BlocProvider.of<RegisterCubit>(context);
    return Scaffold(
      body: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return HomePage();
                },
              ),
            );
            CustomToastWidget.showSuccessToast("Success");
          } else if (state is RegisterFailureState) {
            CustomToastWidget.showErrorToast(state.errMessage);
            log("Error: ${state.errMessage}");
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SingleChildScrollView(
                child: Form(
                  key: register.formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 50.h),
                      Text(
                        "Ali Hassan",
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 50.h),
                      CustomTextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Your Email";
                          }
                          return null;
                        },
                        controller: register.emailController,
                        border: outlineInputBorder(),
                        enabledBorder: outlineInputBorder(),
                        focusedBorder: outlineInputBorder(color: Colors.blue),
                        hintText: "Email",
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icon(Icons.email),
                      ),
                      SizedBox(height: 16.h),
                      CustomTextFormField(
                        onChanged: (value) {
                          register.checkPasswordStrength(value);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Your Password";
                          }
                          if (!register.passwordRegex.hasMatch(value)) {
                            return "Password does not meet all conditions";
                          }
                          return null;
                        },
                        controller: register.passwordController,
                        border: outlineInputBorder(),
                        enabledBorder: outlineInputBorder(),
                        focusedBorder: outlineInputBorder(color: Colors.blue),
                        hintText: "Password",
                        keyboardType: TextInputType.text,
                        prefixIcon: Icon(Icons.password),
                        obscureText: register.isObsecure,
                        suffixIcon: IconButton(
                          onPressed: () {
                            register.changePasswordVisibility();
                          },
                          icon: Icon(register.suffix),
                        ),
                      ),
                      SizedBox(height: 12.h),

                      PasswordConditionsWidget(register: register),
                      SizedBox(height: 16.h),
                      CustomTextFormField(
                        validator: (value) {
                          if (register
                                  .confirmPasswordController
                                  .text
                                  .characters !=
                              register.passwordController.text.characters) {
                            return "Passwords don't match";
                          }
                          return null;
                        },
                        controller: register.confirmPasswordController,
                        border: outlineInputBorder(),
                        enabledBorder: outlineInputBorder(),
                        focusedBorder: outlineInputBorder(color: Colors.blue),
                        hintText: "Confirm Password",
                        keyboardType: TextInputType.text,
                        prefixIcon: Icon(Icons.password),
                        obscureText: register.isObsecure,
                        suffixIcon: IconButton(
                          onPressed: () {
                            register.changePasswordVisibility();
                          },
                          icon: Icon(register.suffix),
                        ),
                      ),
                      SizedBox(height: 30.h),
                      CustomButton(
                        onTap: () {
                          if (register.formKey.currentState!.validate()) {
                            register.formKey.currentState!.save();
                            log("Email: ${register.emailController.text}");
                            log(
                              "Password: ${register.passwordController.text}",
                            );
                            register.register();
                          }
                        },
                        width: double.infinity,
                        height: 45.h,
                        borderRadius: 8.r,
                        color: Colors.blue,
                        child: Center(
                          child: state is RegisterLoadingState
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(),
                                )
                              : Text(
                                  "Register",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.43,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.grey,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              " Login",
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  OutlineInputBorder outlineInputBorder({Color? color}) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color ?? Colors.grey),
      borderRadius: BorderRadius.circular(8.r),
    );
  }
}
