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
  //non chiama build più volte ma è come se avesse un timer per poi aggiornare le IF
  late AnimationController _animationController;

  void initState() {
    super.initState();
    //vsync vuole un ticketprovider
    //configurare animationcontroller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
      //le animazioni sono sempre tra due valori
      lowerBound: 0,
      upperBound: 1,
    );
//avviare animation controller
    _animationController.forward();
  }

//metodo chiamato da flutter dietro le quinte
//animationcontroller verrà eliminato dalla memoria del dispositivo
  @override
  void dispose() {
    _animationController.dispose();
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
        //verrà eseguito quello dentro builder in base al timer scelto da noi
        //esempio 60 volte al secondo 60fps
        AnimatedBuilder(
            animation: _animationController,
            //quello compreso in questo figlio non verrà ribuilidato
            child: GridView(
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
            ),
            //slidetransition animazione che prevede spostamenti di oggetti
            //child indica quello che dovrà essere animato
            //ofset è un tipo speciale per descrivere la quantità di offset di un elemento
            //rispetto alla posizione effettiva
            //drive costruisce un animazione sulla base di un altro valore
            //la classe Tween anima la transizione tra due valori
            //con tween inoltre possiamo chiamare il metodo animate
            builder: (context, child) => SlideTransition(
                  position: Tween(
                    begin: const Offset(0, 0.3),
                    end: const Offset(0, 0),
                  ).animate(CurvedAnimation(
                      parent: _animationController, curve: Curves.easeInOut)),
                  child: child,
                ));
  }
}
