import 'package:bimarestan_doctors/features/clinics/data/models/clinic_model.dart';
import 'package:bimarestan_doctors/features/clinics/presentation/providers/clinics_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

import '../../../../core/shared/app_elevated_button.dart';
import '../../../user/presentation/screens/sign_up_screen.dart';

class UpdateClinicScreen extends StatefulWidget {
  final ClinicModel clinic;
  const UpdateClinicScreen({super.key, required this.clinic});

  @override
  State<UpdateClinicScreen> createState() => _UpdateClinicScreenState();
}

class _UpdateClinicScreenState extends State<UpdateClinicScreen> {
  late String name;
  late Governance address;
  late String phone;
  late String description;
  late List<int> worKingDays;
  late Set<int> selectedDays;
  late TimeOfDay startWork;
  late TimeOfDay endWork;
  final List<String> daysName = [
    'Sat',
    'Sun',
    'Mon',
    'Tues',
    'Wed',
    'Thurs',
    'Fri'
  ];
  @override
  void didChangeDependencies() {
    address = governesses
        .firstWhere((element) => element.name == widget.clinic.address);
    name = widget.clinic.name;
    phone = widget.clinic.phone;
    description = widget.clinic.description;
    worKingDays = widget.clinic.days;
    selectedDays = widget.clinic.days.map((e) => e).toSet();
    startWork = TimeOfDay.fromDateTime(
        DateTime(0).add(Duration(minutes: widget.clinic.startWork.toInt())));
    endWork = TimeOfDay.fromDateTime(
        DateTime(0).add(Duration(minutes: widget.clinic.endWork.toInt())));
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Clinic'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: name,
                onChanged: (value) => name = value,
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
                value: address,
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
                onChanged: (value) => address = value!,
                validator: FormBuilderValidators.required(),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              SizedBox(
                height: 10.h,
              ),
              TextFormField(
                initialValue: description,
                onChanged: (value) => description = value,
                decoration: InputDecoration(
                  hintText: 'Description',
                ),
                validator: FormBuilderValidators.required(),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              InternationalPhoneNumberInput(
                initialValue: PhoneNumber(isoCode: 'EG', phoneNumber: phone),
                inputDecoration: const InputDecoration(
                  labelText: 'Clinic phone number',
                ),
                onInputChanged: (value) => phone = value.phoneNumber!,
                selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.DIALOG,
                  setSelectorButtonAsPrefixIcon: true,
                  leadingPadding: 8,
                ),
                countries: const ['EG'],
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (p0) {
                  // return model.validPhoneNumber ? null : 'Invalid phone number';
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
                  itemCount: daysName.length,
                  itemBuilder: (context, index) => RawChip(
                    showCheckmark: false,
                    labelStyle: TextStyle(
                      color: selectedDays.contains(index)
                          ? Colors.red
                          : Colors.black,
                    ),
                    selected: selectedDays.contains(index),
                    onPressed: () {
                      setState(() {
                        if (selectedDays.contains(index)) {
                          selectedDays.remove(index);
                        } else {
                          selectedDays.add(index);
                        }
                      });
                    },
                    label: Text(
                      daysName[index],
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
                      if (time != null) {
                        setState(() {
                          startWork = time;
                        });
                      }
                      // model.onStartWorkChanged(time);
                    },
                    child: Text(
                      startWork == null
                          ? 'From'
                          : DateFormat.Hm().format(
                              DateTime(
                                  2021, 1, 1, startWork.hour, startWork.minute),
                            ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final time = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                      if (time != null) {
                        setState(() {
                          endWork = time;
                        });
                      }
                      // model.onEndWorkChanged(time);
                    },
                    child: Text(
                      endWork == null
                          ? 'To'
                          : DateFormat.Hm().format(
                              DateTime(
                                2021,
                                1,
                                1,
                                endWork.hour,
                                endWork.minute,
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
                  context.read<ClinicsProvider>().updateClinic(
                        widget.clinic.copyWith(
                          name: name,
                          address: address.name,
                          phone: phone,
                          description: description,
                          days: selectedDays.toList(),
                          startWork: startWork.hour * 60 + startWork.minute,
                          endWork: endWork.hour * 60 + endWork.minute,
                        ),
                      );
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
