import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movie_repo/core/utils/constants/app_colors.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/todo.dart';
import '../providers/catched_todo_data_provider.dart';
import '../widgets/todo_list.dart';

class CatchedTodos extends StatelessWidget {
  const CatchedTodos({super.key});

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
                Text("Catched Todos", style: Theme.of(context).textTheme.titleLarge,),
                Row(
                  children: [
                    Icon(Icons.eco, size: 30, color: Colors.orange,),
                    Icon(Icons.eco, size: 30, color: Colors.orange,),
                  ],
                ),
              ],
            ),
          ),
          body: const CatchedTodosBody()
        );
      },
    );
  }
}

class CatchedTodosBody extends StatefulWidget {
  const CatchedTodosBody({super.key});

  @override
  State<CatchedTodosBody> createState() => _CatchedTodosBodyState();
}

class _CatchedTodosBodyState extends State<CatchedTodosBody> {

  Future<void> fetchTodos() async {
    return await context.read<CatchedTodoDataProvider>().fetchTodos();
    //await CatchedTodoDataProvider.instance.fetchTodos();
  }

  @override
  void initState() {
    // TODO: implement initState
    Future.microtask(() => fetchTodos());
    super.initState();
  }

  List<Todo> todos = [];
  CatchedTodosDataState dataState = LoadingCatchedTodosState();


  @override
  Widget build(BuildContext context) {

    dataState = context.watch<CatchedTodoDataProvider>().dataState;
    if(dataState.runtimeType == LoadedCatchedTodosState) {
      todos = (dataState as LoadedCatchedTodosState).todos;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          
          children: [
            if(dataState.runtimeType == LoadingCatchedTodosState) LinearProgressIndicator(minHeight: 4,),

            Flexible(child: TodoList(todos: todos))
          ],
        );
      },
    );
  }
}


