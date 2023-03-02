class Basic {
  Basic({
    this.id,
    this.name,
    this.tempId,
  });

  Basic.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tempId = json['tempId'];
  }

  String? id;
  String? name;
  String? tempId;

  Map<dynamic, dynamic> toJson() {
    final map = <dynamic, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['tempId'] = tempId;
    return map;
  }
}
