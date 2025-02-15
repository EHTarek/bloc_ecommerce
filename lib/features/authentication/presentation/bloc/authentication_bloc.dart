import 'dart:convert';

import 'package:bloc_ecommerce/core/cached/preferences.dart';
import 'package:bloc_ecommerce/core/cached/preferences_key.dart';
import 'package:bloc_ecommerce/features/authentication/domain/entity/login_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/empty_param.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/extra/token_service.dart';
import '../../domain/entity/sign_up_entity.dart';
import '../../domain/use_case/authentication_use_case.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;

  final tokenService = sl<TokenService>();
  final prefs = sl<Preferences>();

  AuthenticationBloc({
    required this.loginUseCase, required this.logoutUseCase,
  }) : super(AuthenticationInitial()) {
    on<LoginRequested>(_onLoginRequestedEvent);
    on<LogoutRequested>(_onLogoutRequestedEvent);
  }

  _onLoginRequestedEvent(LoginRequested event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    final result = await loginUseCase(params: LoginRequestEntity(
      email: event.email, password: event.password,
    ));

    if(event.isRememberMeChecked){
      await prefs.setStringValue(keyName: PreferencesKey.kUserEmail, value: event.email);
      await prefs.setStringValue(keyName: PreferencesKey.kUserPass, value: event.password);
    }

    result.fold(
      (failure) {
        switch (failure.runtimeType) {
          case const (ConnectionFailure):
            return emit(AuthenticationNoInternet());
          default:
            return emit(AuthenticationFailure(failure.message));
        }
      },
      (loginResponse) {
        tokenService.saveToken(loginResponse.token ?? '', loginResponse.token ?? '');
        prefs.setStringValue(
          keyName: PreferencesKey.kUserAuthData,
          value: jsonEncode(loginResponse.data?.toJson()),
        );

        emit(AuthenticationLoginSuccess(loginResponse));
      },
    );
  }

  _onLogoutRequestedEvent(LogoutRequested event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    final result = await logoutUseCase(params: EmptyParam());

    result.fold(
      (failure) {
        switch (failure.runtimeType) {
          case const (ConnectionFailure):
            return emit(AuthenticationNoInternet());
          case const (TokenInvalid):
            return emit(AuthenticationSessionOut());
          default:
            return emit(AuthenticationFailure(failure.message));
        }
      },
      (success) {
        tokenService.clearToken();
        emit(AuthenticationLogoutSuccess());
      },
    );
  }
}
