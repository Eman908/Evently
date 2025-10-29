import 'package:evently/core/app_routes.dart';
import 'package:evently/views/home/models/category_model.dart';
import 'package:flutter/material.dart';

class BottomNavProvider extends ChangeNotifier {
  int currentIndex = 0;
  List<CategoryModel> categoriesList = [];
  CategoryModel? selectedCategory;

  BottomNavProvider() {
    getAllCategories();
  }

  void getCurrentIndex(BuildContext context, int index) {
    if (index < 2) {
      currentIndex = index;
    } else if (index > 2) {
      currentIndex = index - 1;
    }
    if (index == 2) {
      Navigator.pushNamed(context, AppRoutes.createEventRoute);
    }
    notifyListeners();
  }

  changeSelected(int index) {
    selectedCategory = categoriesList[index];
    notifyListeners();
  }

  getAllCategories() {
    categoriesList.add(
      CategoryModel(
        enName: "All",
        arName: "الكل",
        id: -1,
        imagePath: '',
        iconData: Icons.explore,
      ),
    );
    return categoriesList.addAll(CategoryModel.categories);
  }
}
