class SearchCriteria{
  String? key;
  String? operation;
  String? value;
  bool? orPredicate;

  SearchCriteria({this.key, this.operation, this.value, this.orPredicate});

  SearchCriteria.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    operation = json['operation'];
    value = json['value'];
    orPredicate = json['orPredicate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['operation'] = this.operation;
    data['value'] = this.value;
    data['orPredicate'] = this.orPredicate;
    return data;
  }
}