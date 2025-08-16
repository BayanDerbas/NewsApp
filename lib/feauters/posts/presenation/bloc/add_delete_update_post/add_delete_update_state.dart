part of 'add_delete_update_bloc.dart';

abstract class AddDeleteUpdateState extends Equatable {
  const AddDeleteUpdateState();

  @override
  List<Object> get props => [];
}

class AddDeleteUpdateInitial extends AddDeleteUpdateState {}

class AddDeleteUpdateLoading extends AddDeleteUpdateState {}

class AddDeleteUpdateSuccess extends AddDeleteUpdateState {
  final String message;

  AddDeleteUpdateSuccess({required this.message});
    @override
  List<Object> get props => [message];
}

class AddDeleteUpdateFailure extends AddDeleteUpdateState {
  final String message;

  AddDeleteUpdateFailure({required this.message});
    @override
  List<Object> get props => [message];
}
