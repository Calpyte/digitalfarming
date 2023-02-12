class Catalogue {
  String? id;
  String? name;
  String? type;

  Catalogue({this.id, this.name, this.type});

  Catalogue.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    return data;
  }
}