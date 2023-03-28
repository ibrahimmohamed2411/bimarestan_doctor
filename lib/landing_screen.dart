import 'package:bimarestan_doctors/core/shared/loading_widget.dart';
import 'package:bimarestan_doctors/features/user/data/datasources/user_local_data_source.dart';
import 'package:bimarestan_doctors/features/user/presentation/screens/home_screen.dart';
import 'package:bimarestan_doctors/features/user/presentation/screens/login_screen.dart';
import 'package:bimarestan_doctors/locator/locator.dart';
import 'package:flutter/material.dart';

import 'features/user/data/models/login_response_model.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<LoginResponseModel?>(
        stream: locator<UserLocalDataSource>().userCredentialsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return HomeScreen();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingWidget();
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }
          return LoginScreen();
        },
      ),
    );
  }
}
