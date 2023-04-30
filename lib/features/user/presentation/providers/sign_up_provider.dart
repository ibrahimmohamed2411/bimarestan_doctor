// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bimarestan_doctors/core/utils/dialogs.dart';
import 'package:bimarestan_doctors/features/user/data/models/category_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:bimarestan_doctors/features/user/data/models/sign_up_request_model.dart';

import '../../../../core/services/notification_service.dart';
import '../../../../core/services/snack_bar_service.dart';
import '../../../../locator/locator.dart';
import '../../data/repositories/user_repository.dart';
import '../screens/sign_up_screen.dart';

@injectable
class SignUpProvider extends ChangeNotifier {
  final NavigationService _navigationService = locator<NavigationService>();
  final SnackBarService _snackBarService = locator<SnackBarService>();
  final userRepository = locator<UserRepository>();
  final notificationService = locator<NotificationService>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController phone = TextEditingController();
  PhoneNumber? phoneNumber;

  bool validPhoneNumber = false;
  Governance? selectedGovernance;
  void phoneNumberChanged(PhoneNumber phoneNumber) {
    this.phoneNumber = phoneNumber;

    final validPhoneNumber = (phoneNumber.phoneNumber!.startsWith('+2015') ||
            phoneNumber.phoneNumber!.startsWith('+2010') ||
            phoneNumber.phoneNumber!.startsWith('+2011') ||
            phoneNumber.phoneNumber!.startsWith('+2012')) &&
        phoneNumber.phoneNumber!.length == 13;

    this.validPhoneNumber = validPhoneNumber;
    notifyListeners();
  }

  void governanceChanged(Governance? value) {
    if (value != null) {
      selectedGovernance = value;
      notifyListeners();
    }
  }

  void submit(CategoryModel categoryModel) async {
    if (formKey.currentState!.validate() && selectedGovernance != null) {
      showLoadingDialog();
      final token = await notificationService.getFCMToken();
      debugPrint('token: $token');
      final successOrFailure = await userRepository.signUp(
        signUpRequestModel: SignUpRequestModel(
          address: selectedGovernance!.name,
          fullName: name.text,
          email: email.text,
          fireBaseToken: token!,
          password: password.text,
          roleId: 1,
          categoryName: categoryModel.name,
          categoryId: categoryModel.id,
          phone: phoneNumber!.phoneNumber!,
        ),
      );
      successOrFailure.fold((failure) {
        dismissLoadingDialog();
        _snackBarService.showErrorSnackBar(
          failure.msg,
        );
      }, (_) {
        dismissLoadingDialog();
        _navigationService.back();
      });
    } else {}
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();

    super.dispose();
  }
}
