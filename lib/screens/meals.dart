import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_detail.dart';
import 'package:meals_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen(
      {super.key,
      this.title,
      required this.meals,
      required this.onToggleFavorite});

  final String? title;
  final List<Meal> meals;
  final Function(Meal meal) onToggleFavorite;

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (ctx) => MealDetailScreen(
                meal: meal,
                onToggleFavorite: onToggleFavorite(meal),
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    /* creo una listview.builder
    per creare n oggetti "pasto"
    e stampo il titolo -> 
    nel caso in cui non ci sono pasti allora con l'if
    faccio vedere a schermo un testo
    */
    Widget content = ListView.builder(
      itemCount: meals.length,
      //faccio vedere a schermo ogni pasto a seconda dell'indice
      itemBuilder: (context, index) =>
          Mealitem(meal: meals[index], onSelectMeal: selectMeal),
    );
    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Nessun pasto',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'seleziona altro pasto',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ],
        ),
      );
    }
    //non posso rimuovere il titolo perchè viene utilizzato anche negli altri screen
    //quindi rendo il titolo opzionale con if

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!), // ! -> non è nullo
      ),
      body: content,
    );
  }
}
