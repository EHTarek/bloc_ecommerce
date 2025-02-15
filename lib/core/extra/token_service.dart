import 'dart:convert';
import 'package:bloc_ecommerce/core/api/api_client.dart';
import 'package:bloc_ecommerce/core/api/api_endpoints.dart';
import 'package:bloc_ecommerce/core/cached/preferences.dart';
import 'package:bloc_ecommerce/core/cached/preferences_key.dart';
import 'package:bloc_ecommerce/core/di/dependency_injection.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

abstract class TokenService {
  Future<String> getToken();
  Future<bool> saveToken(String accessToken, String refreshToken);
  String getRefreshToken();
  void clearToken();
}

class TokenServiceImpl extends TokenService {
  TokenServiceImpl({required this.preferences, required this.client});

  final Preferences preferences;
  final Client client;

  @override
  Future<String> getToken() async {
    String accessToken = preferences.getStringValue(keyName: PreferencesKey.kAccessToken);
    String refreshToken = preferences.getStringValue(keyName: PreferencesKey.kRefreshToken);

    try {
      if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
        return accessToken;

        /*if (!JwtDecoder.isExpired(accessToken)) {
          return accessToken;
        } else if (!JwtDecoder.isExpired(refreshToken)) {
          return await _refresh(refreshToken);
        }*/
      }
    } catch (e) {
      debugPrint('Token Error: $e');
    }
    return '';
  }

  Future<String> _refresh(String refreshToken) async {
    try {
      final response = await client.post(ApiEndpoints.updateAccessToken(), body: jsonEncode({'refresh': refreshToken}));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final newAccessToken = data['access'];
        final newRefreshToken = data['refresh'];
        await saveToken(newAccessToken, newRefreshToken);

        return newAccessToken;
      }
    } catch (e) {
      debugPrint('Token Refresh Error: $e');
    }
    return '';
  }

  @override
  String getRefreshToken() {
    return preferences.getStringValue(keyName: PreferencesKey.kRefreshToken);
  }

  @override
  Future<bool> saveToken(String accessToken, String refreshToken) async {
    await preferences.setStringValue(keyName: PreferencesKey.kAccessToken, value: accessToken);
    await preferences.setStringValue(keyName: PreferencesKey.kRefreshToken, value: refreshToken);

    final apiClient = sl.get<ApiClient>();
    await apiClient.initialize();
    return true;
  }

  @override
  void clearToken() {
    preferences.clearOne(keyName: PreferencesKey.kAccessToken);
    preferences.clearOne(keyName: PreferencesKey.kRefreshToken);
  }
}
