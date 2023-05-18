import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meals_app/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({super.key, required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding -> contorno al widget
      padding: const EdgeInsets.all(16),
      //variazione colore in opacità
      decoration: BoxDecoration(
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
    );
  }
}
