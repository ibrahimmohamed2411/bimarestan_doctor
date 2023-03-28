
import 'package:bimarestan_doctors/constants/assets.dart';
import 'package:bimarestan_doctors/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/shared/app_elevated_button.dart';
import '../../../../core/shared/password_text_form_field.dart';
import '../../../../locator/locator.dart';
import '../providers/login_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginProvider>(
      create: (context) => locator(),
      child: Scaffold(
        body: ColoredBox(
          color: ColorManager.primary,
          child: SafeArea(
            child: ColoredBox(
              color: Colors.white,
              child: SingleChildScrollView(
                child: Consumer<LoginProvider>(builder: (context, model, _) {
                  return Form(
                    key: model.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 210.h,
                          color: ColorManager.primary,
                          child: Image.asset(
                            Assets.assetsImagesLogo,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 48.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 74.h),
                              Text(
                                'Email address',
                                style: TextStyle(fontSize: 18.sp),
                              ),
                              SizedBox(height: 28.h),
                              TextFormField(
                                controller: model.email,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.person),
                                  hintText: 'Type your email',
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                  FormBuilderValidators.email(),
                                ]),
                              ),
                              SizedBox(height: 28.h),
                              Text(
                                'Password',
                                style: TextStyle(fontSize: 18.sp),
                              ),
                              SizedBox(height: 28.h),
                              PasswordTextFormField(
                                controller: model.password,
                                prefixIcon: const Icon(Icons.lock),
                                hintText: 'Type your password',
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                  FormBuilderValidators.minLength(8),
                                
                                  FormBuilderValidators.minLength(6),
                                ]),
                              ),
                              SizedBox(height: 60.h),
                              AppElevatedButton(
                                height: 60.h,
                                onPressed: model.submit,
                                child: Text(
                                  'Login',
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),
                              SizedBox(height: 20.h),
                              InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Text(
                                    'Forgot password?',
                                    style: TextStyle(fontSize: 18.sp),
                                  ),
                                ),
                              ),
                              SizedBox(height: 35.h),
                              Row(
                                children: [
                                  const Text('don\'t have an account?'),
                                  const SizedBox(width: 8),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushNamed(Routes.signUp);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Text(
                                        'Sign Up',
                                        style: TextStyle(
                                          fontSize: 24.sp,
                                          color: ColorManager.primary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
