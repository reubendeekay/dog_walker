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
      'isEnable': enabled,
      'user_type': userType,
      'user_password': password,
    };
  }

  factory OwnerModel.fromJson(dynamic json) {
    return OwnerModel(
      id: json['user_id'],
      name: json['user_name'],
      userId: json['user_id'],
      description: json['user_description'],
      email: json['user_email'],
      address: json['user_address'],
      age: json['user_age'],
      image: json['user_image'],
      enabled: json['isEnable'],
      password: json['user_password'],
    );
  }
}
