part of 'users_bloc.dart';

sealed class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

// Event to fetch posts
final class FetchUsers extends UsersEvent {}