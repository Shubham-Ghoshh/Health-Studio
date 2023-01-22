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

class UserDetails {
  String? id;
  String? firstName;
  String? email;
  String? mobilePhone;
  String? gender;
  String? regType;
  String? socialId;
  String? authKey;
  String? orderReference;
  String? orderFrom;
  String? orderTo;
  String? orderStatus;
  String? categoryEn;
  String? categoryAr;
  String? packageEn;
  String? packageAr;
  String? categoryId;
  String? packageId;
  String? addressId;

  UserDetails(
      {this.id,
      this.firstName,
      this.email,
      this.mobilePhone,
      this.gender,
      this.regType,
      this.socialId,
      this.authKey,
      this.orderReference,
      this.orderFrom,
      this.orderTo,
      this.orderStatus,
      this.categoryEn,
      this.categoryAr,
      this.packageEn,
      this.packageAr,
      this.categoryId,
      this.packageId,
      this.addressId});

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    email = json['email'];
    mobilePhone = json['mobile_phone'];
    gender = json['gender'];
    regType = json['reg_type'];
    socialId = json['social_id'];
    authKey = json['auth_key'];
    orderReference = json['order_reference'];
    orderFrom = json['order_from'] == "" ? null : json['order_from'];
    orderTo = json['order_to'] == "" ? null : json['order_to'];
    orderStatus = json['order_status'];
    categoryEn = json['category_en'];
    categoryAr = json['category_ar'];
    packageEn = json['package_en'];
    packageAr = json['package_ar'];
    categoryId = json['category_id'];
    packageId = json['package_id'];
    addressId = json['address_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['email'] = email;
    data['mobile_phone'] = mobilePhone;
    data['gender'] = gender;
    data['reg_type'] = regType;
    data['social_id'] = socialId;
    data['auth_key'] = authKey;
    data['order_reference'] = orderReference;
    data['order_from'] = orderFrom;
    data['order_to'] = orderTo;
    data['order_status'] = orderStatus;
    data['category_en'] = categoryEn;
    data['category_ar'] = categoryAr;
    data['package_en'] = packageEn;
    data['package_ar'] = packageAr;
    data['category_id'] = categoryId;
    data['package_id'] = packageId;
    data['address_id'] = addressId;
    return data;
  }
}
