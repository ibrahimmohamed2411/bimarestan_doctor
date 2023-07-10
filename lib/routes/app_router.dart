import 'package:bimarestan_doctors/features/appintments/presentation/screens/appointments_screen.dart';
import 'package:bimarestan_doctors/features/bottom_nav_bar/presentation/screens/bottom_nav_bar_screen.dart';
import 'package:bimarestan_doctors/features/clinics/data/models/clinic_model.dart';
import 'package:bimarestan_doctors/features/clinics/presentation/screens/clinics_screen.dart';
import 'package:bimarestan_doctors/features/clinics/presentation/screens/update_clinic_screen.dart';
import 'package:bimarestan_doctors/features/profile/presentation/screens/profile_screen.dart';
import 'package:bimarestan_doctors/features/user/presentation/screens/categories_screen.dart';
import 'package:bimarestan_doctors/features/user/presentation/screens/login_screen.dart';
import 'package:bimarestan_doctors/features/user/presentation/screens/sign_up_screen.dart';
import 'package:bimarestan_doctors/features/splash/presentation/screens/splash_screen.dart';
import 'package:bimarestan_doctors/routes/routes.dart';
import 'package:flutter/material.dart';

import '../features/chat/chat_view.dart';
import '../features/user/data/models/category_model.dart';
import '../landing_screen.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.landing:
        return MaterialPageRoute(builder: (_) => const LandingScreen());
      case Routes.signIn:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case Routes.signUp:
        final category = settings.arguments as CategoryModel;
        return MaterialPageRoute(
          builder: (_) => SignUpScreen(
            categoryModel: category,
          ),
        );
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const BottomNavBarScreen());
      case Routes.categories:
        return MaterialPageRoute(builder: (_) => CategoriesScreen());
      case Routes.clinics:
        return MaterialPageRoute(builder: (_) => ClinicsScreen());
      case Routes.profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case Routes.chat:
        final arguments = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => ChatView(
            senderId: arguments['senderId'] as int,
            senderName: arguments['senderName'] as String,
            recieverId: arguments['recieverId'] as int,
            recieverName: arguments['recieverName'] as String,
          ),
        );
      case Routes.appointments:
        final clinicId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => AppointmentsScreen(
            clinicId: clinicId,
          ),
        );
      case Routes.updateClinic:
        final clinic = settings.arguments as ClinicModel;
        return MaterialPageRoute(
          builder: (_) => UpdateClinicScreen(
            clinic: clinic,
          ),
        );
    }
    return null;
  }
}
