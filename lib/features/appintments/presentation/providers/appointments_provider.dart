// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bimarestan_doctors/core/state_management/view_state.dart';
import 'package:bimarestan_doctors/features/appintments/data/models/appointment.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import 'package:bimarestan_doctors/features/appintments/data/repositories/appointments_repository.dart';

@injectable
class AppointmentsProvider extends ChangeNotifier {
  final AppointmentsRepository appointmentsRepository;
  DateTime? _selectedDay;
  List<Appointment> _appointments = [];
  List<Appointment> get appointments => _appointments;
  ViewState _appointmentsState = ViewState.initial;
  ViewState get appointmentsState => _appointmentsState;
  AppointmentsProvider({
    required this.appointmentsRepository,
  });
  DateTime? get selectedDay => _selectedDay;
  void setSelectedAppointmentDay(int clinicId, DateTime day) {
    _selectedDay = day;
    notifyListeners();
    getAllAppointmentsByClinicIdAndDate(clinicId, day);
  }

  Future<void> getAllAppointmentsByClinicIdAndDate(
      int ClinicId, DateTime date) async {
    _appointmentsState = ViewState.loading;
    notifyListeners();
    final successOrFailure = await appointmentsRepository
        .getAllAppointmentsByClinicIdAndDate(ClinicId, date);
    successOrFailure.fold(
      (failure) {
        _appointmentsState = ViewState.error;
        notifyListeners();
      },
      (appointments) {
        _appointments = appointments;
        _appointmentsState = ViewState.success;
        notifyListeners();
      },
    );
  }
}
