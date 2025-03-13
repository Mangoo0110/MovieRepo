import '../../models/todo_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class RemoteTodoDatasource {
  Future<List<TodoModel>> fetchTodos();
}

class RemoteTodoDatasourceImpl implements RemoteTodoDatasource{

  static RemoteTodoDatasourceImpl? _instance;

  RemoteTodoDatasourceImpl._internal();

  static RemoteTodoDatasourceImpl get instance {
    _instance ??= RemoteTodoDatasourceImpl._internal(); 
    return _instance!;
  }

  @override
  Future<List<TodoModel>> fetchTodos() async{
    
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => TodoModel.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load todos');
    }
  }

}