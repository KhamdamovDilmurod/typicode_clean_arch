import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/get_user_usecase.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {

  final GetUsersUseCase getUsersUseCase;

  UsersBloc({
    required this.getUsersUseCase
  }) : super(UsersInitial()) {
    on<FetchUsers>(_onFetchUsers);
  }

  Future<void> _onFetchUsers(FetchUsers event, Emitter<UsersState> emit) async {
    emit(UsersLoading());
    final result = await getUsersUseCase();
    result.fold(
          (failure) => emit(UserError(failure: failure)),
          (users) => emit(UsersLoaded(users: users)),
    );
  }

}
