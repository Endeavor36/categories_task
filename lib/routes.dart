import 'package:categories_task/screens/home_screen.dart';
import 'package:categories_task/screens/categories_screen.dart';
import 'package:categories_task/screens/sub_categories_screen.dart';
import 'package:go_router/go_router.dart';

import 'constants.dart';
import 'models/category.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      name: RouteName.categoriesScreen,
      path: '/categories',
      builder: (context, state) => const CategoriesScreen(),
    ),
    GoRoute(
      name: RouteName.subCategoriesScreen,
      path: '/sub-categories',
      builder: (context, state) {
        Category subCategory = state.extra as Category;
        return SubCategoriesScreen(
          parent: subCategory,
        );
      },
    ),
  ],
);
