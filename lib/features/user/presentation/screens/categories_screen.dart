import 'package:bimarestan_doctors/core/shared/app_card.dart';
import 'package:bimarestan_doctors/features/user/presentation/providers/categories_provider.dart';
import 'package:bimarestan_doctors/locator/locator.dart';
import 'package:bimarestan_doctors/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/state_management/view_state.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CategoriesProvider>(
      create: (context) => locator()..getAllCategories(),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          title: Text('Choose a category'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Consumer<CategoriesProvider>(
            builder: (context, model, child) {
              switch (model.categoriesState) {
                case ViewState.initial:
                case ViewState.loading:
                  return Center(child: CircularProgressIndicator());
                case ViewState.error:
                  return Center(child: Text('Error'));
                case ViewState.success:
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: model.categories.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => Navigator.of(context).pushReplacementNamed(
                          Routes.signUp,
                          arguments: model.categories[index],
                        ),
                        child: AppCard(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                model.categories[index].image,
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Center(
                                child: Text(
                                  model.categories[index].name,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
