import 'package:app/presentation/actions/cubit/action_cubit.dart';
import 'package:app/presentation/widgets/save_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/course_repository.dart';
import 'cubit/course_cubit.dart';
import 'cubit/course_state.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  CourseCubit get cubit => context.read<CourseCubit>();
  CourseRepository get repository => context.read<CourseRepository>();

  @override
  void initState() {
    super.initState();

    cubit.getCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Curso',
        ),
      ),
      body: BlocBuilder<CourseCubit, CourseState>(
        builder: (context, state) {
          switch (state) {
            case InitialCourse():
              return const Center(child: Text('initical'));
            case LoadingCourse():
              return const Center(child: CircularProgressIndicator());
            case SuccessCourse():
              return Column(
                children: [
                  Flexible(
                    flex: 10,
                    child: ListView.builder(
                      itemCount: state.courses.length,
                      itemBuilder: (context, index) {
                        final course = state.courses.elementAt(index);

                        return ExpansionTile(
                          title: Text(course.description),
                          leading: Text('${course.id} - '),
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Text(
                                    'Ementa: ${course.courseSyllabus}',
                                  ),
                                ),
                              ],
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  Flexible(
                      flex: 1,
                      child: Container(
                        color: Colors.grey.shade300,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Center(
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                      create: (context) => ActionCubit(
                                        repository: repository,
                                      ),
                                      child: const SaveWidget(
                                        title: 'Cadastre seu Curso',
                                      ),
                                    ),
                                  ));
                                },
                                child: const Text('Cadastrar'),
                              ),
                            ),
                            const VerticalDivider(),
                            Center(
                              child: InkWell(
                                onTap: () {},
                                child: const Text('Excluir'),
                              ),
                            ),
                            const VerticalDivider(),
                            Center(
                              child: InkWell(
                                onTap: () {
                                  print('Editar');
                                },
                                child: const Text('Editar'),
                              ),
                            ),
                          ],
                        ),
                      ))
                ],
              );
            case ErrorCourse():
              return Center(child: Text(state.errorMessage));
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
