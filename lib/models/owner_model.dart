class OwnerModel {
  String? name;
  String? userId;
  String? description;
  String? email;
  String? address;
  String? age;
  String? id;
  String? image;
  String? password;
  bool? enabled;
  String? userType;

  OwnerModel(
      {this.name,
      this.userId,
      this.description,
      this.email,
      this.address,
      this.age,
      this.id,
      this.image,
      this.enabled,
      this.password,
      this.userType});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_name': name,
      'user_id': userId,
      'user_description': description,
      'user_email': email,
      'user_address': address,
      'user_age': age,
      'user_image': image,
      'enabled': enabled,
      'user_type': userType,
      'user_password': password,
    };
  }

  factory OwnerModel.fromJson(dynamic json) {
    return OwnerModel(
      id: json['user_id'] as String,
      name: json['user_name'] as String,
      userId: json['user_id'] as String,
      description: json['user_description'] as String,
      email: json['user_email'] as String,
      address: json['user_address'] as String,
      age: json['user_age'] as String,
      image: json['user_image'] as String,
      enabled: json['isEnable'] as bool,
      password: json['user_password'] as String,
    );
  }
}
