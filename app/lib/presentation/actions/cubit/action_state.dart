sealed class ActionState {}

final class InitialActionState extends ActionState {}

final class SuccessActionState extends ActionState {}

final class ErrorActionState extends ActionState {
  final String errorMessage;

  ErrorActionState({required this.errorMessage});
}
