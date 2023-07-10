import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../clinics/presentation/screens/clinics_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';

@injectable
class BottomNavBarProvider extends ChangeNotifier {
  int _pageIndex = 0;
  final _screens = [
    ClinicsScreen(),
    Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
    ),
    // ScannerScreen(),
    ProfileScreen(),
  ];
  final _destinations = [
    NavigationDestination(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    NavigationDestination(
      icon: Icon(Icons.chat),
      label: 'Chats',
    ),
    // NavigationDestination(
    //   icon: Icon(Icons.qr_code),
    //   label: 'Scan QR',
    // ),
    NavigationDestination(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];
  List<NavigationDestination> get destinations => _destinations;
  List<Widget> get screens => _screens;

  int get pageIndex => _pageIndex;
  void togglePageIndex(int index) {
    _pageIndex = index;
    notifyListeners();
  }

  Widget get currentPage => _screens[_pageIndex];
}
