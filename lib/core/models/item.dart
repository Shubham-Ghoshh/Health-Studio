import 'package:health_studio_user/core/models/meal.dart';

class Item {
  String id;
  String price;
  String note;
  Meal meal;
  String carb;
  String protein;

  Item({
    required this.id,
    required this.price,
    required this.note,
    required this.meal,
    required this.carb,
    required this.protein,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        meal: Meal.fromJson(json),
        carb: "0",
        protein: "0",
        price: "0",
        note: json["note"],
      );
}
