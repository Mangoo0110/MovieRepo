import 'dart:convert';

import 'package:hive/hive.dart';

import '../../models/todo_model.dart';

abstract class LocalTodoDatasource {

  Future<void> openDb({required String currentUid});

  Future<List<TodoModel>> fetchCatchedTodos();

  Future<void> catcheTodos(List<TodoModel> toDos);
  
}

class LocalTodoDatasourceImpl implements LocalTodoDatasource{


  static LocalTodoDatasourceImpl? _instance;
  static LocalTodoDatasourceImpl get instance {
    _instance ??= LocalTodoDatasourceImpl._();
    return _instance!;
  }

  LocalTodoDatasourceImpl._();

  Box? _todoBox;


  @override
  Future<List<TodoModel>> fetchCatchedTodos() async{

    _checkIfBoxIsOpened();

    List<TodoModel> todos = [];
    for(final data in _todoBox?.values ?? []) {
      try {
        final toDo = TodoModel.fromJson(jsonEncode(data));
        todos.add(toDo);
      } catch (e) {
        "";
      }
    }

    return todos;
  }
  

  @override
  Future<void> openDb({required String currentUid}) async{
    _todoBox ??= await Hive.openBox("$currentUid | todo");
  }
  

  @override
  Future<void> catcheTodos(List<TodoModel> toDos) async{

    _checkIfBoxIsOpened();

    for(final toDo in toDos) {
      await _todoBox?.put(toDo.id, toDo.toMap());
    }

  }


  void _checkIfBoxIsOpened() {
    if(_todoBox == null) {
      throw Exception("Local db is not open. Did you call openDb first?");
    }
  }

}