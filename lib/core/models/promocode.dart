class PromoCode {
  String? nameEn;
  String? nameAr;
  String? code;
  String? discount;
  String? discountType;
  String? packageId;
  String? userId;
  String? description;
  String? status;
  String? expireDate;
  String? orderDiscountAmount;
  String? orderFinalAmount;

  PromoCode({
    this.code,
    this.description,
    this.discount,
    this.discountType,
    this.expireDate,
    this.nameAr,
    this.nameEn,
    this.orderDiscountAmount,
    this.orderFinalAmount,
    this.packageId,
    this.status,
    this.userId,
  });

  factory PromoCode.fromJson(Map<String, dynamic> json) {
    return PromoCode(
        nameEn: json["name_en"],
        nameAr: json["name_ar"],
        code: json["code"],
        description: json["description"],
        discount: json["discount"],
        discountType: json["discount_type"],
        packageId: json["package_id"],
        userId: json["user_id"],
        status: json["status"],
        expireDate: json["expire_date"],
        orderDiscountAmount: json["order_discount_amount"],
        orderFinalAmount: json["order_final_amount"]);
  }
}
