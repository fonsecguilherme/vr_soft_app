import 'package:app/data/models/student.dart';
import 'package:app/data/repositories/students_repository.dart';
import 'package:app/domain/repositories/i_course_repository.dart';
import 'package:app/presentation/students/cubit/students_cubit.dart';
import 'package:app/presentation/students/cubit/students_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStudentsCubit extends MockCubit<StudentsState>
    implements StudentsCubit {}

class MockStudentsRepository extends Mock implements StudentsRepository {}

late StudentsCubit cubit;
late StudentsRepository repository;

void main() {
  setUp(
    () {
      cubit = MockStudentsCubit();
      repository = MockStudentsRepository();
    },
  );

  group('GetStudents | ', () {
    blocTest<StudentsCubit, StudentsState>(
      'Emits SuccessStudents after success to retreive students from repository',
      build: () {
        when(() => repository.getAll())
            .thenAnswer((_) async => (data: _studentList, error: Empty()));

        return StudentsCubit(repository: repository);
      },
      act: (cubit) => cubit.getStudents(),
      expect: () => <StudentsState>[
        LoadingStudents(),
        SuccessStudents(students: _studentList)
      ],
    );

    blocTest<StudentsCubit, StudentsState>(
      'Emits ErrorStudents after failed to retreive students from repository',
      build: () {
        when(() => repository.getAll()).thenAnswer(
            (_) async => (data: null, error: Failure(message: 'Erro')));

        return StudentsCubit(repository: repository);
      },
      act: (cubit) => cubit.getStudents(),
      expect: () => <StudentsState>[
        LoadingStudents(),
        ErrorStudents(errorMessage: 'Erro')
      ],
    );

    blocTest<StudentsCubit, StudentsState>(
      'Emits Exception after failed to retreive students from repository',
      build: () {
        when(() => repository.getAll()).thenThrow(Exception('exceção'));

        return StudentsCubit(repository: repository);
      },
      act: (cubit) => cubit.getStudents(),
      expect: () => <StudentsState>[
        LoadingStudents(),
        ErrorStudents(errorMessage: 'Exception: exceção')
      ],
    );
  });

  group('CreateStudent | ', () {
    blocTest<StudentsCubit, StudentsState>(
      'Emits ActionStudentSuccessState after success to create student',
      build: () {
        when(() => repository.save(name: 'Guilherme'))
            .thenAnswer((_) async => (data: 'Sucesso', error: Empty()));

        return StudentsCubit(repository: repository);
      },
      act: (cubit) => cubit.createStudent(name: 'Guilherme'),
      expect: () => <StudentsState>[
        ActionStudentSuccessState(message: 'Sucesso'),
      ],
    );

    blocTest<StudentsCubit, StudentsState>(
      'Emits ErrorStudents after failed to create student',
      build: () {
        when(() => repository.save(name: 'Guilherme')).thenAnswer(
            (_) async => (data: null, error: Failure(message: 'Erro')));

        return StudentsCubit(repository: repository);
      },
      act: (cubit) => cubit.createStudent(name: 'Guilherme'),
      expect: () => <StudentsState>[
        ErrorStudents(errorMessage: 'Erro'),
      ],
    );

    blocTest<StudentsCubit, StudentsState>(
      'Emits Exception after failed to create student',
      build: () {
        when(() => repository.save(name: 'Guilherme'))
            .thenThrow(Exception('exceção'));

        return StudentsCubit(repository: repository);
      },
      act: (cubit) => cubit.createStudent(name: 'Guilherme'),
      expect: () =>
          <StudentsState>[ErrorStudents(errorMessage: 'Exception: exceção')],
    );
  });
}

final _studentList = [
  Student(id: 1, name: 'name', courses: []),
];
