import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/meals_providers.dart';

//chiavi per la mappa
enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    //  state[filter] = isActive;  non permesso perchè si modifica lo stato
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
        (ref) => FiltersNotifier());

//nuovo provider per vedere i pasti disponibili dopo i filtri
//Sarà un provider non un statenotifierprovider
//perchè non andrò a creare una nuova classe filternotifier
//questo filteredMealsProvider dipende da filtersProvider
//perchè i filtri possono cambiare
//per farlo posso utilizzare "ref"
//ogni volta che viene creato un provider
//non abbiamo mai utilizzato ref se non nei widget
//ma ref è lo stesso che utilizziamo nei widget
//quindi con watch cambiamo il valore ogni volta che il valore cambia
//nel provider originale
//per invece l'activefilters farò il watch di filtersprovider
final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);
  return meals.where((meal) {
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
