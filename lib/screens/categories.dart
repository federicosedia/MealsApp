import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(
      {super.key,
      required this.onToggleFavorite,
      required this.availableMeals});

  final Function(Meal meal) onToggleFavorite;
  final List<Meal> availableMeals;

//con il navigator posso spostarmi tra due screen
//non avendo un contesto perche siamo in uno stateless
//passiamo il context come argomento
//mentre route viene instaziato con Materialpageroute
//quindi con questo metodo costruisco un nuovo schermo

//aggiungo anche category per facilitarmi a ritrovare i dati
//per ogni categoria
//aggiungo .toList per converitre l'iterabile dato dal metodo where
//e da avere cosi una lista
  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
          onToggleFavorite: onToggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //rimozione scaffold per non avere due appbar che mostrano il titolo
    return
        /*
      gridview ci permette di avere una lista di widget diposti a griglia
      abbiamo anche il metodo builder che costruisce in modo dinamico
      oppure gridview widget
      anche se non abbiamo il builder abbiamo bisogno comunque di griddelegate
      crossaxiscount dice il numero di colonne
      cross -> orizzontale
      childaspectratio= rapporto due dimensioni
      */
        GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      children: [
        //ciclo for che passa per tutte le categorie e va in tutte le categorie disponibili
        //availablecategories.map((category)=> CategoryGridItem(category: category)).toList()
        for (final category in availableCategories)
          CategoryGridItem(
              category: category,
              //aggiunta la funzione "onsSelectedCategory" come proprietà al widget cetegorygriditem
              //_selectCategory accetta come argomento context
              //
              onsSelectedCategory: () {
                _selectCategory(context, category);
              })
      ],
    );
  }
}
