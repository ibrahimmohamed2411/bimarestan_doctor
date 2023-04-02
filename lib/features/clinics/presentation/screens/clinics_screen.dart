import 'package:bimarestan_doctors/core/shared/app_elevated_button.dart';
import 'package:bimarestan_doctors/features/clinics/presentation/providers/clinics_provider.dart';
import 'package:bimarestan_doctors/features/user/data/datasources/user_local_data_source.dart';
import 'package:bimarestan_doctors/locator/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:intl/intl.dart';
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
      BuildContext context) {
    return showBottomSheet(
      context: context,
      builder: (context) {
        return Consumer<ClinicsProvider>(
          builder: (context, model, child) => Container(
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: model.name,
                    decoration: InputDecoration(
                      hintText: 'Clinic name',
                    ),
                    validator: FormBuilderValidators.required(),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(
                    height: 10.h,
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
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormField(
                    controller: model.description,
                    decoration: InputDecoration(
                      hintText: 'Description',
                    ),
                    validator: FormBuilderValidators.required(),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  InternationalPhoneNumberInput(
                    textFieldController: model.phone,
                    inputDecoration: const InputDecoration(
                      labelText: 'Clinic phone number',
                    ),
                    onInputChanged: model.phoneNumberChanged,
                    selectorConfig: const SelectorConfig(
                      selectorType: PhoneInputSelectorType.DIALOG,
                      setSelectorButtonAsPrefixIcon: true,
                      leadingPadding: 8,
                    ),
                    countries: const ['EG'],
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: (p0) {
                      return model.validPhoneNumber
                          ? null
                          : 'Invalid phone number';
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Working days',
                    style: TextStyle(
                      fontSize: 20.sp,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    padding: EdgeInsets.all(5.r),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    height: 100.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: model.days.length,
                      itemBuilder: (context, index) => RawChip(
                        showCheckmark: false,
                        labelStyle: TextStyle(
                          color: model.selectedDays.contains(index)
                              ? Colors.red
                              : Colors.black,
                        ),
                        selected: model.selectedDays.contains(index),
                        onPressed: () => model.onDaySelected(index),
                        label: Text(
                          model.days[index],
                        ),
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        width: 10.w,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Working hours',
                    style: TextStyle(
                      fontSize: 20.sp,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () async {
                          final time = await showTimePicker(
                              context: context, initialTime: TimeOfDay.now());
                          model.onStartWorkChanged(time);
                        },
                        child: Text(
                          model.startWork == null
                              ? 'From'
                              : DateFormat.Hm().format(DateTime(
                                  2021,
                                  1,
                                  1,
                                  model.startWork!.hour,
                                  model.startWork!.minute)),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          final time = await showTimePicker(
                              context: context, initialTime: TimeOfDay.now());
                          model.onEndWorkChanged(time);
                        },
                        child: Text(
                          model.endWork == null
                              ? 'To'
                              : DateFormat.Hm().format(
                                  DateTime(
                                    2021,
                                    1,
                                    1,
                                    model.endWork!.hour,
                                    model.endWork!.minute,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  AppElevatedButton(
                    onPressed: () {
                      model.addClinic();
                    },
                    child: Text('Add'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
