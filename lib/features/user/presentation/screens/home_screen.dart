import 'package:bimarestan_doctors/features/user/data/datasources/user_local_data_source.dart';
import 'package:bimarestan_doctors/locator/locator.dart';
import 'package:flutter/material.dart';

import '../../../../routes/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('Sign Out'),
              onTap: () {
                locator<UserLocalDataSource>().signOut();
              },
            ),
            ListTile(
              title: Text('Clinics'),
              onTap: () {
                Navigator.of(context).pushNamed(Routes.clinics);
              },
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                Navigator.of(context).pushNamed(Routes.profile);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
    );
  }
}
