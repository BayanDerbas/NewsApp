import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:posts/core/constants/app_messages.dart';
import 'package:posts/core/errors/failures.dart';
import 'package:posts/feauters/posts/domain/entities/post_entity.dart';
import 'package:posts/feauters/posts/domain/usecases/get_all_posts.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPosts;

  PostsBloc({required this.getAllPosts}) : super(PostsInitial()) {
    on<GetAllPostsEvent>((event, emit) async {
      emit(PostsLoading());
      final posts = await getAllPosts.call();
      emit(_mapFailureOrSuccessState(posts));
    });

    on<RefreshPostsEvent>((event, emit) async {
      emit(PostsLoading());
      final posts = await getAllPosts.call();
      emit(_mapFailureOrSuccessState(posts));
    });
  }

  PostsState _mapFailureOrSuccessState(
      Either<Failure, List<PostEntity>> either,
      ) {
    return either.fold(
          (failure) => PostsFailure(message: _mapFailureToMessage(failure)),
          (posts) => PostsSuccess(posts: posts),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return Server_Failure_Message;
      case EmptyCacheFailure:
        return Empty_Cache_Failure_Message;
      case OffLineFailure:
        return OffLine_Failure_Message;
      default:
        return "Unexpected Error.";
    }
  }
}