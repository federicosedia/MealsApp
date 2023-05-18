import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meals_app/main.dart';
import 'package:meals_app/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({
    super.key,
    required this.category,
    //aggiunta per per permettere di aggiungere ad ontap
    //la funzione _selectCategory tramite onsSelectedCategory
    required this.onsSelectedCategory,
  });

  final Category category;
  final void Function() onsSelectedCategory;

  @override
  Widget build(BuildContext context) {
    //inkwell a differenza di gesturedetector
    //gestisce anche gli effetti visivi
    return InkWell(
      onTap: onsSelectedCategory,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        //padding -> contorno al widget
        padding: const EdgeInsets.all(16),
        //variazione colore in opacitàg
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(colors: [
            category.color.withOpacity(0.55),
            category.color.withOpacity(0.45),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Text(
          category.title,
          // ! -> definitivo
          //copywith copio il testo predefinito
          //colore sempre preso dal tema e con colore di sfondo
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
    );
  }
}
