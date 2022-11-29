import 'package:flutter/material.dart';
import '../dummy_data.dart';

class ReceipeDetailsScreen extends StatelessWidget {
  static const routeName = '/receipe-details';
  final Function toggleFavorite, isFavorite;
  const ReceipeDetailsScreen(this.toggleFavorite, this.isFavorite, {Key? key})
      : super(key: key);

  Widget buildSectionTitle(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget buildContainer(Widget childWidget) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 200,
      width: 300,
      child: childWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    final receipeId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedReceipe = dummyMeals.firstWhere(
      (element) => element.id == receipeId,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedReceipe.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedReceipe.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(
              ListView.builder(
                itemBuilder: (context, index) => Card(
                  //color: Theme.of(context).accentColor,
                  child: Text(
                    selectedReceipe.ingredients[index],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                itemCount: selectedReceipe.ingredients.length,
              ),
            ),
            buildSectionTitle(context, 'Steps'),
            buildContainer(
              ListView.builder(
                itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(child: Text('#${index + 1}')),
                  title: Text(selectedReceipe.steps[index]),
                ),
                itemCount: selectedReceipe.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          toggleFavorite(receipeId);
        },
        child:
            isFavorite(receipeId) ? Icon(Icons.star) : Icon(Icons.star_border),
      ),
    );
  }
}
