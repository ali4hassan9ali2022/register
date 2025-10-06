import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:register_app/Widgets/custom_button.dart';
import 'package:register_app/Widgets/custom_text_form_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
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
                  border: outlineInputBorder(),
                  enabledBorder: outlineInputBorder(),
                  focusedBorder: outlineInputBorder(color: Colors.blue),
                  hintText: "Email",
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icon(Icons.email),
                ),
                SizedBox(height: 16.h),
                CustomTextFormField(
                  border: outlineInputBorder(),
                  enabledBorder: outlineInputBorder(),
                  focusedBorder: outlineInputBorder(color: Colors.blue),
                  hintText: "Password",
                  keyboardType: TextInputType.text,
                  prefixIcon: Icon(Icons.password),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.visibility_off),
                  ),
                ),
                SizedBox(height: 30.h),
                CustomButton(
                  width: double.infinity,
                  height: 45.h,
                  borderRadius: 8.r,
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.43),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(fontSize: 18.sp, color: Colors.grey),
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
  }
  OutlineInputBorder outlineInputBorder({Color? color}) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color ?? Colors.grey),
      borderRadius: BorderRadius.circular(8.r),
    );
  }
}