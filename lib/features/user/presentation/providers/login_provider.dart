import 'package:bimarestan_doctors/core/state_management/view_state.dart';
import 'package:bimarestan_doctors/core/utils/dialogs.dart';
import 'package:bimarestan_doctors/routes/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../core/services/snack_bar_service.dart';
import '../../../../locator/locator.dart';
import '../../data/models/login_request_model.dart';
import '../../data/repositories/user_repository.dart';

@injectable
class LoginProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  final _userRepository = locator<UserRepository>();
  final _snackBarService = locator<SnackBarService>();
  final _navigationService = locator<NavigationService>();

  void submit() async {
    print('email: ${email.text}');
    print('password: ${password.text}');
    if (formKey.currentState!.validate()) {
      showLoadingDialog();
      final successOrFailure = await _userRepository.login(
        loginRequestModel: LoginRequestModel(
          username: email.text,
          password: password.text,
        ),
      );
      successOrFailure.fold(
        (failure) {
          dismissLoadingDialog();
          _snackBarService.showErrorSnackBar(failure.msg);
        },
        (success) {
          dismissLoadingDialog();
          // _navigationService.pushNamedAndRemoveUntil(Routes.home);
        },
      );
    }
  }
}
