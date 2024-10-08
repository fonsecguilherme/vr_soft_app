import 'package:app/presentation/students/cubit/students_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/messages.dart';
import '../cubit/students_state.dart';

class DeleteStudentWidget extends StatefulWidget {
  const DeleteStudentWidget({super.key, required this.title});

  final String title;

  @override
  State<DeleteStudentWidget> createState() => _DeleteStudentWidgetState();
}

class _DeleteStudentWidgetState extends State<DeleteStudentWidget> {
  TextEditingController idController = TextEditingController();

  StudentsCubit get cubit => context.read<StudentsCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocListener<StudentsCubit, StudentsState>(
        listener: (context, state) {
          if (state is ErrorStudents) {
            Messages.of(context).showError(state.errorMessage);
          } else if (state is ActionSuccessState) {
            Messages.of(context).showSuccess(state.message);
            Navigator.pop(context);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: _CustomTextField(
                controller: idController,
                hintText: 'ID',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ElevatedButton(
                onPressed: () => cubit.createStudent(
                  name: idController.text,
                ),
                child: const Text('Criar!'),
              ),
            )
          ],
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
