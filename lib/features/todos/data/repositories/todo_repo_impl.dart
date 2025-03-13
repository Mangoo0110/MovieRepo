import 'package:dartz/dartz.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';
import '../../../../core/api_handler/trycatch.dart';
import '../datasources/local/local_todo_datasource.dart';
import '../datasources/remote/remote_todo_datasource.dart';
import '../../domain/entities/todo.dart';

import '../../domain/repositories/todo_repo.dart';

class TodoRepoImpl implements TodoRepo{

  final RemoteTodoDatasource _remoteDatasource;
  final LocalTodoDatasource _localDatasource;

  TodoRepoImpl(this._remoteDatasource, this._localDatasource);

  @override
  Future<Either<DataCRUDFailure, List<Todo>>> fetchTodos({bool? remoteOnly = false}) async{
    return await asyncTryCatch<List<Todo>>(tryFunc: () async{
      return await _fetchAndCatchToDos();
    }).then((lr) {
      return lr.fold(
        (l) async{

          if(remoteOnly == true) return Left(DataCRUDFailure(failure: Failure.timeout, message: "Timeout."));

          return await asyncTryCatch<List<Todo>>(tryFunc: () async{
            return await _localDatasource.fetchCatchedTodos();
          });

        },

        (r) => Right(r)
      );
    });
  }


  Future<List<Todo>> _fetchAndCatchToDos() async{
    return _remoteDatasource.fetchTodos().then((toDos) async{
      await _localDatasource.catcheTodos(toDos);
      return toDos;
    });
  }
  
  @override
  Future<Either<DataCRUDFailure, Success>> openLocalDb({required String currentUid}) async{
    return await asyncTryCatch<Success>(tryFunc: () async{
      return await _localDatasource.openDb(currentUid: currentUid).then((_) => Success(message: ""));
    });
  }

}