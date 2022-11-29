import 'package:flutter/material.dart';
import '../models/receipe.dart';

import '../widgets/receipe_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Receipe> favoriteRecipe;
  FavoritesScreen(this.favoriteRecipe, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (favoriteRecipe.isEmpty) {
      return Center(
        child: Text("Please add Recipe as favorite."),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          return ReceipeItem(
            id: favoriteRecipe[index].id,
            title: favoriteRecipe[index].title,
            imageUrl: favoriteRecipe[index].imageUrl,
            duration: favoriteRecipe[index].duration,
            complexity: favoriteRecipe[index].complexity,
            affordability: favoriteRecipe[index].affordability,
          );
        },
        itemCount: favoriteRecipe.length,
      );
    }
  }
}
