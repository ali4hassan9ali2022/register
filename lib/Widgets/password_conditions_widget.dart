import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:register_app/Cubit/Register_cubit/register_cubit.dart';

class PasswordConditionsWidget extends StatelessWidget {
  const PasswordConditionsWidget({super.key, required this.register});
  final RegisterCubit register;
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBar(register.hasMinLength),
              _buildBar(register.hasUpperCase),
              _buildBar(register.hasLowerCase),
              _buildBar(register.hasNumber),
              _buildBar(register.hasSpecialChar),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("6+"),
              Text("Upper"),
              Text("Lower"),
              Text("Num"),
              Text("@#%"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBar(bool isValid) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      width: 60.w,
      height: 8.h,
      decoration: BoxDecoration(
        color: isValid ? Colors.green : Colors.grey.withAlpha(80),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
