class PlanDetail {
  String id;
  String titleEn;
  String titleAr;
  String descriptionEn;
  String descriptionAr;
  String image;
  String grams;
  String carb;
  String protein;
  String? proteinPrice;
  String? carbPrice;
  String? mealSevenDays;
  String? mealFifteenDays;
  String? mealThirtyDays;
  String? breakfastSevenDays;
  String? breakfastFifteenDays;
  String? breakfastThirtyDays;
  String? snackSevenDays;
  String? snackFifteenDays;
  String? snackThirtyDays;

  PlanDetail({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.image,
    required this.grams,
    required this.carb,
    required this.protein,
    this.proteinPrice,
    this.carbPrice,
    this.mealSevenDays,
    this.mealFifteenDays,
    this.mealThirtyDays,
    this.breakfastSevenDays,
    this.breakfastFifteenDays,
    this.breakfastThirtyDays,
    this.snackSevenDays,
    this.snackFifteenDays,
    this.snackThirtyDays,
  });
  factory PlanDetail.fromJson(Map<String, dynamic> json) => PlanDetail(
        id: json["id"],
        titleAr: json["title_ar"],
        titleEn: json["title_en"],
        descriptionAr: json["description_ar"],
        descriptionEn: json["description_en"],
        image: json["image"],
        grams: json["grams"],
        protein: json["protein"],
        carb: json["carb"],
        proteinPrice: json["protein_price"],
        carbPrice: json["carb_price"],
        mealSevenDays: json["meal_7_days"] == "" ? "0" : json["meal_7_days"],
        mealFifteenDays:
            json["meal_15_days"] == "" ? "0" : json["meal_15_days"],
        mealThirtyDays: json["meal_30_days"] == "" ? "0" : json["meal_30_days"],
        breakfastSevenDays:
            json["breakfast_7_days"] == "" ? "0" : json["breakfast_7_days"],
        breakfastFifteenDays:
            json["breakfast_15_days"] == "" ? "0" : json["breakfast_15_days"],
        breakfastThirtyDays:
            json["breakfast_30_days"] == "" ? "0" : json["breakfast_30_days"],
        snackSevenDays: json["snack_7_days"] == "" ? "0" : json["snack_7_days"],
        snackFifteenDays:
            json["snack_15_days"] == "" ? "0" : json["snack_15_days"],
        snackThirtyDays:
            json["snack_30_days"] == "" ? "0" : json["snack_30_days"],
      );
}
