import 'package:flutter/material.dart';
import '../models/receipe.dart';
import '../widgets/receipe_item.dart';

class CategorySelectedScreen extends StatelessWidget {
  static const String routeName = '/categorySelectedScreen';
  final List<Receipe> availableMeals;

  CategorySelectedScreen(this.availableMeals, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as List<String>;
    final String categoryTitle = routeArgs[0];
    final String categoryId = routeArgs[1];
    final categoryReceipes = availableMeals.where(
      (receipe) {
        return receipe.categoryId.contains(categoryId);
      },
    ).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ReceipeItem(
            id: categoryReceipes[index].id,
            title: categoryReceipes[index].title,
            imageUrl: categoryReceipes[index].imageUrl,
            duration: categoryReceipes[index].duration,
            complexity: categoryReceipes[index].complexity,
            affordability: categoryReceipes[index].affordability,
          );
          //Text(categoryReceipes[index].title);
        },
        itemCount: categoryReceipes.length,
      ),
    );
  }
}
