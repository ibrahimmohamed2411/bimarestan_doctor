import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:bimarestan_doctors/features/appintments/presentation/providers/appointments_provider.dart';

class AppointmentsCalendar extends StatelessWidget {
  final int clinicId;
  const AppointmentsCalendar({super.key, required this.clinicId});

  @override
  Widget build(BuildContext context) {
    return Selector<AppointmentsProvider, DateTime?>(
      selector: (context, model) => model.selectedDay,
      builder: (context, selectedDay, child) {
        final model = context.read<AppointmentsProvider>();
        return TableCalendar(
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
          calendarStyle: CalendarStyle(
            tablePadding: EdgeInsets.symmetric(horizontal: 8.w),
            cellPadding: const EdgeInsets.all(2),
          ),
          firstDay: DateTime.now(),
          lastDay: DateTime.now().add(const Duration(days: 30)),
          focusedDay: selectedDay ?? DateTime.now(),
          calendarFormat: CalendarFormat.week,
          rowHeight: 62.h,
          // selectedDayPredicate: model.selectedDayPredicate,
          onDaySelected: (selectedDay, focusedDay) =>
              model.setSelectedAppointmentDay(clinicId, selectedDay),
          selectedDayPredicate: (date) => isSameDay(model.selectedDay, date),
        );
      },
    );
  }
}
