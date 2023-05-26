import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favorites_providers.dart';

//replace Stateless with Consumer
class MealDetailScreen extends ConsumerWidget {
  const MealDetailScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;
  //sollevamento stato per passare la funzione al widget meals partendo da tabs
//nuovo parametro in build per ascoltare i provider
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final bool isFavorite = favoriteMeals.contains(meal);
    return Scaffold(
        appBar: AppBar(
          title: Text(meal.title),

          //nuova azione per marcare il pasto come preferito
          actions: [
            IconButton(
              onPressed: () {
                //con ".notifier" abbiamo accesso alla classe Notifier definita nella /providers/favorite_providers
                final wasAdded = ref
                    .read(favoriteMealsProvider.notifier)
                    .toggleMealsFavoriteStatus(meal);
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(wasAdded
                        ? 'Meal added as a favorite'
                        : "Meal removed."),
                  ),
                );
              },
              //animazione implicita:
              //aggiungo animatedswticher
              //come child gli metto quello che cambia
              //duration la durata che voglio
              //transitionbuilder l'animazione che voglio
              //l'animazione è gestita da flutter quindi non devo prevedere inizio e fine
              //e nemmeno come l'animazione verrà animata nello spazio
              //voglio far ruotare l'icona quindi prevedo rotationtransation
              //come turns imposto animazione che sarà gestita da flutter in automatico
              //come child l'icona che ruoterà
              //aggiungendo la chiave notifico che sta avvenendo un cambiamento
              //altrimenti non viene aggiornato lo schermo con l'animazione
              //perchè flutter non riconosce che sta cambiando qualcosa
              //perchè restituisce lo stesso tipo di widget
              //come chiave aggiungo isFavorite perchè quando cambia flutter
              //verrà notificato e vedrà che qualcosa è cambiato
              //posso però modificare il tipo di spin cambiando l'aniamzione con tween
              //andrò quindi a settarla io manualmente
              //aggiungo quindi tween e il metodo animate
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return RotationTransition(
                    turns: Tween(
                      begin: 0.5,
                      end: 1.0,
                    ).animate(animation),
                    child: child,
                  );
                },
                child: Icon(
                  isFavorite ? Icons.star : Icons.star_border,
                  key: ValueKey(isFavorite),
                ),
              ),
            ),
          ],
        ),
        //singlechild aggiunto per rendere schermata scorrevolo
        body: SingleChildScrollView(
          child: Column(
            children: [
              //quello che dobbiamo fare per animare con hero
              //dobbiamo modificare lo stesso widget che abbiamo modificato con hero
              //quindi il widget che dobbiamo animare
              //avvolgiamo con Hero e assegniamo lo stesso tag
              Hero(
                tag: meal.id,
                child: Image.network(
                  meal.imageUrl,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Ingredients',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 14),
              for (final ingredient in meal.ingredients)
                Text(
                  ingredient,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              const SizedBox(height: 24),
              Text(
                'Steps',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 14),
              for (final step in meal.steps)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Text(
                    step,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                ),
            ],
          ),
        ));
  }
}
