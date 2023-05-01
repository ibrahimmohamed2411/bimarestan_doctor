import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../data/models/appointment.dart';
class AppointmentItem extends StatelessWidget {
  const AppointmentItem({
    super.key,
    required this.appointment,
  });

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          appointment.patientFullName,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          DateFormat.jm().format(appointment.appointmentDate),
        ),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Status'),
            Text(
              appointment.cancelled
                  ? 'Canceled'
                  : appointment.finish
                      ? 'Finished'
                      : 'Not Finished',
              style: TextStyle(
                color: appointment.finish ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
