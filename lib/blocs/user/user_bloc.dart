import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserState()) {
    on<SetDataEvent>((event, emit) {
      emit(state.copyWith(
          name: event.name,
          email: event.email,
          lastName: event.lastName,
          password: event.password));
    });
  }

  void setData(String name, String email, String lastName, String password) {
    add(SetDataEvent(name, email, lastName, password));
  }
}
