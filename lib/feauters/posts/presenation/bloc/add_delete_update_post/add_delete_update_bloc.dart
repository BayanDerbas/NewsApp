import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/constants/app_Messages.dart';
import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/post_entity.dart';
import '../../../domain/repositories/post_repository.dart';

part 'add_delete_update_event.dart';
part 'add_delete_update_state.dart';

class AddDeleteUpdateBloc extends Bloc<AddDeleteUpdateEvent, AddDeleteUpdateState> {
  final PostRepository repository;

  AddDeleteUpdateBloc({required this.repository})
      : super(AddDeleteUpdateInitial()) {
    on<AddPostEvent>((event, emit) async {
      emit(AddDeleteUpdateLoading());
      final result = await repository.addPost(event.post);
      result.fold(
            (failure) =>
            emit(
                AddDeleteUpdateFailure(message: _mapFailureToMessage(failure))),
            (_) => emit(AddDeleteUpdateSuccess(message: 'Success')),
      );
    });

    on<UpdatePostEvent>((event, emit) async {
      emit(AddDeleteUpdateLoading());
      final result = await repository.updatePost(event.post);
      result.fold(
            (failure) =>
            emit(
                AddDeleteUpdateFailure(message: _mapFailureToMessage(failure))),
            (_) => emit(AddDeleteUpdateSuccess(message: 'Success')),
      );
    });

    on<DeletePostEvent>((event, emit) async {
      emit(AddDeleteUpdateLoading());
      final result = await repository.deletePost(event.postId);
      result.fold(
            (failure) =>
            emit(
                AddDeleteUpdateFailure(message: _mapFailureToMessage(failure))),
            (_) => emit(AddDeleteUpdateSuccess(message: 'Success')),
      );
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure():
        return Server_Failure_Message;
      case EmptyCacheFailure():
        return Empty_Cache_Failure_Message;
      case OffLineFailure():
        return OffLine_Failure_Message;
      default:
        return "  UnExpected Error . ";
    }
  }
}