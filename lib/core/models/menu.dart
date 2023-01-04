class Menu {
  String id;
  String titleEn;
  String titleAr;
  String descriptionEn;
  String descriptionAr;
  String image;

  Menu({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.image,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        id: json["id"],
        titleAr: json["title_ar"],
        titleEn: json["title_en"],
        descriptionAr: json["description_ar"],
        descriptionEn: json["description_en"],
        image: json["image"],
      );
}

class Attribute {
  String titleEn;
  String? titleAr;
  String? descriptionEn;
  String? descriptionAr;
  String value;

  Attribute({
    required this.titleAr,
    required this.titleEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.value,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        titleAr: json["title_ar"],
        titleEn: json["title_en"],
        descriptionAr: json["description_ar"],
        descriptionEn: json["description_en"],
        value: json["value"],
      );
}

class MenuDetail {
  Menu menu;
  List<Attribute> attribute;

  MenuDetail({required this.menu, required this.attribute});
  factory MenuDetail.fromJson(Map<String, dynamic> json) => MenuDetail(
        menu: Menu.fromJson(json["menu"][0]),
        attribute: json["attribute"] == null
            ? <Attribute>[]
            : List<Attribute>.from(
                json["attribute"].map((e) => Attribute.fromJson(e)).toList(),
              ),
      );
}
