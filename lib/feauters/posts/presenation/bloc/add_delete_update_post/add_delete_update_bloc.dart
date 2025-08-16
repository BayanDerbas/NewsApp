import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:posts/core/constants/app_Messages.dart';
import 'package:posts/core/errors/failures.dart';
import 'package:posts/feauters/posts/domain/entities/post_entity.dart';
import 'package:posts/feauters/posts/domain/usecases/add_post.dart';
import 'package:posts/feauters/posts/domain/usecases/delete_post.dart';
import 'package:posts/feauters/posts/domain/usecases/update_post.dart';
import 'package:posts/feauters/posts/presenation/bloc/posts/posts_bloc.dart';

part 'add_delete_update_event.dart';
part 'add_delete_update_state.dart';

class AddDeleteUpdateBloc
    extends Bloc<AddDeleteUpdateEvent, AddDeleteUpdateState> {
  final AddPostUseCase addPost;
  final DeletePostUseCase deletePost;
  final UpdatePostUseCase updatePost;
  AddDeleteUpdateBloc({
    required this.addPost,
    required this.deletePost,
    required this.updatePost,
  }) : super(AddDeleteUpdateInitial()) {
    on<AddDeleteUpdateEvent>((event, emit) async {

      if (event is AddPostEvent) {
        emit(AddDeleteUpdateLoading());
        final failureOrSuccessMessage = await addPost(event.post as PostEntity);
        emit(_either(failureOrSuccessMessage, Add_Success_Message));
      }

      else if (event is UpdatePostEvent) {
        emit(AddDeleteUpdateLoading());
        final failureOrSuccessMessage = await updatePost(
          event.post as PostEntity,
        );
        emit(_either(failureOrSuccessMessage, Update_Success_Message));
      }

      else if (event is DeletePostEvent) {
        emit(AddDeleteUpdateLoading());
        final failureOrSuccessMessage = await deletePost(event.postId);
        emit(_either(failureOrSuccessMessage, Delete_Success_Message));
      }
    });
  }
}

AddDeleteUpdateState _either(Either<Failure, Unit> either, String message) {
  return either.fold(
    (failure) => AddDeleteUpdateFailure(message: _mapFailureToMessage(failure)),
    (_) => AddDeleteUpdateSuccess(message: message),
  );
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
