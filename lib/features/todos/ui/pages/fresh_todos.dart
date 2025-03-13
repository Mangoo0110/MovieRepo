import 'dart:math';

import 'package:flutter/material.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/func/dekhao.dart';
import '../../domain/entities/todo.dart';
import '../providers/fresh_todo_data_provider.dart';
import '../widgets/todo_list.dart';
import 'package:provider/provider.dart';

class FreshTodos extends StatelessWidget {
  const FreshTodos({super.key});

  @override
  Widget build(BuildContext context) {

    
    
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            elevation: 2,
            shadowColor: AppColors.context(context).textColor,
            toolbarHeight: 100,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Fresh Todos", style: Theme.of(context).textTheme.titleLarge,),
                Row(
                  children: [
                    Icon(Icons.eco, size: 30, color: Colors.green,),
                    Icon(Icons.eco, size: 30, color: Colors.green,),
                  ],
                ),
              ],
            ),
          ),
          body: FreshTodosBody()
        );
      },
    );
  }
}

class FreshTodosBody extends StatefulWidget {
  const FreshTodosBody({super.key});

  @override
  State<FreshTodosBody> createState() => _FreshTodosBodyState();
}

class _FreshTodosBodyState extends State<FreshTodosBody> {

  Future<void> fetchTodos() async {
    return await context.read<FreshTodoDataProvider>().fetchTodos();
  }

  @override
  void initState() {
    // TODO: implement initState
    Future.microtask(() => fetchTodos());
    super.initState();
  }


  List<Todo> todos = [];
  FreshTodosDataState dataState = LoadingFreshTodosState();


  @override
  Widget build(BuildContext context) {

    dataState = context.watch<FreshTodoDataProvider>().dataState;

    if(dataState.runtimeType == LoadedFreshTodosState) {
      todos = (dataState as LoadedFreshTodosState).todos;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          
          children: [
            if(dataState.runtimeType == LoadingFreshTodosState) LinearProgressIndicator(minHeight: 4,),

            Flexible(child: TodoList(todos: todos))
          ],
        );
      },
    );
  }
}


