import 'package:dartz/dartz.dart';
import '../../../../core/api_handler/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/todo_repo.dart';

import '../entities/todo.dart';

class FetchTodos implements AsyncEitherUsecase<List<Todo>, FetchTodosParams>{

  final TodoRepo _repo;

  FetchTodos(this._repo);

  @override
  Future<Either<DataCRUDFailure, List<Todo>>> call(FetchTodosParams params) async{
    return await _repo.fetchTodos(remoteOnly: params.remoteOnly);
  }

}

class FetchTodosParams{
  final bool remoteOnly;

  FetchTodosParams({required this.remoteOnly});

}