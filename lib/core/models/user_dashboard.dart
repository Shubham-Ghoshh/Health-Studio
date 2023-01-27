class UserDashboard {
  List<dynamic> thisweek;
  List<dynamic> nextweek;

  UserDashboard({
    required this.thisweek,
    required this.nextweek,
  });

  factory UserDashboard.fromJson(Map<String, dynamic> json) {
    return UserDashboard(
      nextweek:
          json["next"]["items"].map((e) => DashboardItem.fromJson(e)).toList(),
      thisweek: json["current"]["items"]
          .map((e) => DashboardItem.fromJson(e))
          .toList(),
    );
  }
}

class DashboardItem {
  String id;
  String dateRequested;
  String status;
  String dateText;
  String allowEdit;

  DashboardItem({
    required this.id,
    required this.dateRequested,
    required this.status,
    required this.dateText,
    this.allowEdit = "0",
  });

  factory DashboardItem.fromJson(Map<String, dynamic> json) => DashboardItem(
        id: json["id"],
        dateRequested: json["date"],
        status: json["status"],
        dateText: json["date_text"],
        allowEdit: json["allow_edit"],
      );
}
