// import 'package:flutter/material.dart';
// import 'package:injectable/injectable.dart';

// import '../../core/state_management/view_state.dart';
// import '../../data/doctors/doctors_repository.dart';
// import '../../locator/locator.dart';
// import '../../models/doctors/get_doctors_request.dart';
// import '../../models/profiles/profile.dart';
// import '../../models/specialities/speciality.dart';

// @injectable
// class DoctorsChatsViewModel extends ChangeNotifier {
//   final DoctorsRepository _repository = locator<DoctorsRepository>();

//   ViewState viewState = ViewState.loading;
//   List<Profile> doctors = [];
//   Future<void> init(
//     String address,
//     Speciality speciality,
//   ) async {
//     try {
//       if (!viewState.isLoading) {
//         viewState = ViewState.loading;
//         notifyListeners();
//       }
//       doctors = await _repository.getDoctors(
//         GetDoctorsRequest(
//           specialityId: speciality.id,
//         ),
//       );
//       viewState = ViewState.success;
//       notifyListeners();
//     } catch (e) {
//       viewState = ViewState.error;
//       notifyListeners();
//     }
//   }
// }
