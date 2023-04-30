import 'package:bimarestan_doctors/features/bottom_nav_bar/presentation/screens/bottom_nav_bar_screen.dart';
import 'package:bimarestan_doctors/features/clinics/presentation/screens/clinics_screen.dart';
import 'package:bimarestan_doctors/features/profile/presentation/screens/profile_screen.dart';
import 'package:bimarestan_doctors/features/user/presentation/screens/categories_screen.dart';
import 'package:bimarestan_doctors/features/user/presentation/screens/home_screen.dart';
import 'package:bimarestan_doctors/features/user/presentation/screens/login_screen.dart';
import 'package:bimarestan_doctors/features/user/presentation/screens/sign_up_screen.dart';
import 'package:bimarestan_doctors/features/splash/presentation/screens/splash_screen.dart';
import 'package:bimarestan_doctors/routes/routes.dart';
import 'package:flutter/material.dart';

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
    }
  }
}
