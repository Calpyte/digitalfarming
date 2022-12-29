import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/resources/result.dart';

import '../client/grade_client.dart';

class GradeRepository {
  GradeRepository({GradeClient? client}) {
    _client = client ?? GradeClient();
  }

  GradeClient _client = GradeClient();

  Future<Result<List<Basic>>> getGrades({required String varietyId}) async {
    return await _client.getGrades(varietyId: varietyId);
  }
}