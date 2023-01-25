import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/category.dart';

final categoriesProvider = FutureProvider.autoDispose((ref) {
  return CategoriesProvider().getCategories();
});

final subCategoriesProvider =
    FutureProvider.family.autoDispose((ref, Category parent) {
  return CategoriesProvider().getSubCategories(parent);
});

class CategoriesProvider {
  Future<List<Category>> getCategories() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);

    List<Category> categories = [];

    for (var category in data['results']) {
      if (category['parent'] == 0) {
        categories.add(Category.fromMap(category));
      }
    }

    return categories;
  }

  Future<List<Category>> getSubCategories(Category parent) async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);

    List<Category> subCategories = [];

    for (var category in data['results']) {
      if (parent.id == category['parent']) {
        subCategories.add(Category.fromMap(category));
      }
    }

    return subCategories;
  }
}
