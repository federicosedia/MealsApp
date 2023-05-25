import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/dummy_data.dart';

//l'istazione di questa classe di provider creerà un oggetto provider
//che potremmo ascoltare dall'interno dei nostri widget
//ha bisogno del parametro posizionale di tipo funzione che riceve l'oggetto provider ref

final mealsProvider = Provider((ref) {
  return dummyMeals;
});
