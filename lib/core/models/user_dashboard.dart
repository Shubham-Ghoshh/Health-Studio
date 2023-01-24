class UserDashboard {
  List<dynamic> thisweek;
  List<dynamic> nextweek;

  UserDashboard({
    required this.thisweek,
    required this.nextweek,
  });

  factory UserDashboard.fromJson(Map<String, dynamic> json) {
    return UserDashboard(
      nextweek: json["nextweek"].map((e) => DashboardItem.fromJson(e)).toList(),
      thisweek: json["thisweek"].map((e) => DashboardItem.fromJson(e)).toList(),
    );
  }
}

class DashboardItem {
  String id;
  String customMenu;
  String orderReference;
  String dateRequested;
  String menuEn;
  String menuAr;
  String image;
  List detailed;

  DashboardItem({
    required this.id,
    required this.customMenu,
    required this.orderReference,
    required this.dateRequested,
    required this.menuAr,
    required this.menuEn,
    required this.image,
    required this.detailed,
  });

  factory DashboardItem.fromJson(Map<String, dynamic> json) => DashboardItem(
        id: json["id"],
        customMenu: json["custom_menu"],
        orderReference: json["order_reference"],
        dateRequested: json["date_requested"],
        menuAr: json["menu_ar"],
        menuEn: json["menu_en"],
        image: json["image"],
        detailed: json["detailed"],
      );
}
