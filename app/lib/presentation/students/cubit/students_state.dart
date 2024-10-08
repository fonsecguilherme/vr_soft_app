import '../../../data/models/student.dart';

sealed class StudentsState {}

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

final class ActionSuccessState extends StudentsState{ 

  final String message;

  ActionSuccessState({required this.message});


}
