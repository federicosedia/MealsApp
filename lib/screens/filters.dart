import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/providers/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

//elimino classe state perchè non gestirò più lo stato

  @override
  //chiamo initstate per sfruttare la proprietà widget che non posso
  //utilizzare quando creo le variabili set
  //con widget
  //stiamo leggendeo i dati dal nostro provider di filtri
  //per inizializzare il nostro local state
  //e lo gestiamo per riflettere le modifiche quando un utente clicca su un bottone
  //quindi init state possiamo toglierlo e utilizzare il provider

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //nuova proprietà per registrare i filtri che cambiano
    //quindi con watch rieseguo la build
    //e guardo ogni cambiamento portato da filtersprovider
    final activeFilters = ref.watch(filtersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: Column(
        children: [
          //switchlisttile visualizza una singola riga nell'elenco
          //saranno presenti più interrutori
          //utilizzo per filtri per avere testo a sinistra e switch a destra
          SwitchListTile(
            value: activeFilters[
                Filter.glutenFree]!, //sarà uno stato perchè è modificabile
            //parametro per controllare se
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.glutenFree, isChecked);
            },
            title: Text(
              'Gluten-free',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.background),
            ),
            subtitle: Text(
              'Only include gluten-free meals',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.background),
            ),
            activeColor:
                Theme.of(context).colorScheme.tertiary, //colore terziario
            contentPadding: const EdgeInsets.only(
              left: 34,
              right: 22,
            ),
          ),
          //
          SwitchListTile(
            value: activeFilters[
                Filter.lactoseFree]!, //sarà uno stato perchè è modificabile
            //parametro per controllare se
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.lactoseFree, isChecked);
            },
            title: Text(
              'Lactose-free',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.background),
            ),
            subtitle: Text(
              'Only include lactose-free meals',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.background),
            ),
            activeColor:
                Theme.of(context).colorScheme.tertiary, //colore terziario
            contentPadding: const EdgeInsets.only(
              left: 34,
              right: 22,
            ),
          ),
          SwitchListTile(
            value: activeFilters[
                Filter.vegetarian]!, //sarà uno stato perchè è modificabile
            //parametro per controllare se
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegetarian, isChecked);
            },
            title: Text(
              'Vegetarian',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.background),
            ),
            subtitle: Text(
              'Only include Vegetarian meals',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.background),
            ),
            activeColor:
                Theme.of(context).colorScheme.tertiary, //colore terziario
            contentPadding: const EdgeInsets.only(
              left: 34,
              right: 22,
            ),
          ),
          SwitchListTile(
            value: activeFilters[
                Filter.vegan]!, //sarà uno stato perchè è modificabile
            //parametro per controllare se
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegan, isChecked);
            },
            title: Text(
              'Vegan',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.background),
            ),
            subtitle: Text(
              'Only include Vegan meals',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.background),
            ),
            activeColor:
                Theme.of(context).colorScheme.tertiary, //colore terziario
            contentPadding: const EdgeInsets.only(
              left: 34,
              right: 22,
            ),
          ),
        ],
      ),
    );
  }
}
