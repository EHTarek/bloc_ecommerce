import 'dart:convert';

import 'package:bloc_ecommerce/core/api/api_client.dart';
import 'package:bloc_ecommerce/core/api/api_endpoints.dart';
import 'package:bloc_ecommerce/core/cached/preferences.dart';
import 'package:bloc_ecommerce/core/cached/preferences_key.dart';
import 'package:bloc_ecommerce/core/error/exception.dart';
import 'package:bloc_ecommerce/core/extra/token_service.dart';
import 'package:bloc_ecommerce/features/authentication/data/model/login_model.dart';
import 'package:bloc_ecommerce/features/authentication/data/model/sign_up_model.dart';

abstract interface class AuthenticationRemoteDataSource {
  Future<SignUpResponseModel> register(Map<String, dynamic> data);

  Future<LoginResponseModel> login(Map<String, dynamic> data);

  Future<bool> logout();
}

class AuthenticationDataRemoteSourceImpl implements AuthenticationRemoteDataSource {
  AuthenticationDataRemoteSourceImpl({
    required this.client, required this.prefs, required this.tokenService,
  });
  final Preferences prefs;
  final ApiClient client;
  final TokenService tokenService;

  @override
  Future<LoginResponseModel> login(Map<String, dynamic> data) async {
    final response =  await client.postData(ApiEndpoints.userLogin(), data);
    if(response.statusCode == 200){
      final loginResponse = LoginResponseModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      await prefs.setStringValue(
        keyName: PreferencesKey.kUserAuthData,
        value: jsonEncode(loginResponse.toJson()),
      );
      await tokenService.saveToken(loginResponse.token ?? '', loginResponse.token ?? '');

      return loginResponse;
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SignUpResponseModel> register(Map<String, dynamic> data) async {
    final response =  await client.postData(ApiEndpoints.userLogin(), data);
    if(response.statusCode == 200){
      return SignUpResponseModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> logout() async {
    final response =  await client.postData(ApiEndpoints.userLogout(), {});
    if(response.statusCode == 200){
      tokenService.clearToken();
      return true;
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }
}
