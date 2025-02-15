part of 'authentication_data_source.dart';

class AuthenticationDataSourceImpl implements AuthenticationDataSource {
  AuthenticationDataSourceImpl({required this.client});

  final ApiClient client;

  @override
  Future<LoginResponseModel> login(Map<String, dynamic> data) async {
    final response =  await client.postData(ApiEndpoints.userLogin(), data);
    if(response.statusCode == 200){
      return LoginResponseModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
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
      return true;
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }
}
