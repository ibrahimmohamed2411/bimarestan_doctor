class EndPoints {
  static const String baseUrl = 'http://192.168.1.3:8080/bimarestan/';
  static const String login = '${baseUrl}authentication/generate-token';
  static const String register = '${baseUrl}user/addUser';
  static const String getAllCategories = '${baseUrl}category/getAllCategories';
  static const String getClinicsByDoctorId = '${baseUrl}clinic/getAllClinicsByDoctor';
  static const String addClinic = '${baseUrl}clinic/addClinic';
  static const String profile = '${baseUrl}authentication/current-user';
  static const String updateProfile = '${baseUrl}user/updateUser';
}
