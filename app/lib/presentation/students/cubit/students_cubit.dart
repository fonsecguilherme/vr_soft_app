import 'package:app/data/repositories/students_repository.dart';
import 'package:bloc/bloc.dart';

import '../../../domain/repositories/i_course_repository.dart';
import 'students_state.dart';

class StudentsCubit extends Cubit<StudentsState> {
  StudentsCubit({required this.repository}) : super(InitialStudents());

  final StudentsRepository repository;

  Future<void> getStudents() async {
    emit(LoadingStudents());

    try {
      final (data: result, error: error) = await repository.getAll();

      if (error is Failure) {
        emit(ErrorStudents(errorMessage: error.message));
        return;
      }

      emit(SuccessStudents(students: result!));
    } catch (e) {
      emit(ErrorStudents(errorMessage: '$e'));
    }
  }

  Future<void> createStudent({required String name}) async {
    final emptyField = name.isEmpty;

    if (emptyField) {
      emit(ErrorStudents(errorMessage: 'Campo vazio.'));
      return;
    }

    try {
      final (data: result, error: error) = await repository.save(name: name);

      if (error is Failure) {
        emit(ErrorStudents(errorMessage: error.message));
        return;
      }

      emit(ActionStudentSuccessState(message: result!));
    } catch (e) {
      emit(ErrorStudents(errorMessage: '$e'));
    }
  }

  Future<void> deleteStudent({
    required String id,
  }) async {
    final emptyField = id.isEmpty;

    if (emptyField) {
      emit(ErrorStudents(errorMessage: 'Parece que o ID está vazio.'));
      return;
    }

    int parsedId = int.parse(id);

    try {
      final (data: result, error: error) =
          await repository.delete(id: parsedId);

      if (error is Failure) {
        emit(ErrorStudents(errorMessage: error.message));
        return;
      }

      emit(ActionStudentSuccessState(message: result!));
    } catch (e) {
      emit(ErrorStudents(errorMessage: '$e'));
    }
  }

  Future<void> updateStudent({
    required String id,
    required String name,
  }) async {
    final emptyField = id.isEmpty || name.isEmpty;

    if (emptyField) {
      emit(ErrorStudents(errorMessage: 'Parece que o ID está vazio.'));
      return;
    }

    int parsedId = int.parse(id);

    try {
      final (data: result, error: error) =
          await repository.update(id: parsedId, name: name);

      if (error is Failure) {
        emit(ErrorStudents(errorMessage: error.message));
        return;
      }

      emit(ActionStudentSuccessState(message: result!));
    } catch (e) {
      emit(ErrorStudents(errorMessage: '$e'));
    }
  }
}
