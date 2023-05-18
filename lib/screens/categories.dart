import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick your category'),
      ),
      /*
      gridview ci permette di avere una lista di widget diposti a griglia
      abbiamo anche il metodo builder che costruisce in modo dinamico
      oppure gridview widget
      anche se non abbiamo il builder abbiamo bisogno comunque di griddelegate
      crossaxiscount dice il numero di colonne
      cross -> orizzontale
      childaspectratio= rapporto due dimensioni
      */
      body: GridView(
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
            )
        ],
      ),
    );
  }
}
