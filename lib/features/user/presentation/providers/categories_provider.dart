import 'package:bimarestan_doctors/features/user/data/models/category_model.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/state_management/view_state.dart';
import '../../../../locator/locator.dart';
import '../../data/repositories/user_repository.dart';
@injectable
class CategoriesProvider extends ChangeNotifier {
    final _userRepository = locator<UserRepository>();
    ViewState categoriesState = ViewState.initial;
    List<CategoryModel> categories = [];

    Future<void> getAllCategories() async {
        categoriesState = ViewState.loading;
        notifyListeners();
        final successOrFailure = await _userRepository.getAllCategories();
        successOrFailure.fold(
            (failure) {
                categoriesState = ViewState.error;
                notifyListeners();
            },
            (categoriesList) {
                categories = categoriesList;
                categoriesState = ViewState.success;
                notifyListeners();
            },
        );
    }
}