part of 'users_bloc.dart';

sealed class UsersState extends Equatable {
  const UsersState();
}

final class UsersInitial extends UsersState {
  @override
  List<Object> get props => [];
}
final class UsersLoading extends UsersState {
  @override
  List<Object> get props => [];
}

final class UsersLoaded extends UsersState {
  final List<User> users;

  UsersLoaded({required this.users});

  @override
  List<Object> get props => [users];
}

final class UserError extends UsersState {
  final Failure failure;

  UserError({required this.failure});

  @override
  List<Object> get props => [failure];
}

