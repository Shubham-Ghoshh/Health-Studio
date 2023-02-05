class PackageDetail {
  String id;
  String titleEn;
  String titleAr;
  String descriptionEn;
  String descriptionAr;
  String image;
  String categoryId;
  String? price;
  String breakfast;
  String meal;
  String snack;

  PackageDetail({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.image,
    required this.categoryId,
    required this.breakfast,
    required this.meal,
    required this.snack,
    required this.price,
  });

  factory PackageDetail.fromJson(Map<String, dynamic> json) {
    return PackageDetail(
      id: json["id"] ?? "",
      titleAr: json["title_ar"],
      titleEn: json["title_en"],
      descriptionAr: json["description_ar"],
      descriptionEn: json["description_en"],
      image: json["image"],
      categoryId: json["category_id"],
      breakfast: (json["breakfast"] == '' || json["breakfast"] == null)
          ? '0'
          : json["breakfast"],
      meal: (json["meal"] == '' || json["meal"] == null) ? '0' : json["meal"],
      snack:
          (json["snack"] == '' || json["snack"] == null) ? '0' : json["snack"],
      price: json["price"],
    );
  }
}
