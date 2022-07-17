class AdminModel {
  final String? name;
  String? userId;
  final String? email;
  final String? password;

  AdminModel({this.name, this.userId, this.email, this.password});

  Map<String, dynamic> toJson() {
    return {
      'user_name': name,
      'user_id': userId,
      'user_email': email,
    };
  }
}
