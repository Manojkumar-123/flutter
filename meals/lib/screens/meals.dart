import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meal_details.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, required this.title, required this.meals});

  final String title;
  final List<Meal> meals;

  void onSelectMeal(BuildContext context, Meal meal) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => MealDetails(
                  meal: meal,
                )));
  }

  @override
  Widget build(BuildContext context) {
    if (meals.isEmpty) {
      return const Center(child: Text("Choose another category please...! :)"));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
          itemCount: meals.length,
          itemBuilder: ((context, index) => MealItem(
                meal: meals[index],
                onSelectMeal: () => onSelectMeal(context, meals[index]),
              ))),
    );
  }
}
