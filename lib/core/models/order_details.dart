class OrderDetails {
  String amount;
  String paymentStatus;
  String categoryId;
  String categoryEn;
  String categoryAr;
  String packageEn;
  String packageAr;
  String orderReference;
  String? packageId;

  OrderDetails({
    required this.amount,
    required this.categoryAr,
    required this.categoryEn,
    required this.categoryId,
    required this.orderReference,
    required this.packageAr,
    required this.packageEn,
    required this.paymentStatus,
    this.packageId,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
      amount: json["amount"],
      paymentStatus: json["payment_status"],
      categoryEn: json["category_en"],
      categoryAr: json["category_ar"],
      packageAr: json["package_ar"],
      packageEn: json["package_en"],
      orderReference: json["order_reference"],
      categoryId: json["category_id"],
      packageId: json["package_id"],
    );
  }
}
