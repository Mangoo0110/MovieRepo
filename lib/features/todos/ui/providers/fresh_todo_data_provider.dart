import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_repo/core/utils/func/dekhao.dart';
import '../../domain/usecases/fetch_todos.dart';
import '../../../../init_dependencies.dart';

import '../../domain/entities/todo.dart';
import '../../domain/usecases/open_local_db.dart';

sealed class FreshTodosDataState{}

class LoadingFreshTodosState implements FreshTodosDataState {}

class LoadedFreshTodosState implements FreshTodosDataState {
  final List<Todo> todos;

  LoadedFreshTodosState({required this.todos});
}

class FreshTodoDataProvider extends ChangeNotifier{

  static FreshTodoDataProvider? _instance;
  static FreshTodoDataProvider get instance {
    _instance ??= FreshTodoDataProvider._();
    return _instance!;
  }

  FreshTodosDataState _dataState = LoadingFreshTodosState();
  FreshTodosDataState get dataState => _dataState;

  FreshTodoDataProvider._();

  Future<void> fetchTodos() async{

    _dataState = LoadingFreshTodosState(); notifyListeners();

    Future.delayed(Duration(seconds: 1)).then((_) async{
        await serviceLocator<OpenLocalDb>().call(OpenLocalDbParams(currentUid: "Test")).then((_) async{
          await serviceLocator<FetchTodos>().call(FetchTodosParams(remoteOnly: true)).then((lr) {
            lr.fold(
              (l) {
                _dataState = LoadedFreshTodosState(todos: []); notifyListeners();
                Fluttertoast.showToast(msg: "failed to fetch fresh data ${l.message}");
                dekhao("Failed to fetch fresh data");
              }, (r) {
                dekhao("Fetched fresh todos. Length is ${r.length}");
                _dataState = LoadedFreshTodosState(todos: r);
                notifyListeners();
              });
          });
      });
    });
    
  }

}