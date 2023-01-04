class Plan {
  String id;
  String titleEn;
  String titleAr;
  String descriptionEn;
  String descriptionAr;
  String image;

  Plan({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.image,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        id: json["id"],
        titleAr: json["title_ar"],
        titleEn: json["title_en"],
        descriptionAr: json["description_ar"],
        descriptionEn: json["description_en"],
        image: json["image"],
      );
}

class Package {
  String id;
  String titleEn;
  String titleAr;
  String descriptionEn;
  String descriptionAr;
  String image;
  String status;
  String categoryId;
  String meal;
  String snack;
  String breakfast;
  String sevenDays;
  String fifteenDays;
  String thirtyDays;
  int selected;

  Package({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.image,
    required this.breakfast,
    required this.categoryId,
    required this.fifteenDays,
    required this.meal,
    required this.sevenDays,
    required this.snack,
    required this.status,
    required this.thirtyDays,
    this.selected = 7,
  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
        id: json["id"],
        titleAr: json["title_ar"],
        titleEn: json["title_en"],
        descriptionAr: json["description_ar"],
        descriptionEn: json["description_en"],
        image: json["image"],
        breakfast: json["breakfast"],
        categoryId: json["category_id"],
        fifteenDays: json["15_days"],
        sevenDays: json["7_days"],
        thirtyDays: json["30_days"],
        snack: json["snack"],
        status: json["status"],
        meal: json["meal"],
        selected: 7,
      );
}
