import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/meals.dart';

//è uno statefull perchè bisogna aggiornare la pagina
//quindi significa aggiornare lo stato
class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  //metodo per cambiare indice a seconda dell'icona scelta
  //nella bottom navigation bar
  int _selectedPageIndex = 0;
  void _selectePage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //la pagina attiva iniziale sarà quella delle categorie
    //verrà aggiornata in base al tocco degli elementi della barra
    Widget activepage = const CategoriesScreen();
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activepage = MealsScreen(meals: []);
      activePageTitle = 'Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('dynamic'),
      ),
      body: activepage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectePage,
        //currentindex per segnalare quale scheda è aperta
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
