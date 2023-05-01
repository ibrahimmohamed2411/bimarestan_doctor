import 'package:bimarestan_doctors/features/clinics/presentation/providers/clinics_provider.dart';
import 'package:bimarestan_doctors/features/clinics/presentation/widgets/clinic_item.dart';
import 'package:bimarestan_doctors/locator/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/state_management/view_state.dart';
import '../../../../core/utils/dialogs.dart';

class ClinicsScreen extends StatelessWidget {
  const ClinicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ClinicsProvider>(
      create: (context) => locator()..getAllClinicsByDoctorId(),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          title: Text('Clinics'),
          actions: [
            Consumer<ClinicsProvider>(
              builder: (context, model, child) {
                return IconButton(
                  onPressed: () {
                    AddClinicBottomSheet(context);
                  },
                  icon: Icon(Icons.add),
                );
              },
            ),
          ],
        ),
        body: Consumer<ClinicsProvider>(
          builder: (context, model, child) {
            switch (model.clinicState) {
              case ViewState.initial:
              case ViewState.loading:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case ViewState.success:
                if (model.clinics.isEmpty) {
                  return Center(
                    child: Text('No clinics'),
                  );
                }
                return ListView.builder(
                  itemCount: model.clinics.length,
                  itemBuilder: (context, index) {
                    final clinic = model.clinics[index];
                    return ClinicItem(clinic: clinic);
                  },
                );
              case ViewState.error:
                return Center(
                  child: Text('error'),
                );
            }
          },
        ),
      ),
    );
  }
}
