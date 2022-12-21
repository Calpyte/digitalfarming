class Menu {
  Menu({
    this.id,
    this.label,
    this.route,
    this.icon,
  });

  Menu.fromJson(dynamic json) {
    id = json['id'];
    label = json['label'];
    route = json['route'];
    icon = json['icon'];
  }
  String? id;
  String? label;
  String? route;
  String? icon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['label'] = label;
    map['route'] = route;
    map['icon'] = icon;
    return map;
  }
}
