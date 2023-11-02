import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meal_details.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, this.title, required this.meals});

  final String? title;
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
    //This is for if the meals screen is come from tab navigation
    if (title == null) {
      if (meals.isEmpty) {
        return const Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Uh...Ooh Nothing here ... :)",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ));
      } else {
        return ListView.builder(
            itemCount: meals.length,
            itemBuilder: ((context, index) => MealItem(
                  meal: meals[index],
                  onSelectMeal: () => onSelectMeal(context, meals[index]),
                )));
      }
    }

    //This is for if meal page is coming from clicking categories screen
    if (meals.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(title!),
        ),
        body: const Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Uh...Ooh Nothing here ... :)",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        )),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
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
