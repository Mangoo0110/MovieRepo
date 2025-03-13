

import 'package:get_it/get_it.dart';

import 'features/todos/data/datasources/local/local_todo_datasource.dart';
import 'features/todos/data/datasources/remote/remote_todo_datasource.dart';
import 'features/todos/data/repositories/todo_repo_impl.dart';
import 'features/todos/domain/repositories/todo_repo.dart';
import 'features/todos/domain/usecases/fetch_todos.dart';
import 'features/todos/domain/usecases/open_local_db.dart';

final serviceLocator = GetIt.instance;

  //::: Datasources [register singletone]

  //::: Repo [register factory]

  //::: Usecases

Future<void> initDependencies() async{
  _appServices();
}




void _appServices() {

  RemoteTodoDatasource remoteStoreDatasource = RemoteTodoDatasourceImpl.instance;
  
  LocalTodoDatasource localStoreDatasource = LocalTodoDatasourceImpl.instance;

  //::: Remote Datasource [register lazy singletone]
  serviceLocator.registerLazySingleton<RemoteTodoDatasource>(()=> remoteStoreDatasource);

  //::: Local Datasource [register lazy singletone]
  serviceLocator.registerLazySingleton<LocalTodoDatasource>(()=> localStoreDatasource);

  //::: Repo [register factory]
  serviceLocator.registerFactory<TodoRepo>(()=> TodoRepoImpl(serviceLocator<RemoteTodoDatasource>(), serviceLocator<LocalTodoDatasource>()));

  //::: Usecases [register lazy singletone]
  serviceLocator.registerLazySingleton(() => OpenLocalDb(serviceLocator<TodoRepo>()));
  serviceLocator.registerLazySingleton(() => FetchTodos(serviceLocator<TodoRepo>()));
}



