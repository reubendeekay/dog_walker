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
      'user_description': description,
      'user_email': email,
      'experience': experience,
      'user_hourly_rate': hourlyRate,
      'user_image': image,
      'password': password,
      'reserved': reserved,
      'timing': timing,
      'type': userType,
      'lat': lat,
      'lng': long,
      'timingFrom': from,
      'timingTo': to,
      'availability': isAvailable,
      'enable': enabled,
      'rating': ratings
    };
  }

  factory WalkerModel.fromJson(dynamic json) {
    return WalkerModel(
      id: json['id'],
      name: json['user_name'],
      userId: json['user_id'],
      description: json['user_description'],
      email: json['user_email'],
      experience: json['experience'],
      hourlyRate: json['user_hourly_rate'],
      image: json['user_image'],
      timing: json['timing'],
      lat: double.parse(json['lat'].toString()),
      long: double.parse(json['lng'].toString()),
      from: json['timingFrom'],
      to: json['timingTo'],
      enabled: json['isEnable'],
      ratings: double.parse(json['rating'].toString()),
    );
  }
}
