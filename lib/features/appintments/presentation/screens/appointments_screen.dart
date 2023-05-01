import 'package:bimarestan_doctors/features/appintments/presentation/providers/appointments_provider.dart';
import 'package:bimarestan_doctors/features/appintments/presentation/widgets/appointments_calendar.dart';
import 'package:bimarestan_doctors/locator/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/state_management/view_state.dart';
import '../widgets/appointment_item.dart';

class AppointmentsScreen extends StatelessWidget {
  final int clinicId;
  const AppointmentsScreen({super.key, required this.clinicId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppointmentsProvider>(
      create: (context) => locator<AppointmentsProvider>()
        ..getAllAppointmentsByClinicIdAndDate(clinicId, DateTime.now()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Appointments'),
        ),
        body: Column(
          children: [
            AppointmentsCalendar(clinicId: clinicId),
            Divider(
              color: Theme.of(context).primaryColor,
            ),
            Expanded(
              child: Selector<AppointmentsProvider, ViewState>(
                selector: (context, model) => model.appointmentsState,
                builder: (context, appointmentsState, child) {
                  final model = context.read<AppointmentsProvider>();
                  switch (appointmentsState) {
                    case ViewState.initial:

                    case ViewState.loading:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case ViewState.error:
                      return const Center(
                        child: Text('Error'),
                      );
                    case ViewState.success:
                      final appointments = model.appointments;
                      if (appointments.isEmpty) {
                        return const Center(
                          child: Text('No Appointments'),
                        );
                      }

                      return ListView.builder(
                        itemCount: appointments.length,
                        itemBuilder: (context, index) {
                          final appointment = appointments[index];
                          return AppointmentItem(appointment: appointment);
                        },
                      );
                    // final app = [
                    //   Appointment(
                    //     appointmentDate: DateTime.now(),
                    //     cancelled: false,
                    //     clinicId: clinicId,
                    //     finish: true,
                    //     id: 1,
                    //     numPatient: 1,
                    //     patientFullName: 'Ibrahim Mohamed',
                    //     patientId: 1,
                    //     patientPhone: '+201060250112',
                    //     price: 123,
                    //     priceId: 1,
                    //     priceName: 'priceName',
                    //     time: 0,
                    //   ),
                    //   Appointment(
                    //     appointmentDate: DateTime.now(),
                    //     cancelled: true,
                    //     clinicId: clinicId,
                    //     finish: false,
                    //     id: 1,
                    //     numPatient: 1,
                    //     patientFullName: 'Abdallah Mekkawy',
                    //     patientId: 1,
                    //     patientPhone: '+201060250112',
                    //     price: 123,
                    //     priceId: 1,
                    //     priceName: 'priceName',
                    //     time: 0,
                    //   ),
                    // ];
                    // return ListView.builder(
                    //   itemCount: app.length,
                    //   itemBuilder: (context, index) {
                    //     final appointment = app[index];
                    //     return AppointmentItem(appointment: appointment);
                    //   },
                    // );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
