import 'package:bimarestan_doctors/features/profile/presentation/providers/profile_provider.dart';
import 'package:bimarestan_doctors/features/user/presentation/screens/sign_up_screen.dart';
import 'package:bimarestan_doctors/locator/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/shared/app_elevated_button.dart';
import '../../../../core/shared/password_text_form_field.dart';
import '../../../../core/state_management/view_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileProvider>(
      create: (context) => locator()..init(),
      child: Scaffold(
          body: ColoredBox(
        color: ColorManager.primary,
        child: SafeArea(
          child: ColoredBox(
            color: Colors.white,
            child: ProfileLoadedWidget(),
          ),
        ),
      )),
    );
  }
}

class ProfileLoadedWidget extends StatelessWidget {
  const ProfileLoadedWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, model, child) {
        switch (model.profileState) {
          case ViewState.initial:

          case ViewState.loading:
            return Center(
              child: CircularProgressIndicator(),
            );
          case ViewState.error:
            return Center(
              child: Text(model.msg),
            );
          case ViewState.success:
            return SingleChildScrollView(
              child: Form(
                key: model.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 180,
                      padding: EdgeInsets.all(16.r),
                      color: ColorManager.primary,
                      child: FittedBox(
                        child: CircleAvatar(
                          radius: 60.r,
                          backgroundImage: const NetworkImage(
                            'https://www.w3schools.com/howto/img_avatar.png',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 42.w),
                      child: Column(
                        children: [
                          TextFormField(
                            initialValue: model.profile.fullName,
                            onChanged: model.updateName,
                            decoration: const InputDecoration(
                              labelText: 'Name',
                              alignLabelWithHint: true,
                            ),
                            validator: FormBuilderValidators.required(),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          SizedBox(height: 4.h),
                          TextFormField(
                            onChanged: model.updateEmail,
                            initialValue: model.profile.email,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              alignLabelWithHint: true,
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.email(),
                            ]),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          // SizedBox(height: 4.h),
                          // PasswordTextFormField(

                          //   initialValue: model.profile.password,
                          //   labelText: 'Password',
                          //   validator: FormBuilderValidators.compose([
                          //     FormBuilderValidators.required(),
                          //     FormBuilderValidators.minLength(8),
                          //   ]),
                          //   autovalidateMode:
                          //       AutovalidateMode.onUserInteraction,
                          // ),
                          SizedBox(height: 4.h),
                          InternationalPhoneNumberInput(
                            inputDecoration: const InputDecoration(
                                labelText: 'Phone number'),
                            onInputChanged: model.phoneNumberChanged,
                            selectorConfig: const SelectorConfig(
                              selectorType: PhoneInputSelectorType.DIALOG,
                              setSelectorButtonAsPrefixIcon: true,
                              leadingPadding: 8,
                            ),
                            initialValue: model.phoneNumber,
                            countries: const ['EG'],
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (p0) {
                              return model.validPhoneNumber
                                  ? null
                                  : 'Invalid phone number';
                            },
                          ),
                          SizedBox(height: 4.h),

                          DropdownButtonFormField<Governance>(
                            value: model.selectedGovernate,
                            items: governesses
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e.name),
                                    ))
                                .toList(),
                            decoration: const InputDecoration(
                              labelText: 'Address',
                              alignLabelWithHint: true,
                            ),
                            onChanged: model.governateChanged,
                            validator: FormBuilderValidators.required(),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),

                          SizedBox(height: 32.h),
                          AppElevatedButton(
                            height: 60.h,
                            onPressed: model.submit,
                            child: Text(
                              'Update profile',
                              style: TextStyle(fontSize: 20.sp),
                            ),
                          ),
                          SizedBox(height: 32.h),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
        }
      },
    );
  }
}
