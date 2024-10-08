import 'package:app/utils/messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/course_cubit.dart';
import '../cubit/course_state.dart';

class EditCourseWidget extends StatefulWidget {
  const EditCourseWidget({super.key, required this.title});

  final String title;

  @override
  State<EditCourseWidget> createState() => _EditCourseWidgetState();
}

class _EditCourseWidgetState extends State<EditCourseWidget> {
  TextEditingController idController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController syllabusController = TextEditingController();
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
              Messages.of(context).showSuccess('Criado com sucesso!');
              Navigator.pop(context);
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: _CustomTextField(
                  controller: idController,
                  hintText: 'ID',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 16.0),
                child: _CustomTextField(
                  controller: descriptionController,
                  hintText: 'Descrição',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: _CustomTextField(
                  controller: syllabusController,
                  hintText: 'Ementa',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ElevatedButton(
                  onPressed: () => cubit.editAction(
                    id: idController.text,
                    description: descriptionController.text,
                    syllabus: syllabusController.text,
                  ),
                  child: const Text('Editar!'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomTextField extends StatelessWidget {
  const _CustomTextField({
    required this.controller,
    required this.hintText,
  });

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onEditingComplete: () {},
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: 2.0,
          ),
        ),
        filled: true,
        hintStyle: const TextStyle(color: Colors.grey),
        hintText: hintText,
      ),
    );
  }
}
