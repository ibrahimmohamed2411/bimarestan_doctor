import 'package:bimarestan_doctors/core/state_management/view_state.dart';
import 'package:bimarestan_doctors/core/utils/dialogs.dart';
import 'package:bimarestan_doctors/features/user/data/models/user_credentials_model.dart';
import 'package:bimarestan_doctors/features/user/presentation/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../core/services/snack_bar_service.dart';
import '../../../../locator/locator.dart';
import '../../../user/data/datasources/user_local_data_source.dart';
import '../../data/models/profile.dart';
import '../../data/repositories/profile_repository.dart';

@injectable
class ProfileProvider extends ChangeNotifier {
  final NavigationService _navigationService = locator<NavigationService>();
  final SnackBarService _snackBarService = locator<SnackBarService>();
  final _profileRepository = locator<ProfileRepository>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late Profile profile;
  String msg = '';
  PhoneNumber? phoneNumber;
  bool validPhoneNumber = false;
  Governance? selectedGovernance;
  ViewState profileState = ViewState.initial;
  void init() async {
    profileState = ViewState.loading;
    notifyListeners();
    final successOrFailure = await _profileRepository.getProfile();
    successOrFailure.fold((failure) {
      profileState = ViewState.error;
      msg = failure.msg;
      notifyListeners();
    }, (profile) {
      profileState = ViewState.success;
      this.profile = profile;
      phoneNumber = PhoneNumber(
        phoneNumber: profile.phone,
        isoCode: 'EGY',
      );
      selectedGovernance =
          governesses.firstWhere((element) => element.name == profile.address);
      notifyListeners();
    });
  }

  void updateName(String name) {
    profile = profile.copyWith(fullName: name);
    notifyListeners();
  }

  void updateEmail(String email) {
    profile = profile.copyWith(email: email);
    notifyListeners();
  }

  void updateGovernance(Governance governance) {
    selectedGovernance = governance;
    notifyListeners();
  }

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

  Future<void> submit() async {
    if (formKey.currentState!.validate()) {
      showLoadingDialog();
      final updatedProfile = profile.copyWith(
        phone: phoneNumber!.phoneNumber!,
        address: selectedGovernance!.name,
      );
      print(updatedProfile.toJson());
      final successOrFailure =
          await _profileRepository.updateProfile(updatedProfile);
      successOrFailure.fold((failure) {
        dismissLoadingDialog();
        _snackBarService.showErrorSnackBar(failure.msg);
      }, (success) {
        dismissLoadingDialog();
        _snackBarService.showSuccessSnackBar('Successfully updated');
      });
    }
  }

  void governanceChanged(Governance? value) {
    if (value != null) {
      selectedGovernance = value;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void logout() async {
    await RxSharedPreferences.getInstance().remove(USERCREDENTIALS);
  }
}
