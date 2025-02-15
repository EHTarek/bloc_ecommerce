import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationCubitState> {
  AuthenticationCubit() : super(AuthenticationCubitInitial());

  bool isRememberMeChecked = false;

  void toggleRememberMe(bool value) {
    isRememberMeChecked = value;
    emit(AuthenticationCheckboxToggled(value));
  }
}
