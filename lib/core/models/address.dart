class AddressListing {
  String? id;
  String? areaEn;
  String? areaAr;
  String? block;
  String? street;
  String? avenue;
  String? building;
  String? floor;
  String? apartementNumber;
  String? additionalDirection;
  String? cityEn;
  String? cityAr;
  String? governorateEn;
  String? governorateAr;
  String? isDefault;

  AddressListing(
      {this.id,
      this.areaEn,
      this.areaAr,
      this.block,
      this.street,
      this.avenue,
      this.building,
      this.floor,
      this.apartementNumber,
      this.additionalDirection,
      this.cityEn,
      this.cityAr,
      this.governorateEn,
      this.governorateAr,
      this.isDefault});

  AddressListing.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    areaEn = json['area_en'];
    areaAr = json['area_ar'];
    block = json['block'];
    street = json['street'];
    avenue = json['avenue'];
    building = json['building'];
    floor = json['floor'];
    apartementNumber = json['apartement_number'];
    additionalDirection = json['additional_direction'];
    cityEn = json['city_en'];
    cityAr = json['city_ar'];
    governorateEn = json['governorate_en'];
    governorateAr = json['governorate_ar'];
    isDefault = json['is_default'];
  }
}
