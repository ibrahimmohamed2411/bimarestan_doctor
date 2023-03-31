class EndPoints {
  static const String baseUrl = 'http://192.168.1.3:8080/bimarestan/';
  static const String login = '${baseUrl}authentication/generate-token';
  static const String register = '${baseUrl}user/addUser';
  static const String getAllCategories = '${baseUrl}category/getAllCategories';
}
