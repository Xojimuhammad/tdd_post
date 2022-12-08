import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_post/presentation/blocs/navigation/navigation_bloc.dart';
import 'package:tdd_post/presentation/blocs/observer.dart';
import 'package:tdd_post/presentation/pages/detail_page.dart';
import 'package:tdd_post/presentation/pages/home_page.dart';
import 'package:tdd_post/server_locator.dart';
import 'presentation/blocs/post/post_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationBloc>(
          create: (context) => locator<NavigationBloc>(),
        ),
        BlocProvider<PostBloc>(
          create: (_) => locator<PostBloc>(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: HomePage.id,
        routes: {
          HomePage.id: (context) => const HomePage(),
          DetailPage.id: (context) => const DetailPage(),
        },
      ),
    );
  }
}