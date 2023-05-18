import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

//con il navigator posso spostarmi tra due screen
//non avendo un contesto perche siamo in uno stateless
//passiamo il context come argomento
//mentre route viene instaziato con Materialpageroute
//quindi con questo metodo costruisco un nuovo schermo
  void _selectCategory(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: 'F',
          meals: [],
        ),
      ),
    );
  }

  @override
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
                //aggiunta la funzione "onsSelectedCategory" come proprietà al widget cetegorygriditem
                //_selectCategory accetta come argomento context
                //
                onsSelectedCategory: () {
                  _selectCategory(context);
                })
        ],
      ),
    );
  }
}
