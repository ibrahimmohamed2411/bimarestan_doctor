import 'package:bimarestan_doctors/constants/assets.dart';
import 'package:bimarestan_doctors/core/resources/color_manager.dart';
import 'package:bimarestan_doctors/core/shared/app_elevated_button.dart';
import 'package:bimarestan_doctors/core/utils/functions/show_image_bottom_sheet.dart';
import 'package:bimarestan_doctors/features/user/data/models/category_model.dart';
import 'package:bimarestan_doctors/features/user/presentation/providers/sign_up_provider.dart';
import 'package:bimarestan_doctors/locator/locator.dart';
import 'package:bimarestan_doctors/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

import '../../../../core/shared/custom_circular_form_field.dart';
import '../../../../core/shared/password_text_form_field.dart';

class SignUpScreen extends StatelessWidget {
  final CategoryModel categoryModel;
  const SignUpScreen({super.key, required this.categoryModel});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpProvider>(
      create: (context) => locator(),
      child: Scaffold(
        body: ColoredBox(
          color: ColorManager.primary,
          child: SafeArea(
            child: ColoredBox(
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 210.h,
                      color: ColorManager.primary,
                      child: Image.asset(
                        Assets.assetsImagesLogoWhite,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 42.w),
                      child: Consumer<SignUpProvider>(
                        builder: (context, model, _) {
                          return Form(
                            key: model.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 16.h),
                                TextFormField(
                                  controller: model.name,
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
                                  controller: model.email,
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
                                SizedBox(height: 4.h),
                                PasswordTextFormField(
                                  controller: model.password,
                                  labelText: 'Password',
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                    FormBuilderValidators.minLength(8),
                                  ]),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                                SizedBox(height: 4.h),
                                // InternationalPhoneNumberInput(
                                //   textFieldController: model.phone,
                                //   inputDecoration: const InputDecoration(
                                //       labelText: 'Phone number'),
                                //   onInputChanged: model.phoneNumberChanged,
                                //   selectorConfig: const SelectorConfig(
                                //     selectorType: PhoneInputSelectorType.DIALOG,
                                //     setSelectorButtonAsPrefixIcon: true,
                                //     leadingPadding: 8,
                                //   ),
                                //   countries: const ['EG'],
                                //   autoValidateMode:
                                //       AutovalidateMode.onUserInteraction,
                                //   validator: (p0) {
                                //     return model.validPhoneNumber
                                //         ? null
                                //         : 'Invalid phone number';
                                //   },
                                // ),
                                // SizedBox(height: 4.h),
                                // TextFormField(
                                //   controller: model.age,
                                //   decoration: const InputDecoration(
                                //     labelText: 'Age',
                                //     alignLabelWithHint: true,
                                //   ),
                                //   validator: FormBuilderValidators.compose([
                                //     FormBuilderValidators.required(),
                                //     FormBuilderValidators.integer(),
                                //   ]),
                                //   autovalidateMode:
                                //       AutovalidateMode.onUserInteraction,
                                // ),
                                SizedBox(height: 4.h),
                                DropdownButtonFormField<Governance>(
                                  value: model.selectedGovernance,
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
                                  onChanged: model.governanceChanged,
                                  validator: FormBuilderValidators.required(),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                                InternationalPhoneNumberInput(
                                  textFieldController: model.phone,
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
                                // SizedBox(height: 4.h),
                                // TextFormField(
                                //   controller: model.,
                                //   decoration: const InputDecoration(
                                //     labelText: 'description',
                                //     alignLabelWithHint: true,
                                //   ),
                                //   maxLines: null,
                                //   keyboardType: TextInputType.multiline,
                                //   validator: FormBuilderValidators.required(),
                                //   autovalidateMode:
                                //       AutovalidateMode.onUserInteraction,
                                // ),
                                SizedBox(height: 32.h),
                                AppElevatedButton(
                                  height: 60.h,
                                  onPressed: () => model.submit(categoryModel),
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(fontSize: 20.sp),
                                  ),
                                ),
                                SizedBox(height: 32.h),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Governance {
  final int id;
  final String name;
  const Governance({
    required this.id,
    required this.name,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Governance && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

const governesses = [
  Governance(id: 1, name: "القاهرة"),
  Governance(id: 2, name: "الجيزة"),
  Governance(id: 3, name: "الأسكندرية"),
  Governance(id: 4, name: "الدقهلية"),
  Governance(id: 5, name: "البحر الأحمر"),
  Governance(id: 6, name: "البحيرة"),
  Governance(id: 7, name: "الفيوم"),
  Governance(id: 8, name: "الغربية"),
  Governance(id: 9, name: "الإسماعلية"),
  Governance(id: 10, name: "المنوفية"),
  Governance(id: 11, name: "المنيا"),
  Governance(id: 12, name: "القليوبية"),
  Governance(id: 13, name: "الوادي"),
  Governance(id: 14, name: "السويس"),
  Governance(id: 15, name: "اسوان"),
  Governance(id: 16, name: "اسيوط"),
  Governance(id: 17, name: "بني سويف"),
  Governance(id: 18, name: "بورسعيد"),
  Governance(id: 19, name: "دمياط"),
  Governance(id: 20, name: "الشرقية"),
  Governance(id: 21, name: "جنوب سيناء"),
  Governance(id: 22, name: "كفر الشيخ"),
  Governance(id: 23, name: "مطروح"),
  Governance(id: 24, name: "الأقصر"),
  Governance(id: 25, name: "قنا"),
  Governance(id: 26, name: "شمال سيناء"),
  Governance(id: 27, name: "سوهاج"),
];
