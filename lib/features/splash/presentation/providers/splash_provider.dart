import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../locator/locator.dart';
import '../../../../routes/routes.dart';

@injectable
class SplashProvider extends ChangeNotifier {
  final _navigationService = locator<NavigationService>();
  late Timer _timer;
  void init() {
    _timer = Timer(const Duration(seconds: 2), () {
      _navigationService.replaceWith(Routes.landing);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
}
