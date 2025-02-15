///Live Server
// const String _baseUrl = 'https://limerickbd.com';

///Test Server
const String _baseUrl = 'https://demo.limerickbd.com';

class ApiEndpoints {
  ApiEndpoints._();

  /// Token
  static Uri updateAccessToken() => Uri.parse('$_baseUrl/backend/public/api/refresh-token');

  /// Authentications
  static Uri userLogin() => Uri.parse('$_baseUrl/backend/public/api/login');
  static Uri userLogout() => Uri.parse('$_baseUrl/backend/public/api/logout');

  /// Dashboard
  static Uri getAllProducts() => Uri.parse('$_baseUrl/backend/public/api/fg-with-stock');
  static Uri getDashboardProductsCategory() => Uri.parse('$_baseUrl/products_category/');
}
