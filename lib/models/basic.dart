class Basic {
  Basic({
    this.id,
    this.name,
  });

  Basic.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  String? id;
  String? name;

  Map<dynamic, dynamic> toJson() {
    final map = <dynamic, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}
