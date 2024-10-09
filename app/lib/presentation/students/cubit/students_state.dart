import 'package:equatable/equatable.dart';

import '../../../data/models/student.dart';

sealed class StudentsState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class InitialStudents extends StudentsState {}

final class LoadingStudents extends StudentsState {}

final class SuccessStudents extends StudentsState {
  final List<Student> students;

  SuccessStudents({required this.students});
}

final class ErrorStudents extends StudentsState {
  final String errorMessage;

  ErrorStudents({required this.errorMessage});
}

final class ActionStudentSuccessState extends StudentsState {
  final String message;

  ActionStudentSuccessState({required this.message});
}
