import 'dart:convert';
import 'package:bloc_ecommerce/core/cached/preferences.dart';
import 'package:bloc_ecommerce/core/cached/preferences_key.dart';
import 'package:bloc_ecommerce/core/error/exception.dart';
import 'package:bloc_ecommerce/features/authentication/data/model/login_model.dart';

abstract interface class AuthenticationLocalDataSource {
  Future<LoginResponseModel> getUserData();
}

class AuthenticationLocalDataSourceImpl implements AuthenticationLocalDataSource {
  AuthenticationLocalDataSourceImpl({required this.prefs});
  final Preferences prefs;

  @override
  Future<LoginResponseModel> getUserData() async {
    final userData = prefs.getStringValue(keyName: PreferencesKey.kUserAuthData);
    if(userData.isNotEmpty){
      return LoginResponseModel.fromJson(jsonDecode(userData));
    } else {
      throw UnauthorizedException();
    }
  }
}
