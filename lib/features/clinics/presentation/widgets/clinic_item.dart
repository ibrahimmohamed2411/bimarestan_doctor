import 'package:bimarestan_doctors/features/clinics/data/models/clinic_model.dart';
import 'package:bimarestan_doctors/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../providers/clinics_provider.dart';

class ClinicItem extends StatelessWidget {
  final ClinicModel clinic;
  const ClinicItem({super.key, required this.clinic});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Slidable(
        key: UniqueKey(),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) =>
                  context.read<ClinicsProvider>().removeClinic(clinic),
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Card(
          child: ListTile(
            title: Text(clinic.name),
            trailing: PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text('Edit'),
                  value: 0,
                ),
                PopupMenuItem(
                  child: Text('Appointments'),
                  value: 1,
                ),
              ],
              onSelected: (value) {
                switch (value) {
                  case 0:
                    Navigator.of(context).pushNamed(
                      Routes.updateClinic,
                      arguments: clinic,
                    );
                    break;
                  case 1:
                    Navigator.of(context).pushNamed(
                      Routes.appointments,
                      arguments: clinic.id,
                    );
                    break;
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
