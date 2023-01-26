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
  String? id;
  String titleEn;
  String titleAr;
  String descriptionEn;
  String descriptionAr;
  String? image;
  String? status;
  String? categoryId;
  String meal;
  String snack;
  String breakfast;
  String sevenDays;
  String fifteenDays;
  String thirtyDays;
  int selected;
  bool isCustom;
  List? attributes;

  Package({
    this.id,
    required this.titleAr,
    required this.titleEn,
    required this.descriptionAr,
    required this.descriptionEn,
    this.image,
    required this.breakfast,
    this.categoryId,
    required this.fifteenDays,
    required this.meal,
    required this.sevenDays,
    required this.snack,
    this.status,
    required this.thirtyDays,
    this.selected = 7,
    this.isCustom = false,
    this.attributes,
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
        attributes: json["attributes"] == null
            ? []
            : json["attributes"].map((e) => Attribute.fromJson(e)).toList(),
      );
}

// [{title_en: Carbs, title_ar: Carbs, description_ar: null, description_en: null, value: 8}, {title_en: Protein, title_ar: Protein, description_ar: null, description_en: null, value: 6}]

class Attribute {
  String? value;
  String titleEn;
  String titleAr;
  String? descriptionEn;
  String? descriptionAr;

  Attribute({
    this.value,
    required this.titleAr,
    required this.titleEn,
    this.descriptionAr,
    this.descriptionEn,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) {
    return Attribute(
      value: json["value"],
      titleAr: json["title_ar"],
      titleEn: json["title_en"],
      descriptionAr: json["description_ar"],
      descriptionEn: json["description_en"],
    );
  }
}
