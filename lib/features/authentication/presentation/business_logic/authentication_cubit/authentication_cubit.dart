import 'package:bloc_ecommerce/core/cached/preferences.dart';
import 'package:bloc_ecommerce/core/cached/preferences_key.dart';
import 'package:bloc_ecommerce/core/di/dependency_injection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationCubitState> {
  AuthenticationCubit() : super(AuthenticationCubitInitial());

  final prefs = sl<Preferences>();

  bool isRememberMeChecked = false;
  void toggleRememberMe(bool value) {
    isRememberMeChecked = value;
    emit(AuthenticationCheckboxToggled(value));
  }

  bool isUserLoggedIn(){
    String userData = prefs.getStringValue(keyName: PreferencesKey.kUserAuthData);
    String token = prefs.getStringValue(keyName: PreferencesKey.kAccessToken);
    return userData.isNotEmpty && token.isNotEmpty;
  }

}
