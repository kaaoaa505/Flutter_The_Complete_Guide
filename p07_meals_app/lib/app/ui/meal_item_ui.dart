import 'package:flutter/material.dart';
import 'package:p07_meals_app/app/models/meal_model.dart';
import 'package:p07_meals_app/app/ui/meal_item_metadata_ui.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItemUi extends StatelessWidget {
  const MealItemUi({super.key, required this.mealModel});

  final MealModel mealModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {},
        child: Stack(
          children: [
            FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: mealModel.imageUrl,
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              child: Container(
                color: Colors.black45,
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    Text(
                      mealModel.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemMetadataUi(
                          icon: Icons.schedule,
                          label: '${mealModel.duration} min',
                        ),
                        SizedBox(width: 12),
                        MealItemMetadataUi(
                          icon: Icons.work,
                          label: mealModel.complexityText,
                        ),
                        SizedBox(width: 12),
                        MealItemMetadataUi(
                          icon: Icons.attach_money,
                          label: mealModel.affordabilityText,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
