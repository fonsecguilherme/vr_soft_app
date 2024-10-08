import 'package:app/presentation/course/cubit/course_cubit.dart';
import 'package:app/presentation/course/cubit/course_state.dart';
import 'package:app/utils/messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/custom_text_field.dart';

class DeleteCourseWidget extends StatefulWidget {
  const DeleteCourseWidget({super.key, required this.title});

  final String title;

  @override
  State<DeleteCourseWidget> createState() => _DeleteCourseWidgetState();
}

class _DeleteCourseWidgetState extends State<DeleteCourseWidget> {
  TextEditingController idController = TextEditingController();
  CourseCubit get cubit => context.read<CourseCubit>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (_) {
        cubit.getCourses();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: BlocListener<CourseCubit, CourseState>(
          listener: (context, state) {
            if (state is ErrorCourse) {
              Messages.of(context).showError(state.errorMessage);
            } else if (state is ActionCourseSuccessState) {
              Messages.of(context).showSuccess('Excluído com sucesso!');
              Navigator.pop(context);
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 16.0),
                child: CustomTextField(
                  controller: idController,
                  hintText: 'ID a ser excluído',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ElevatedButton(
                  onPressed: () => cubit.deleteAction(id: idController.text),
                  child: const Text('Apagar!'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
