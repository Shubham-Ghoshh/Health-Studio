class Order {
  String? planId;
  String? packageId;
  String? amount;
  String? addressId;
  String? startDate;
  String? endDate;
  String? method;
  String? meal;
  String? breakfast;
  String? snack;
  bool isCustom;

  Order({
    this.planId,
    this.packageId,
    this.amount,
    this.addressId,
    this.startDate,
    this.endDate,
    this.method = "knet",
    this.isCustom = false,
  });

  Map<String, dynamic> toJson() {
    return {
      "plan_id": planId,
      "package_id": packageId,
      "amount": amount,
      "address_id": addressId,
      "start_date": startDate,
      "end_date": endDate,
      "method": method,
      "meal": meal,
      "breakfast": breakfast,
      "snack": snack,
      "is_custom": isCustom,
    };
  }
}
