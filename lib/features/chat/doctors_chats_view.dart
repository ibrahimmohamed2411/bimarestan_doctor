// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:provider/provider.dart';

// import '../../core/state_management/view_state.dart';
// import '../../models/specialities/speciality.dart';
// import '../../router/routes.dart';
// import '../../shared/loading_widget.dart';
// import '../../shared/something_went_wrong_widget.dart';
// import '../auth/app/app_model.dart';
// import '../doctors/visit_doctors_view.dart';
// import 'doctors_chats_view_model.dart';

// class DoctorsChatsView extends StatelessWidget {
//   const DoctorsChatsView({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final speciality = ModalRoute.of(context)!.settings.arguments as Speciality;
//     final address = context.read<AppModel>().profile!.address;
//     final user = context.read<AppModel>().profile!;
//     return ChangeNotifierProvider<DoctorsChatsViewModel>(
//       create: (context) => DoctorsChatsViewModel()..init(address, speciality),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Radiological Analyzes'),
//           leading: const BackButton(
//             color: Colors.white,
//           ),
//         ),
//         body: Consumer<DoctorsChatsViewModel>(
//           builder: (context, model, _) {
//             switch (model.viewState) {
//               case ViewState.initial:
//               case ViewState.loading:
//                 return const Center(child: LoadingAnimation());
//               case ViewState.error:
//                 return SomethingWentWrongWidget(
//                   onTap: () => model.init(address, speciality),
//                 );
//               case ViewState.success:
//                 if (model.doctors.isEmpty) {
//                   return const Center(
//                     child: Text('No doctors found'),
//                   );
//                 }
//                 return AnimationLimiter(
//                   child: ListView.builder(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 42.w,
//                       vertical: 24.h,
//                     ),
//                     itemCount: model.doctors.length,
//                     itemBuilder: (context, index) =>
//                         AnimationConfiguration.staggeredList(
//                       position: index,
//                       duration: const Duration(milliseconds: 1000),
//                       child: SlideAnimation(
//                         verticalOffset: -50.0,
//                         delay: Duration(milliseconds: 100 * index),
//                         child: FadeInAnimation(
//                           duration: const Duration(milliseconds: 1000),
//                           child: Padding(
//                             padding: EdgeInsets.only(bottom: 20.h),
//                             child: HealthCard(
//                               profile: model.doctors[index],
//                               onPressed: () {
//                                 Navigator.of(context).pushNamed(
//                                   Routes.chat,
//                                   arguments: {
//                                     'senderId': user.id,
//                                     'senderName': user.fullName,
//                                     'recieverId': model.doctors[index].id,
//                                     'recieverName':
//                                         model.doctors[index].fullName,
//                                   },
//                                 );
//                               },
//                               buttonText: 'Send Analyzes',
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
