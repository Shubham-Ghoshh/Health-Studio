class Subscription {
  String? orderReference;
  String? orderFrom;
  String? orderTo;

  Subscription({this.orderReference, this.orderFrom, this.orderTo});

  Subscription.fromJson(Map<String, dynamic> json) {
    orderReference = json['order_reference'];
    orderFrom = json['order_from'];
    orderTo = json['order_to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_reference'] = orderReference;
    data['order_from'] = orderFrom;
    data['order_to'] = orderTo;
    return data;
  }
}