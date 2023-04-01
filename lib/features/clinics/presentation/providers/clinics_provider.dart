import 'package:bimarestan_doctors/core/state_management/view_state.dart';
import 'package:bimarestan_doctors/features/clinics/data/models/clinic_model.dart';
import 'package:bimarestan_doctors/locator/locator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../user/presentation/screens/sign_up_screen.dart';
import '../../data/repositories/clinics_repository.dart';

@injectable
class ClinicsProvider extends ChangeNotifier {
  final ClinicsRepository repository = locator<ClinicsRepository>();
  ViewState clinicState = ViewState.initial;
  List<ClinicModel> clinics = [];

  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController description = TextEditingController();
  Governance? address;
  List<int>? days;
  double? startWork;
  double? endWork;
  PhoneNumber? phoneNumber;
  bool validPhoneNumber = false;
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
      address = value;
      notifyListeners();
    }
  }

  Future<void> getAllClinicsByDoctorId() async {
    clinicState = ViewState.loading;
    notifyListeners();
    final response = await repository.getAllClinicsByDoctorId();
    response.fold((failure) {
      clinicState = ViewState.error;
      notifyListeners();
    }, (clinicsList) {
      clinics = clinicsList;
      clinicState = ViewState.success;
      notifyListeners();
    });
  }
}
