import 'package:flutter/material.dart';
import 'package:meals_app/main.dart';
import 'package:meals_app/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(meal.title),
        ),
        //singlechild aggiunto per rendere schermata scorrevolo
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                meal.imageUrl,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                'Ingredienti',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 14,
              ),
              for (final ingredient in meal.ingredients)
                Text(
                  ingredient,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              SizedBox(
                height: 22,
              ),
              Text(
                'Steps',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 14,
              ),
              for (final steps in meal.steps)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Text(
                    steps,
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
