import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:register_app/Cubit/Login_cubit/login_cubit.dart';
import 'package:register_app/Cubit/Login_cubit/login_state.dart';
import 'package:register_app/Screen/home_page.dart';
import 'package:register_app/Screen/register_page.dart';
import 'package:register_app/Widgets/custom_button.dart';
import 'package:register_app/Widgets/custom_text_form_field.dart';
import 'package:register_app/Widgets/toast_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var login = BlocProvider.of<LoginCubit>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccessState) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return HomePage();
                      },
                    ),
                  );
                  CustomToastWidget.showSuccessToast("Success");
                } else if (state is LoginFailureState) {
                  CustomToastWidget.showErrorToast(state.errMessage);
                  log("Error: ${state.errMessage}");
                }
              },
              builder: (context, state) {
                return Form(
                  key: login.formKey,
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
                        controller: login.emailController,
                        border: outlineInputBorder(),
                        enabledBorder: outlineInputBorder(),
                        focusedBorder: outlineInputBorder(color: Colors.blue),
                        hintText: "Email",
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icon(Icons.email),
                      ),
                      SizedBox(height: 16.h),
                      CustomTextFormField(
                        controller: login.passwordController,
                        border: outlineInputBorder(),
                        enabledBorder: outlineInputBorder(),
                        focusedBorder: outlineInputBorder(color: Colors.blue),
                        hintText: "Password",
                        keyboardType: TextInputType.text,
                        prefixIcon: Icon(Icons.password),
                        obscureText: login.isObsecure,
                        suffixIcon: IconButton(
                          onPressed: () {
                            login.changePasswordVisibility();
                          },
                          icon: Icon(login.suffix),
                        ),
                      ),
                      SizedBox(height: 30.h),
                      CustomButton(
                        onTap: () {
                          if (login.formKey.currentState!.validate()) {
                            login.formKey.currentState!.save();
                            login.login();
                          }
                        },
                        width: double.infinity,
                        height: 45.h,
                        borderRadius: 8.r,
                        color: Colors.blue,
                        child: Center(
                          child: state is LoginLoadingState
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(),
                                )
                              : Text(
                                  "Login",
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
                            "Don't have an account?",
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.grey,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return RegisterPage();
                                  },
                                ),
                              );
                            },
                            child: Text(
                              " Register",
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
                );
              },
            ),
          ),
        ),
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
