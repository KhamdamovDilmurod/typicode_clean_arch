import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:typicode_clean_arch/features/typicode/domain/usecases/get_post_usecase.dart';
import 'package:typicode_clean_arch/features/typicode/domain/usecases/get_user_usecase.dart';
import 'package:typicode_clean_arch/features/typicode/domain/usecases/remove_post_usecase.dart';
import 'package:typicode_clean_arch/features/typicode/domain/usecases/save_post_usecase.dart';
import 'features/typicode/presentation/bloc/posts_bloc.dart';
import 'features/typicode/presentation/bloc/users_bloc.dart';
import 'features/typicode/presentation/pages/user_post_screen.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); // Initialize GetIt
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UsersBloc>(
          create: (BuildContext context) => UsersBloc(
              getUsersUseCase: di.sl<GetUsersUseCase>(),),
        ),
        BlocProvider<PostsBloc>(
          create: (BuildContext context) => PostsBloc(
              getPostsUseCase: di.sl<GetPostsUseCase>(),
              removePostUseCase: di.sl<RemovePostUseCase>(),
              savePostUseCase: di.sl<SavePostUseCase>()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: UserPostScreen(),
        // onGenerateRoute: di.sl<AppRouter>().onGenerateRoute,
      ),
    );
  }
}
