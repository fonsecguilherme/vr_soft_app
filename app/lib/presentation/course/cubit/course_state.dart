import '../../../data/models/course.dart';

sealed class CourseState {}

final class InitialCourse extends CourseState {}

final class LoadingCourse extends CourseState {}

final class SuccessCourse extends CourseState {
  final List<Course> courses;

  SuccessCourse({required this.courses});
}

final class ErrorCourse extends CourseState {
  final String errorMessage;

  ErrorCourse({required this.errorMessage});
}
