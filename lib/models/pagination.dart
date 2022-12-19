import 'package:digitalfarming/models/search_criteria.dart';

class Pagination {
  int? draw;
  int? pageNo;
  int? pageSize;
  List<SearchCriteria>? filter;

  Pagination({this.draw, this.pageNo, this.pageSize, this.filter});

  Pagination.fromJson(Map<String, dynamic> json) {
    draw = json['draw'];
    pageNo = json['pageNo'];
    pageSize = json['pageSize'];
    if (json['filter'] != null) {
      filter = <SearchCriteria>[];
      json['filter'].forEach((v) {
        filter!.add(SearchCriteria.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['draw'] = draw;
    data['pageNo'] = pageNo;
    data['pageSize'] = pageSize;
    data['orPredicate'] = false;
    if (filter != null) {
      data['filter'] = filter!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}