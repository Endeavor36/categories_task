import 'package:categories_task/repositories/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../constants.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Categories'),
      ),
      body: Center(
        child: categories.when(
          data: (category) => category.isNotEmpty
              ? ListView.builder(
                  itemCount: category.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(category[index].name),
                    onTap: () => context.pushNamed(
                      RouteName.subCategoriesScreen,
                      extra: category[index],
                    ),
                  ),
                )
              : const Text('No categories found!'),
          error: (error, stackTrace) => const Text('Error occured'),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
