import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/messages.dart';
import 'cubit/enroll_cubit.dart';
import 'cubit/enroll_state.dart';

class EnrollPage extends StatefulWidget {
  const EnrollPage({super.key});

  @override
  State<EnrollPage> createState() => _EnrollPageState();
}

class _EnrollPageState extends State<EnrollPage> {
  TextEditingController studentIdController = TextEditingController();

  TextEditingController courseIdController = TextEditingController();

  EnrollCubit get cubit => context.read<EnrollCubit>();

  EnrollOptions selectedOption = EnrollOptions.enroll;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Matrícula',
        ),
      ),
      body: BlocListener<EnrollCubit, EnrollState>(
        listener: (context, state) {
          if (state is ErrorEnrollState) {
            Messages.of(context).showError(state.errorMessage);
          } else if (state is SuccessEnrollState) {
            Messages.of(context).showSuccess(state.message);
            Navigator.pop(context);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: _CustomTextField(
                controller: studentIdController,
                hintText: 'ID aluno',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: _CustomTextField(
                controller: courseIdController,
                hintText: 'ID curso',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SegmentedButton(
                segments: const <ButtonSegment<EnrollOptions>>[
                  ButtonSegment(
                      value: EnrollOptions.enroll, label: Text('Matricular')),
                  ButtonSegment(
                      value: EnrollOptions.delete, label: Text('Apagar')),
                ],
                selected: <EnrollOptions>{selectedOption},
                onSelectionChanged: (Set<EnrollOptions> newSelection) {
                  setState(() {
                    selectedOption = newSelection.first;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  cubit.functionSelector(
                    selectedOption: selectedOption,
                    courseId: courseIdController.text,
                    studentId: studentIdController.text,
                  );
                },
                child: const Text('Executar!'),
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
      keyboardType: TextInputType.number,
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

enum EnrollOptions { enroll, delete }
