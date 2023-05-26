import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

//refacot a statefull per utilizzare animazioni
//l'animazione setta lo stato e modifica lo stato quando è in esecuzione
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    required this.availableMeals,
  });

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

//con with aggiungiamo un mixin alla classe quindi aggiunge altre proprità
class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  //deve essere impostato prima che l'applicazione viene buildata
  //all'inizio non avrà un valore ma solo dopo. Lo facciamo con late
  //late dice a dart che quella variabile avrà un valore quando verrà
  //usata per la prima volta
  //animationcontroller è un tipo incorporato in dart
  //è anche una classe fornite da flutter
  late AnimationController _animationController;

  void initState() {
    super.initState();
    //vsync vuole un ticketprovider
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
      //le animazioni sono sempre tra due valori
      lowerBound: 0,
      upperBound: 1,
    );
  }

//metodo chiamato da flutter dietro le quinte
//animationcontroller verrà eliminato dalla memoria del dispositivo
  @override
  void dispose() {
    _animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

//con il navigator posso spostarmi tra due screen
  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
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
