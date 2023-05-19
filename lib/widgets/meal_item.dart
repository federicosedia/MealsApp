import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';

class Mealitem extends StatelessWidget {
  const Mealitem({required this.meal, super.key});

  final Meal meal;

//get per trasformare l'iniziale del enum complessity in maiuscolo
  String get complexitytest {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(
            1); //name consente di accedere ai valori di enum come stringa
  }

//get per trasformare l'iniziale del enum affordability in maiuscolo
  String get affordabilitytext {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(
            1); //name consente di accedere ai valori di enum come stringa
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {},
        //stack -> widget posizionati uno sopra l'altro
        child: Stack(
          //stack elimina le impostazioni di borderradius quindi aggiungo clip
          children: [
            FadeInImage(
              fit: BoxFit.cover,
              height:
                  200, //height e double infinity per mettere l'immagine li senza subire distorsioni
              width: double.infinity, //immagine non distorta,
              //trasparentimage importato
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
            ),
            Positioned(
              //questo positioned impone a suo figlio di assumere quella determinata larghezza
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis, //testo molto lungo
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                          icon: Icons.schedule,
                          label: meal.duration.toString() + "min",
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        MealItemTrait(
                          icon: Icons.work,
                          label: complexitytest,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        MealItemTrait(
                          icon: Icons.attach_money,
                          label: affordabilitytext,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
