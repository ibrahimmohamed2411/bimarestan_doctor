// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bimarestan_doctors/core/utils/dialogs.dart';
import 'package:bimarestan_doctors/features/user/data/models/category_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
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
  // final notificationService = locator<NotificationService>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController phone = TextEditingController();
  Governance? selectedGovernance;
  
  void governanceChanged(Governance? value) {
    if (value != null) {
      selectedGovernance = value;
      notifyListeners();
    }
  }

  void submit(CategoryModel categoryModel) async {
    if (formKey.currentState!.validate() && selectedGovernance != null) {
      showLoadingDialog();
      // final token = await notificationService.getFCMToken();
      final successOrFailure = await userRepository.signUp(
        signUpRequestModel: SignUpRequestModel(
          address: selectedGovernance!.name,
          name: name.text,
          email: email.text,
          fireBaseToken: 'FirebaseToken', //TODO: Change this
          password: password.text,
          roleId: 1,
          categoryName: categoryModel.name,
          categoryId: categoryModel.id,
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
}
