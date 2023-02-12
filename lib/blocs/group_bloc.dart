import 'dart:async';

import 'package:digitalfarming/blocs/repository/group_repository.dart';
import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/resources/app_logger.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/constants.dart';

class GroupBloc {
  final logger = AppLogger.get('GroupBloc');
  final GroupRepository _groupRepository = GroupRepository();

  final StreamController<Result> _groupController =
      StreamController<Result>();

  StreamSink get groupSink => _groupController.sink;
  Stream<Result> get groupStream => _groupController.stream;

  Future<void> getGroups() async {
    groupSink.add(Result.loading(Constants.LOADING));
    final Result<List<Basic>> response =
        await _groupRepository.getGroups();
    groupSink.add(response);
  }

  void dispose() {
    _groupController.close();
  }
}
