import 'package:dartz/dartz.dart';
import 'package:movie_repo/core/api_handler/failure.dart';

import '../../../../core/api_handler/success.dart';
import '../entities/todo.dart';

abstract interface class TodoRepo {
  Future<Either<DataCRUDFailure, Success>> openLocalDb({required String currentUid});

  Future<Either<DataCRUDFailure, List<Todo>>> fetchTodos({bool remoteOnly = false});
}