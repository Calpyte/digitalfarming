import 'dart:async';

import 'package:digitalfarming/blocs/repository/grade_repository.dart';
import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/resources/app_logger.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/constants.dart';

class GradeBloc {
  final logger = AppLogger.get('GradeBloc');
  final GradeRepository _gradeRepository = GradeRepository();

  final StreamController<Result> _gradeController = StreamController<Result>();

  StreamSink get gradeSink => _gradeController.sink;
  Stream<Result> get gradeStream => _gradeController.stream;

  Future<void> getGrades({required String varietyId}) async {
    gradeSink.add(Result.loading(Constants.LOADING));
    final Result<List<Basic>> response =
        await _gradeRepository.getGrades(varietyId: varietyId);
    gradeSink.add(response);
  }

  void dispose() {
    _gradeController.close();
  }
}
