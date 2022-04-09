class RegisterModel {
  bool? success;
  String? message;
  String? token;

  RegisterModel({
    this.success,
    this.message,
    this.token,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      success: json['success'],
      message: json['message'],
      token: json['token'] ?? "",
    );
  }
}
