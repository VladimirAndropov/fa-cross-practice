import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searcheable_list/models/user.dart';
import 'package:searcheable_list/services/users_repository.dart';


abstract class UserEvent {}

class LoadUserEvent extends UserEvent {}
class ClearUserEvent extends UserEvent {}

class UserBloc extends Bloc<UserEvent, UserState> {
  UsersRepository usersRepository;
  
  UserBloc(this.usersRepository) : super(Initial()) {
    on<LoadUserEvent>((event, emit) async {
      emit(Loading());
      try {
        List<User> users = await usersRepository.getAllUsers();
        emit(Loaded(loadedusers: users));
      } catch (e) {
        emit(Error());
      }
    });
    on<ClearUserEvent>((event, emit) async {
      emit(Initial());
    });
  }
}

abstract class UserState {}

class Initial extends UserState {}

class Loading extends UserState {}

class Loaded extends UserState {
  List<User> loadedusers;
  Loaded({required this.loadedusers});
}

class Error extends UserState {}