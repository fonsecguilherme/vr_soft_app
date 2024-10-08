import 'package:app/presentation/students/cubit/students_cubit.dart';
import 'package:app/presentation/students/cubit/students_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/delete_student_widget.dart';
import 'widgets/edit_student_widget.dart';
import 'widgets/save_student_widget.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  StudentsCubit get cubit => context.read<StudentsCubit>();

  @override
  void initState() {
    super.initState();
    cubit.getStudents();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Alunos',
          ),
        ),
        body: Column(
          children: [
            Flexible(
              flex: 10,
              child: BlocBuilder<StudentsCubit, StudentsState>(
                builder: (context, state) {
                  switch (state) {
                    case InitialStudents():
                      return const Center(child: SizedBox.shrink());
                    case LoadingStudents():
                      return const Center(child: CircularProgressIndicator());
                    case SuccessStudents():
                      return Column(
                        children: [
                          Flexible(
                            flex: 10,
                            child: ListView.builder(
                              itemCount: state.students.length,
                              itemBuilder: (context, index) {
                                final student = state.students.elementAt(index);

                                return ListTile(
                                  title: Text(student.name),
                                  leading: Text('${student.id} - '),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    case ErrorStudents():
                      return Center(child: Text(state.errorMessage));
                    default:
                      return const SizedBox.shrink();
                  }
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
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: cubit,
                                child: const DeleteStudentWidget(
                                  title: 'Exclusão de Aluno',
                                ),
                              ),
                            ),
                          );
                        },
                        child: const Text('Excluir'),
                      ),
                    ),
                    const VerticalDivider(),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: cubit,
                                child: const SaveStudentWidget(
                                  title: 'Cadastro de Aluno',
                                ),
                              ),
                            ),
                          );
                        },
                        child: const Text('Cadastrar'),
                      ),
                    ),
                    const VerticalDivider(),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: cubit,
                                child: const EditStudentWidget(
                                  title: 'Edição de Aluno',
                                ),
                              ),
                            ),
                          );
                        },
                        child: const Text('Editar'),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
}
