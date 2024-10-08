import 'package:app/data/repositories/course_repository.dart';
import 'package:bloc/bloc.dart';

import 'action_state.dart';

class ActionCubit extends Cubit<ActionState> {
  ActionCubit({required this.repository}) : super(InitialActionState());

  final CourseRepository repository;

  Future<void> saveAction({
    required String description,
    required String syllabus,
  }) async {
    final emptyField = description.isEmpty || syllabus.isEmpty;

    if (emptyField) {
      emit(ErrorActionState(errorMessage: 'Algum campo está vazio.'));
      return;
    }

    final result = await repository.save(
      description: description,
      courseSyllabus: syllabus,
    );

    if (!result) {
      emit(ErrorActionState(errorMessage: 'Erro ao criar curso.'));
      return;
    }

    emit(SuccessActionState());
  }

  Future<void> deleteAction({
    required String id,
  }) async {
    final emptyField = id.isEmpty;

    if (emptyField) {
      emit(ErrorActionState(errorMessage: 'Parece que o ID está vazio.'));
      return;
    }

    int parsedId = int.parse(id);

    final result = await repository.delete(parsedId);

    if (result != 'Curso excluído com sucesso') {
      emit(ErrorActionState(errorMessage: result));
      return;
    }

    emit(SuccessActionState());
  }

  Future<void> editAction({
    required String id,
    required String description,
    required String syllabus,
  }) async {
    final emptyID = id.isEmpty;

    if (emptyID) {
      emit(ErrorActionState(errorMessage: 'Parece que o ID está vazio.'));
      return;
    }

    int parsedId = int.parse(id);

    final result = await repository.update(
      id: parsedId,
      description: description,
      courseSyllabus: syllabus,
    );

    if (result != 'Editado com sucesso.') {
      emit(ErrorActionState(errorMessage: result));
      return;
    }

    emit(SuccessActionState());
  }
}
