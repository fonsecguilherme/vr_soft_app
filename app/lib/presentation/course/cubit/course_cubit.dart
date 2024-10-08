import 'package:app/data/repositories/course_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/i_course_repository.dart';
import 'course_state.dart';

class CourseCubit extends Cubit<CourseState> {
  CourseCubit({required this.repository}) : super(InitialCourse());

  final CourseRepository repository;

  Future<void> getCourses() async {
    emit(LoadingCourse());

    try {
      final (data: result, error: error) = await repository.getAll();

      if (error is Failure) {
        emit(ErrorCourse(errorMessage: error.message));
        return;
      }

      if (result!.isEmpty) {
        emit(InitialCourse());
        return;
      }

      emit(SuccessCourse(courses: result));
    } catch (e) {
      emit(ErrorCourse(errorMessage: '$e'));
    }
  }

  Future<void> createCourse({
    required String description,
    required String syllabus,
  }) async {
    final emptyField = description.isEmpty || syllabus.isEmpty;

    if (emptyField) {
      emit(ErrorCourse(errorMessage: 'Algum campo está vazio.'));
      return;
    }

    try {
      final (data: result, error: error) = await repository.save(
        description: description,
        courseSyllabus: syllabus,
      );

      if (error is Failure) {
        emit(ErrorCourse(errorMessage: error.message));
        return;
      }
      emit(ActionCourseSuccessState(message: result!));
    } catch (e) {
      emit(ErrorCourse(errorMessage: '$e'));
    }
  }

  Future<void> deleteAction({
    required String id,
  }) async {
    final emptyField = id.isEmpty;

    if (emptyField) {
      emit(ErrorCourse(errorMessage: 'Parece que o ID está vazio.'));
      return;
    }

    int parsedId = int.parse(id);

    try {
      final (data: result, error: error) = await repository.delete(parsedId);

      if (error is Failure) {
        emit(ErrorCourse(errorMessage: error.message));
        return;
      }
      emit(ActionCourseSuccessState(message: result!));
    } catch (e) {
      emit(ErrorCourse(errorMessage: '$e'));
    }
  }

  Future<void> editAction({
    required String id,
    required String description,
    required String syllabus,
  }) async {
    final emptyID = id.isEmpty;

    if (emptyID) {
      emit(ErrorCourse(errorMessage: 'Parece que o ID está vazio.'));
      return;
    }

    int parsedId = int.parse(id);

    try {
      final (data: result, error: error) = await repository.update(
        id: parsedId,
        description: description,
        courseSyllabus: syllabus,
      );

      if (error is Failure) {
        emit(ErrorCourse(errorMessage: error.message));
        return;
      }

      emit(ActionCourseSuccessState(message: result!));
    } catch (e) {
      emit(ErrorCourse(errorMessage: '$e'));
    }
  }
}
