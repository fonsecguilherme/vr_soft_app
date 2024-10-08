sealed class EnrollState {}

final class InitialEnrollState extends EnrollState {}

final class SuccessEnrollState extends EnrollState {
  final String message;

  SuccessEnrollState({required this.message});
}

final class ErrorEnrollState extends EnrollState {
  final String errorMessage;

  ErrorEnrollState({required this.errorMessage});
}
