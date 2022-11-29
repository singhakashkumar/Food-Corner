import 'package:flutter/material.dart';
import '../screens/category_selected_screen.dart';

class CardWidget extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  const CardWidget(
      {required this.id, required this.title, required this.color, Key? key})
      : super(key: key);

  void selectedCategory(BuildContext ctx) {
    Navigator.of(ctx)
        .pushNamed(CategorySelectedScreen.routeName, arguments: [title, id]);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectedCategory(context),
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color.withOpacity(0.6), color])),
      ),
    );
  }
}
