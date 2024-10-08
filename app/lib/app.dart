import 'package:app/data/repositories/course_repository.dart';
import 'package:app/data/repositories/enroll_repository.dart';
import 'package:app/data/repositories/students_repository.dart';
import 'package:app/data/service/http_client.dart';
import 'package:app/domain/service/i_http_client.dart';
import 'package:app/presentation/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<IHttpClient>(
          create: (context) => HttpClient(http.Client()),
        ),
        RepositoryProvider(
          create: (context) => CourseRepository(
            client: RepositoryProvider.of<IHttpClient>(context),
          ),
        ),
        RepositoryProvider(
          create: (context) => EnrollRepository(
            client: RepositoryProvider.of<IHttpClient>(context),
          ),
        ),
        RepositoryProvider(
          create: (context) => StudentsRepository(
            client: RepositoryProvider.of<IHttpClient>(context),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.orange,
          ),
        ),
        home: const Scaffold(
          body: HomePage(),
        ),
      ),
    );
  }
}
