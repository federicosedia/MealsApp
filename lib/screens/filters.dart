import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:meals_app/main.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFreeSet = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: Column(
        children: [
          //switchlisttile visualizza una singola riga nell'elenco
          //saranno presenti più interrutori
          SwitchListTile(
            value: _glutenFreeSet, //sarà uno stato perchè è modificabile
            //parametro per controllare se
            onChanged: (isChecked) {
              setState(() {
                _glutenFreeSet = isChecked;
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
          )
        ],
      ),
    );
  }
}
