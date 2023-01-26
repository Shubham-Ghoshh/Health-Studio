import 'package:health_studio_user/core/models/item.dart';

class MealItem {
  String titleEn;
  String titleAr;
  String key;
  String number;
  List items;

  MealItem({
    required this.titleEn,
    required this.number,
    required this.titleAr,
    required this.key,
    required this.items,
  });

  factory MealItem.fromJson(Map<String, dynamic> json) {
    return MealItem(
      titleEn: json["title_en"],
      number: json["number"],
      titleAr: json["title_ar"],
      key: json["key"],
      items: json["items"] == []
          ? json["items"]
          : List<Item>.from(
              json["items"].map((e) => Item.fromJson(e)).toList()),
    );
  }
}


// [{title_en: Meal, title_ar: وجبة, key: meal, number: 2, items: []}, {title_en: Snack, title_ar: وجبة خفيفة, key: snack, number: 1, items: []}, {title_en: Breakfast, title_ar: وجبة افطار, key: breakfast, number: 1, items: []}]}