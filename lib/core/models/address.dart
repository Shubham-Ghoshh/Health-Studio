import 'dart:isolate';

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
  String? isDefaultRequest;

  AddressListing({
    this.id,
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
    this.isDefault,
    this.isDefaultRequest,
  });

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
    isDefaultRequest = json["is_default_request"];
  }
}

class GetCities {
  int? error;
  String? message;
  List<Details>? details;

  GetCities({this.error, this.message, this.details});

  GetCities.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['message'] = message;
    if (details != null) {
      data['details'] = details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  String? nameEn;
  String? nameAr;
  List<Cities>? cities;

  Details({this.nameEn, this.nameAr, this.cities});

  Details.fromJson(Map<String, dynamic> json) {
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities!.add(Cities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name_en'] = nameEn;
    data['name_ar'] = nameAr;
    if (cities != null) {
      data['cities'] = cities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cities {
  String? id;
  String? nameEn;
  String? nameAr;

  Cities({this.id, this.nameEn, this.nameAr});

  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name_en'] = nameEn;
    data['name_ar'] = nameAr;
    return data;
  }
}
