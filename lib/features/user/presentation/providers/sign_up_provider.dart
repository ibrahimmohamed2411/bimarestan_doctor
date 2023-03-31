
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../core/services/snack_bar_service.dart';
import '../../../../locator/locator.dart';
import '../screens/sign_up_screen.dart';
@injectable
class SignUpProvider extends ChangeNotifier {
  final NavigationService _navigationService = locator<NavigationService>();
  final SnackBarService _snackBarService = locator<SnackBarService>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController phone = TextEditingController();
  // final TextEditingController address = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController description = TextEditingController();
  Governance? selectedGovernate;
  void governateChanged(Governance? value) {
    if (value != null) {
      selectedGovernate = value;
      notifyListeners();
    }
  }
}