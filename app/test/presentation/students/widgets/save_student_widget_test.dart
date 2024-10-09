import 'dart:async';

import 'package:app/data/repositories/students_repository.dart';
import 'package:app/domain/service/i_http_client.dart';
import 'package:app/presentation/students/cubit/students_cubit.dart';
import 'package:app/presentation/students/cubit/students_state.dart';
import 'package:app/presentation/students/widgets/save_student_widget.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStudentsCubit extends MockCubit<StudentsState>
    implements StudentsCubit {}

class MockHttpClient extends Mock implements IHttpClient {}

late StudentsCubit cubit;
late MockHttpClient mockHttpClient;

void main() {
  setUp(
    () {
      cubit = MockStudentsCubit();
      mockHttpClient = MockHttpClient();
    },
  );

  group('FlushBar tests | ', () {
    testWidgets('Success snackbar', (tester) async {
      // TODO: Tive que adicionar o delay de 500ms para poder o teste executar
      await tester.runAsync(() async {
        when(() => cubit.createStudent(name: 'Guilherme'))
            .thenAnswer((_) async => Future.value());

        final state = StreamController<StudentsState>();
        whenListen(
          cubit,
          state.stream,
          initialState: InitialStudents(),
        );

        await _createWidget(tester);

        state.add(ActionStudentSuccessState(message: 'Succeso'));

        await tester.pump(const Duration(seconds: 1));
        await tester.pumpAndSettle(const Duration(seconds: 2));

        expect(
          find.text('Succeso'),
          findsOneWidget,
        );

        state.close();
      });
    });

    testWidgets('Error snackbar', (tester) async {
      await tester.runAsync(() async {
        when(() => cubit.createStudent(name: 'Guilherme'))
            .thenAnswer((_) async => Future.value());

        final state = StreamController<StudentsState>();
        whenListen(
          cubit,
          state.stream,
          initialState: InitialStudents(),
        );

        await _createWidget(tester);

        state.add(ErrorStudents(errorMessage: 'Erro'));

        await tester.pump();
        await tester.pumpAndSettle(const Duration(seconds: 2));

        expect(
          find.text('Erro'),
          findsOneWidget,
        );

        state.close();
      });
    });
  });
}

Future<void> _createWidget(WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<IHttpClient>(
            create: (context) => mockHttpClient,
          ),
          RepositoryProvider(
            create: (context) => StudentsRepository(
              client: RepositoryProvider.of<IHttpClient>(context),
            ),
          ),
        ],
        child: BlocProvider<StudentsCubit>.value(
          value: cubit,
          child: const SaveStudentWidget(
            title: 'Alunos',
          ),
        ),
      ),
    ),
  );
  await tester.pump();
}
