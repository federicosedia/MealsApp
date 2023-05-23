import 'package:flutter/material.dart';

//chiavi per la mappa
enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilters});

  final Map<Filter, bool> currentFilters;

  @override
  State<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegetarianFilterSet = false;
  var _veganFilterSet = false;

  @override
  //chiamo initstate per sfruttare la proprietà widget che non posso
  //utilizzare quando creo le variabili set
  //con widget
  void initState() {
    super.initState();
    _glutenFreeFilterSet = widget.currentFilters[Filter.glutenFree]!;
    _lactoseFreeFilterSet = widget.currentFilters[Filter.lactoseFree]!;
    _vegetarianFilterSet = widget.currentFilters[Filter.vegetarian]!;
    _veganFilterSet = widget.currentFilters[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      /*  drawer: MainDrawer(
        onSelectScreen: (identifier) {
          Navigator.of(context).pop();
          if (identifier == 'meals') {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const TabsScreen(),
              ),
            );
          }
        },
      ),
      */
      //willpopscope è un widget di utilità
      //consente di impostare un parametro
      body: WillPopScope(
        //onwillpop richiede una funzione che restiusca un future (risolve valori che non ci sono ancora)
        //funzione che viene richiamata nel momento in cui si cerca di lasciare la schermata
        //usando async posso utilizzare il booleano perchè avvolge il widget in un future
        //e dato che onwillpop vuole un future utilizzo async
        onWillPop: () async {
          //il metodo pop ci permette di passare dati quando si chiude la schermata
          //quindi saranno disponibili nel luogo in cui abbiamo navigato vs questa schermata
          //passo una mappa che ha come chiave l'enum e come valore il valore del filtro impostato
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFreeFilterSet,
            Filter.lactoseFree: _lactoseFreeFilterSet,
            Filter.vegetarian: _vegetarianFilterSet,
            Filter.vegan: _veganFilterSet,
          });
          //la logica di abbandono della pagina è gia presente con pop
          //quindi non bisogna restituire true perchè restituendo true viene sostituita la logica di abbandono pagina
          return false;
        },
        child: Column(
          children: [
            //switchlisttile visualizza una singola riga nell'elenco
            //saranno presenti più interrutori
            //utilizzo per filtri per avere testo a sinistra e switch a destra
            SwitchListTile(
              value:
                  _glutenFreeFilterSet, //sarà uno stato perchè è modificabile
              //parametro per controllare se
              onChanged: (isChecked) {
                setState(() {
                  _glutenFreeFilterSet = isChecked;
                });
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
              value:
                  _lactoseFreeFilterSet, //sarà uno stato perchè è modificabile
              //parametro per controllare se
              onChanged: (isChecked) {
                setState(() {
                  _lactoseFreeFilterSet = isChecked;
                });
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
              value:
                  _vegetarianFilterSet, //sarà uno stato perchè è modificabile
              //parametro per controllare se
              onChanged: (isChecked) {
                setState(() {
                  _vegetarianFilterSet = isChecked;
                });
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
              value: _veganFilterSet, //sarà uno stato perchè è modificabile
              //parametro per controllare se
              onChanged: (isChecked) {
                setState(() {
                  _veganFilterSet = isChecked;
                });
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
      ),
    );
  }
}
