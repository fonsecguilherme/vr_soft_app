import 'package:app/data/repositories/enroll_repository.dart';
import 'package:bloc/bloc.dart';

import '../enroll_page.dart';
import 'enroll_state.dart';

class EnrollCubit extends Cubit<EnrollState> {
  EnrollCubit({
    required this.repository,
  }) : super(InitialEnrollState());

  final EnrollRepository repository;

  Future<void> functionSelector({
    required EnrollOptions selectedOption,
    required String courseId,
    required String studentId,
  }) async {
    selectedOption == EnrollOptions.delete
        ? deleteStudentFromCourse(courseId: courseId, studentId: studentId)
        : linkStudent(courseId: courseId, studentId: studentId);
  }

  Future<void> linkStudent({
    required String courseId,
    required String studentId,
  }) async {
    final emptyField = courseId.isEmpty || studentId.isEmpty;

    if (emptyField) {
      emit(ErrorEnrollState(errorMessage: 'Algum campo está vazio.'));
      return;
    }

    int parsedCourseId = int.parse(courseId);
    int parsedStudentId = int.parse(studentId);

    final result = await repository.save(
      courseId: parsedCourseId,
      studentId: parsedStudentId,
    );

    if (result != 'Aluno matriculado') {
      emit(ErrorEnrollState(errorMessage: result));
      return;
    }

    emit(SuccessEnrollState(message: result));
  }

  Future<void> deleteStudentFromCourse({
    required String courseId,
    required String studentId,
  }) async {
    final emptyField = courseId.isEmpty || studentId.isEmpty;

    if (emptyField) {
      emit(ErrorEnrollState(errorMessage: 'Algum campo está vazio.'));
      return;
    }

    int parsedCourseId = int.parse(courseId);
    int parsedStudentId = int.parse(studentId);

    final result = await repository.delete(
      courseId: parsedCourseId,
      studentId: parsedStudentId,
    );

    if (result != 'Aluno excluído do curso com sucesso!') {
      emit(ErrorEnrollState(errorMessage: result));
      return;
    }

    emit(SuccessEnrollState(message: result));
  }
}
