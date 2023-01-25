import 'package:categories_task/repositories/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../constants.dart';
import '../models/category.dart';

class SubCategoriesScreen extends ConsumerWidget {
  final Category parent;
  const SubCategoriesScreen({
    Key? key,
    required this.parent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subCategories = ref.watch(subCategoriesProvider(parent));

    return Scaffold(
      appBar: AppBar(
        title: Text(parent.name),
      ),
      body: Center(
        child: subCategories.when(
          data: (subCategory) => subCategory.isNotEmpty
              ? ListView.builder(
                  itemCount: subCategory.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(subCategory[index].name),
                    onTap: () {
                      context.pushNamed(
                        RouteName.subCategoriesScreen,
                        extra: subCategory[index],
                      );
                    },
                  ),
                )
              : const Text('No categories found!'),
          error: (error, stackTrace) => const Text('Some error occured!'),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
