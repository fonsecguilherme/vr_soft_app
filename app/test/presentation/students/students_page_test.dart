import 'package:app/data/models/student.dart';
import 'package:app/data/repositories/students_repository.dart';
import 'package:app/domain/service/i_http_client.dart';
import 'package:app/presentation/students/cubit/students_cubit.dart';
import 'package:app/presentation/students/cubit/students_state.dart';
import 'package:app/presentation/students/students_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements IHttpClient {}

class MockStudentsCubit extends Mock implements StudentsCubit {}

late MockHttpClient mockHttpClient;
late StudentsCubit cubit;

void main() {
  setUp(() {
    mockHttpClient = MockHttpClient();
    cubit = MockStudentsCubit();
  });

  testWidgets('Find initial widgets when state is initial', (tester) async {
    when(() => cubit.stream).thenAnswer((_) => Stream.value(InitialStudents()));
    when(() => cubit.getStudents()).thenAnswer((_) async => Future.value());
    when(() => cubit.state).thenReturn(InitialStudents());

    await _createWidget(tester);

    expect(find.byKey(StudentsPage.studentsInitialKey), findsOneWidget);
  });
  testWidgets('Find loading widget when state is loading', (tester) async {
    when(() => cubit.stream).thenAnswer((_) => Stream.value(LoadingStudents()));
    when(() => cubit.getStudents()).thenAnswer((_) async => Future.value());
    when(() => cubit.state).thenReturn(LoadingStudents());

    await _createWidget(tester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Find error text when state is error', (tester) async {
    when(() => cubit.stream).thenAnswer(
        (_) => Stream.value(ErrorStudents(errorMessage: 'Meu erro')));

    when(() => cubit.getStudents()).thenAnswer((_) async => Future.value());
    when(() => cubit.state).thenReturn(ErrorStudents(errorMessage: 'Meu erro'));

    await _createWidget(tester);

    expect(find.text('Meu erro'), findsOneWidget);
  });

  testWidgets('Find success widgets when state is success', (tester) async {
    when(() => cubit.stream).thenAnswer(
        (_) => Stream.value(SuccessStudents(students: _studentList)));

    when(() => cubit.getStudents()).thenAnswer((_) async => Future.value());
    when(() => cubit.state).thenReturn(SuccessStudents(students: _studentList));

    await _createWidget(tester);

    expect(find.byKey(StudentsPage.studentsSuccessKey), findsOneWidget);
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
        child: BlocProvider.value(
          value: cubit,
          child: const StudentsPage(),
        ),
      ),
    ),
  );
}

final _studentList = [
  Student(id: 1, name: 'name', courses: []),
  Student(id: 2, name: 'name', courses: []),
];
