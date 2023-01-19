class NotificationsListing {
  String? id;
  String? messageEn;
  String? messageAr;
  String? image;
  bool? isSelected;

  NotificationsListing(
      {this.id, this.messageEn, this.messageAr, this.image, this.isSelected});

  NotificationsListing.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    messageEn = json['message_en'];
    messageAr = json['message_ar'];
    image = json['image'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['message_en'] = messageEn;
    data['message_ar'] = messageAr;
    data['image'] = image;
    data['isSelected'] = isSelected;
    return data;
  }
}