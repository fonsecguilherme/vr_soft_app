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

      emit(SuccessCourse(courses: result!));
    } catch (e) {
      emit(ErrorCourse(errorMessage: '$e'));
    }
  }
}
