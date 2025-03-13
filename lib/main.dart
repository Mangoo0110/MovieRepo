import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hive/hive.dart';
import 'package:movie_repo/core/common/widgets/ui_button.dart';
import 'package:movie_repo/core/utils/constants/app_colors.dart';
import 'package:movie_repo/core/utils/constants/app_sizes.dart';
import 'package:movie_repo/core/utils/routing/smooth_page_transition.dart';
import 'package:movie_repo/features/movieshow/ui/pages/home.dart';
import 'package:movie_repo/features/todos/ui/pages/catched_todos.dart';
import 'features/todos/ui/pages/fresh_todos.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'core/utils/constants/app_names.dart';
import 'core/utils/themes/theme.dart';
import 'features/todos/ui/providers/catched_todo_data_provider.dart';
import 'features/todos/ui/providers/fresh_todo_data_provider.dart';
import 'init_dependencies.dart';

void main() async{
  
  WidgetsFlutterBinding.ensureInitialized();
  //BackgroundIsolateBinaryMessenger.ensureInitialized(ServicesBinding.rootIsolateToken);

  List<ChangeNotifierProvider> providers = [
    ChangeNotifierProvider<CatchedTodoDataProvider>(create: (context)=> CatchedTodoDataProvider.instance),
    ChangeNotifierProvider<FreshTodoDataProvider>(create: (context)=> FreshTodoDataProvider.instance),
  ];
  
  await getApplicationDocumentsDirectory().then((docDir)  async{
    Hive.init(docDir.path);

    await initDependencies().then((value) async{
      Animate.restartOnHotReload = true;
      runApp(
        MultiProvider(
          providers: providers,
          child: (const MyApp())));
    });
    
  });
  
}



class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppNames.nameOfTheApp,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: AssignmentPage()

    );
  }

}


class AssignmentPage extends StatelessWidget {
  const AssignmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 100,
            centerTitle: false,
            title: Text("Assignment", style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.context(context).textGreyColor)),
            
          ),
        
          body: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width: constraints.maxWidth,
                  decoration: BoxDecoration(
                    color: AppColors.context(context).contentBoxColor,
                    borderRadius: AppSizes.smallBorderRadius,
                  ),
                
                  child: UiButton(
                    borderRadius: AppSizes.smallBorderRadius,
                    onTap: () {
                      if(index == 0) {
                        Navigator.push(context, SmoothPageTransition().bottomToUp(secondScreen: HomeScreen()));
                      }
                
                      if(index == 1) {
                        Navigator.push(context, SmoothPageTransition().bottomToUp(secondScreen: FreshTodos()));
                      }
                
                      if(index == 2) {
                        Navigator.push(context, SmoothPageTransition().bottomToUp(secondScreen: CatchedTodos()));
                      }
                    },
                    child: Center(
                      child: Text("Assignment-${(index + 1).toString()}".toUpperCase(), style: Theme.of(context).textTheme.titleLarge,)
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }
    );
  }
}

 