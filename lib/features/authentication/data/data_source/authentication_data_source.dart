import 'dart:convert';

import 'package:bloc_ecommerce/core/api/api_client.dart';
import 'package:bloc_ecommerce/core/api/api_endpoints.dart';
import 'package:bloc_ecommerce/features/authentication/data/model/login_model.dart';
import 'package:bloc_ecommerce/features/authentication/data/model/sign_up_model.dart';

import '../../../../core/error/exception.dart';

part 'authentication_data_source_impl.dart';

abstract interface class AuthenticationDataSource {
  Future<SignUpResponseModel> register(Map<String, dynamic> data);

  Future<LoginResponseModel> login(Map<String, dynamic> data);

  Future<bool> logout();
}