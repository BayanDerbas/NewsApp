part of 'add_delete_update_bloc.dart';

abstract class AddDeleteUpdateEvent extends Equatable {
  const AddDeleteUpdateEvent();

  @override
  List<Object> get props => [];
}

class AddPostEvent extends AddDeleteUpdateEvent {
  final PostEntity post;

  const AddPostEvent({required this.post});

  @override
  List<Object> get props => [post];
}

class UpdatePostEvent extends AddDeleteUpdateEvent {
  final PostEntity post;

  const UpdatePostEvent({required this.post});

  @override
  List<Object> get props => [post];
}

class DeletePostEvent extends AddDeleteUpdateEvent {
  final int postId;

  const DeletePostEvent({required this.postId});

  @override
  List<Object> get props => [postId];
}
