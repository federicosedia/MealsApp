import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

//StateNotifierProvider è ottima per oggetti dinamici
//come per gli statefull anch'essa ha un'altra classe con cui lavora insieme
//tra parentesi angolari indico che tipo di dati saranno gestiti
//dopodichè creo il costruttore e aggiungo l'elenco di inizializzatori
//super per raggiungere il genitori
//in super aggiungo i dati da passare quindi la lista
//dobbiamo sostituire la lista vuota e non si può chiamare il metodo add o remove
class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);
//non possiamo aggiungere a state (metodo fornito da StateNotifier) o rimuovere elementi
//quindi facciamo prima un controllo se contiene il pasto e nel caso lo aggiungiamo alla lista nuova
  bool toggleMealsFavoriteStatus(Meal meal) {
    final mealsIsFavorite = state.contains(meal);

    if (mealsIsFavorite) {
      //l'elemento
      state = state.where((element) => element.id != meal.id).toList();
      return false;
    } else {
      //serve per aggiungere il pasto alla mia lista. Spread operator per mantenere la lista precedente + meal da aggiungere
      state = [...state, meal];
      return true;
    }
  }
}

//return dell'istanza del notificatore
//tra parentesi angolari la classe precedente e il tipo di dato che verrà fornito
final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});
