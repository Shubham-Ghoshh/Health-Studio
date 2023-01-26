class Meal {
  String id;
  String nameEn;
  String nameAr;
  // String descriptionEn;
  // String descriptionAr;
  String image;
  String menuType;
  String note;

  Meal(
      {required this.id,
      required this.nameEn,
      required this.nameAr,
      // required this.descriptionEn,
      // required this.descriptionAr,
      required this.image,
      required this.menuType,
      required this.note});

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json["id"],
      nameEn: json["name_en"],
      nameAr: json["name_ar"],
      // descriptionEn: json["description_en"],
      // descriptionAr: json["description_ar"],
      image: json["image"],
      menuType: json["menu_type"],
      note: json["note"],
    );
  }
}
