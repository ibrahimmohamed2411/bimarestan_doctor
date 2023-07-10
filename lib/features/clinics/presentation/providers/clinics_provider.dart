import 'package:bimarestan_doctors/core/state_management/view_state.dart';
import 'package:bimarestan_doctors/core/utils/dialogs.dart';
import 'package:bimarestan_doctors/features/clinics/data/models/clinic_model.dart';
import 'package:bimarestan_doctors/locator/locator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../core/services/snack_bar_service.dart';
import '../../../user/data/datasources/user_local_data_source.dart';
import '../../../user/presentation/screens/sign_up_screen.dart';
import '../../data/repositories/clinics_repository.dart';

@injectable
class ClinicsProvider extends ChangeNotifier {
  final ClinicsRepository repository = locator<ClinicsRepository>();
  final _navigationService = locator<NavigationService>();
  final _snackBar = locator<SnackBarService>();
  ViewState clinicState = ViewState.loading;
  List<ClinicModel> clinics = [];

  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController description = TextEditingController();
  Governance? address;
  TimeOfDay? startWork;
  TimeOfDay? endWork;
  Set<int> selectedDays = {};
  List<String> days = [
    'Sat',
    'Sun',
    'Mon',
    'Tues',
    'Wed',
    'Thurs',
    'Fri',
  ];

  PhoneNumber? phoneNumber;
  bool validPhoneNumber = false;

  void onStartWorkChanged(TimeOfDay? start) {
    if (start != null) {
      startWork = start;
      notifyListeners();
    }
  }

  void onEndWorkChanged(TimeOfDay? end) {
    if (end != null) {
      endWork = end;
      notifyListeners();
    }
  }

  double convertDateToDouble(TimeOfDay date) {
    return date.hour + date.minute / 100;
  }

  void addClinic() async {
    final _user = await locator<UserLocalDataSource>().getUserCredentials();

    final clinic = ClinicModel(
      name: name.text,
      phone: phone.text,
      days: selectedDays.toList(),
      doctorId: _user!.id,
      // id: 0,
      description: description.text,
      address: address!.name,
      startWork: convertDateToDouble(startWork!),
      endWork: convertDateToDouble(endWork!),
    );
    final successOrFailure = await repository.addClinic(clinic);
    successOrFailure.fold((failure) {
      dismissLoadingDialog();
      _snackBar.showErrorSnackBar(failure.msg);
    }, (addedClinic) {
      clinics.add(clinic);
      dismissLoadingDialog();
      _navigationService.back();
      _snackBar.showSuccessSnackBar('Clinic added successfully');
    });
    clearFields();
    notifyListeners();
  }

  void clearFields() {
    name.clear();
    address = null;
    description.clear();
    phone.clear();
    startWork = null;
    endWork = null;
    selectedDays = {};
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

  void governanceChanged(Governance? value) {
    if (value != null) {
      address = value;
      notifyListeners();
    }
  }

  void onDaySelected(int index) {
    if (selectedDays.contains(index)) {
      selectedDays.remove(index);
    } else {
      selectedDays.add(index);
    }
    notifyListeners();
  }

  Future<void> getAllClinicsByDoctorId() async {
    if (clinicState != ViewState.loading) {
      clinicState = ViewState.loading;
      notifyListeners();
    }
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

  Future<void> removeClinic(ClinicModel clinic) async {
    clinics.remove(clinic);
    notifyListeners();
    final successOrFailure = await repository.removeClinic(clinic);
    successOrFailure.fold((failure) {
      _snackBar.showErrorSnackBar(failure.msg);
    }, (_) {
      _snackBar.showSuccessSnackBar('Clinic removed successfully');
    });
  }

  Future<void> updateClinic(ClinicModel clinic) async {
    final item = clinics.firstWhere((element) => element.id == clinic.id);
    final index = clinics.indexOf(item);
    clinics[index] = clinic;
    notifyListeners();
    final successOrFailure = await repository.updateClinic(clinic);
    successOrFailure.fold((failure) {
      _snackBar.showErrorSnackBar(failure.msg);
    }, (_) {
      _navigationService.back();
      _snackBar.showSuccessSnackBar('Clinic updated successfully');
    });
  }
}
