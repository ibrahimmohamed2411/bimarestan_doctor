import 'package:bimarestan_doctors/core/resources/color_manager.dart';
import 'package:bimarestan_doctors/locator/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/bottom_nav_bar_provider.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BottomNavBarProvider>(
      create: (context) => locator(),
      child: Consumer<BottomNavBarProvider>(
        builder: (context, model, child) => Scaffold(
          body: model.currentPage,
          bottomNavigationBar: NavigationBar(
            selectedIndex: model.pageIndex,
            onDestinationSelected: model.togglePageIndex,
            destinations: model.destinations,
            indicatorColor: ColorManager.primary,
          ),
        ),
      ),
    );
  }
}
