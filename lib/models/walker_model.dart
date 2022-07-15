class WalkerModel {
  final bool? isAvailable;
  final String? userType;
  String? userId;
  final String? name;
  final String? description;
  final String? email;
  final String? experience;
  final String? hourlyRate;
  String? image;
  final bool? enabled;
  final String? password;
  final bool? reserved;
  final String? timing;
  String? id;
  final double? lat;
  final double? long;
  final String? from;
  final String? to;
  final double? ratings;

  WalkerModel(
      {this.isAvailable,
      this.userType,
      this.userId,
      this.name,
      this.description,
      this.email,
      this.experience,
      this.hourlyRate,
      this.image,
      this.enabled,
      this.password,
      this.reserved,
      this.timing,
      this.ratings = 0,
      this.id,
      this.lat,
      this.long,
      this.from,
      this.to});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_name': name,
      'user_id': userId,
      'description': description,
      'user_email': email,
      'user_experience': experience,
      'user_hourly_rate': hourlyRate,
      'user_image': image,
      'password': password,
      'reserved': reserved,
      'timing': timing,
      'type': userType,
      'lat': lat,
      'long': long,
      'from': from,
      'to': to,
      'availability': isAvailable,
      'enable': enabled,
      'ratings': ratings
    };
  }

  factory WalkerModel.fromJson(dynamic json) {
    return WalkerModel(
      id: json['id'],
      name: json['user_name'],
      userId: json['user_id'],
      description: json['description'],
      email: json['user_email'],
      experience: json['user_experience'],
      hourlyRate: json['user_hourly_rate'],
      image: json['user_image'],
      password: json['password'],
      reserved: json['reserved'],
      timing: json['timing'],
      userType: json['type'],
      lat: double.parse(json['lat'].toString()),
      long: double.parse(json['lng'].toString()),
      from: json['from'],
      to: json['to'],
      isAvailable: json['availability'],
      enabled: json['enable'],
      ratings: double.parse(json['rating'].toString()),
    );
  }
}
