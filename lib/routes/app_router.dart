import 'package:bimarestan_doctors/features/user/presentation/screens/home_screen.dart';
import 'package:bimarestan_doctors/features/user/presentation/screens/login_screen.dart';
import 'package:bimarestan_doctors/features/user/presentation/screens/sign_up_screen.dart';
import 'package:bimarestan_doctors/features/splash/presentation/screens/splash_screen.dart';
import 'package:bimarestan_doctors/routes/routes.dart';
import 'package:flutter/material.dart';

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
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());  
    
    }
  }
}
