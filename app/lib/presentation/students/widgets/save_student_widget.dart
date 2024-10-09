import 'package:app/presentation/students/cubit/students_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/messages.dart';
import '../../widgets/custom_text_field.dart';
import '../cubit/students_state.dart';

class SaveStudentWidget extends StatefulWidget {
  const SaveStudentWidget({super.key, required this.title});

  final String title;

  @override
  State<SaveStudentWidget> createState() => _SaveStudentWidgetState();
}

class _SaveStudentWidgetState extends State<SaveStudentWidget> {
  TextEditingController nameController = TextEditingController();

  StudentsCubit get cubit => context.read<StudentsCubit>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (_) => cubit.getStudents(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: BlocListener<StudentsCubit, StudentsState>(
          listener: (context, state) {
            if (state is ErrorStudents) {
              Messages.of(context).showError(state.errorMessage);
            } else if (state is ActionStudentSuccessState) {
              Messages.of(context).showSuccess(state.message);
              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.pop(context);
              });
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 16.0),
                child: CustomTextField(
                  controller: nameController,
                  hintText: 'Nome',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ElevatedButton(
                  onPressed: () => cubit.createStudent(
                    name: nameController.text,
                  ),
                  child: const Text('Criar!'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
