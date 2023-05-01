import 'package:bimarestan_doctors/features/clinics/data/models/clinic_model.dart';
import 'package:flutter/material.dart';


class UpdateClinicScreen extends StatefulWidget {
  final ClinicModel clinic;
  const UpdateClinicScreen({super.key, required this.clinic});

  @override
  State<UpdateClinicScreen> createState() => _UpdateClinicScreenState();
}

class _UpdateClinicScreenState extends State<UpdateClinicScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UpdateClinicScreen'),
      ),
    );
  }
}
