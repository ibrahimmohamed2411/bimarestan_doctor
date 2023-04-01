import 'package:bimarestan_doctors/features/clinics/presentation/providers/clinics_provider.dart';
import 'package:bimarestan_doctors/features/user/data/datasources/user_local_data_source.dart';
import 'package:bimarestan_doctors/locator/locator.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

import '../../../../core/state_management/view_state.dart';
import '../../../user/presentation/screens/sign_up_screen.dart';

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
                    AddClinicBottomSheet(context, model);
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
                    return ListTile(
                      title: Text(clinic.name),
                    );
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

  PersistentBottomSheetController<dynamic> AddClinicBottomSheet(
      BuildContext context, ClinicsProvider model) {
    return showBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: model.name,
                decoration: InputDecoration(
                  hintText: 'Clinic name',
                ),
              ),
              DropdownButtonFormField<Governance>(
                value: model.address,
                items: governesses
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.name),
                        ))
                    .toList(),
                decoration: const InputDecoration(
                  labelText: 'Address',
                  alignLabelWithHint: true,
                ),
                onChanged: model.governanceChanged,
                validator: FormBuilderValidators.required(),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              TextFormField(
                controller: model.description,
                decoration: InputDecoration(
                  hintText: 'Description',
                ),
              ),
              InternationalPhoneNumberInput(
                textFieldController: model.phone,
                inputDecoration:
                    const InputDecoration(labelText: 'Phone number'),
                onInputChanged: model.phoneNumberChanged,
                selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.DIALOG,
                  setSelectorButtonAsPrefixIcon: true,
                  leadingPadding: 8,
                ),
                countries: const ['EG'],
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (p0) {
                  return model.validPhoneNumber ? null : 'Invalid phone number';
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
