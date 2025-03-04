import 'dart:convert';

import 'package:bloc_ecommerce/core/api/api_client.dart';
import 'package:bloc_ecommerce/core/error/exception.dart';
import 'package:bloc_ecommerce/core/api/api_endpoints.dart';
import 'package:bloc_ecommerce/features/dashboard/data/models/products_model.dart';

abstract class DashboardRemoteDataSource {
  Future<List<ProductsModel>> getProducts();

  Future<String> cartCheckout(List<Map<String, dynamic>> carts);
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final ApiClient client;

  DashboardRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductsModel>> getProducts() async {
    final response = await client.getData(ApiEndpoints.getAllProducts());
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      return data.map((e) => ProductsModel.fromJson(e)).toList();
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> cartCheckout(List<Map<String, dynamic>> carts) async {
    // final response = await client.postData(ApiEndpoints.getAllProducts());
    if (true) {
      return 'Order placed successfully';
    } /*else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }*/
  }
}
