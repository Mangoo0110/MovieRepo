import 'package:flutter/material.dart';
import 'package:movie_repo/core/utils/constants/app_colors.dart';
import 'package:movie_repo/core/utils/constants/app_sizes.dart';
import '../../domain/entities/todo.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  const TodoList({super.key, required this.todos});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        
        if(todos.isEmpty) {
          return Center(
            child:  Text("Empty!!", style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.context(context).textGreyColor),),
          );
        }
        return ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {

            final todo = todos[index];

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: todo.completed 
                ? _completedToDo(title: todo.title, context: context)
                : _yetToCompletedToDo(title: todo.title, context: context),
            );
          },
        );
      },
    );
  }

  Widget _completedToDo({required String title, required BuildContext context}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 70,
          width: constraints.maxWidth,
          decoration: BoxDecoration(
            color: AppColors.context(context).contentBoxGreyColor,
            borderRadius: AppSizes.mediumBorderRadius,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.check_box, color: AppColors.context(context).textGreyColor,),
                SizedBox(width: 8,),
                Flexible(
                  child: Text(
                    title, 
                    maxLines: 2, 
                    
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.context(context).textGreyColor, decoration: TextDecoration.lineThrough),
                  ),
                ),
              ],
            ),
          )
        );
      }
    );
  }

  Widget _yetToCompletedToDo({required String title, required BuildContext context}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(
            //color: Colors.green,
            color: AppColors.context(context).contentBoxColor,
            borderRadius: AppSizes.mediumBorderRadius
          ),
          child: LimitedBox(
            maxHeight: 100,
            maxWidth: constraints.maxWidth,
            
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.circle, size: 18, color: Colors.green,),
                  SizedBox(height: 10,),
                  Flexible(
                    child: Text(
                      title, 
                      maxLines: 20, 
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(),
                    ),
                  ),
                ],
              ),
            )
          ),
        );
      }
    );
  }
}