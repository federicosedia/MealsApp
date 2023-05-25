import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

//import necessari per utilizzare il provider

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favorites_providers.dart';

import 'package:meals_app/providers/filters_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

//è uno statefull perchè bisogna aggiornare la pagina
//quindi significa aggiornare lo stato
//statefull widget cambierà in ConsumerStatefulWidget per utilizzare il provider
class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  //consumerstate per il provider
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  //metodo per cambiare indice a seconda dell'icona scelta
  //nella bottom navigation bar
  int _selectedPageIndex = 0;

//funzione per mostrare un messaggio quando viene aggiunto ai preferiti

//metodo per rimuovere o aggiungere pasti ai preferiti

  void _selectePage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      //pushreplacement sostituisce la schermata non ne crea una sopra
      //result verrà impostato solo dopo che si torna indietro nella schermata
      //quindi solo dopo che il future si è risolto
      //per passare i dati utilizzo async e await creando la variabile result
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //variabile dove salvo i pasti disponibili dopo i filtri
    //read per ottenere i dati dal providere una volta
    //watch per impostare un ascoltatore e il metodo build viene eseguito di nuovo quando i dati cambiano
    //vuole come argomento un Provider
    final availableMeals = ref.watch(filteredMealsProvider);
    //la pagina attiva iniziale sarà quella delle categorie
    //verrà aggiornata in base al tocco degli elementi della barra
    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectePage,
        //currentindex per segnalare quale scheda è aperta
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
