import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../core/utils/func/dekhao.dart';
import '../../domain/usecases/fetch_todos.dart';
import '../../../../init_dependencies.dart';
import '../../domain/usecases/open_local_db.dart';

import '../../domain/entities/todo.dart';

sealed class CatchedTodosDataState{}

class LoadingCatchedTodosState implements CatchedTodosDataState {}

class LoadedCatchedTodosState implements CatchedTodosDataState {
  final List<Todo> todos;

  LoadedCatchedTodosState({required this.todos});
}

class CatchedTodoDataProvider extends ChangeNotifier{

  static CatchedTodoDataProvider? _instance;
  static CatchedTodoDataProvider get instance {
    _instance ??= CatchedTodoDataProvider._();
    return _instance!;
  }

  CatchedTodosDataState _dataState = LoadingCatchedTodosState();
  CatchedTodosDataState get dataState => _dataState;

  CatchedTodoDataProvider._();

  Future<void> fetchTodos() async{

    _dataState = LoadingCatchedTodosState(); notifyListeners();

    Future.delayed(Duration(seconds: 1)).then((_) async{
        await serviceLocator<OpenLocalDb>().call(OpenLocalDbParams(currentUid: "Test")).then((_) async{
          await serviceLocator<FetchTodos>().call(FetchTodosParams(remoteOnly: false)).then((lr) {
            lr.fold(
              (l) {
                _dataState = LoadedCatchedTodosState(todos: []); notifyListeners();
                Fluttertoast.showToast(msg: "failed to fetch fresh data ${l.message}");
                dekhao("Failed to fetch fresh/catched data");
              }, (r) {
                
                dekhao("Fetched fresh/catched todos. Length is ${r.length}");

                _dataState = LoadedCatchedTodosState(todos: r);
                notifyListeners();
              });
          });
      });
    });
    

    
  }

}