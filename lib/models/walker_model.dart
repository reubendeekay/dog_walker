class WalkerModel {
  bool? isAvailable;
  String? userType;
  String? userId;
  String? name;
  String? description;
  String? email;
  String? experience;
  String? hourlyRate;
  String? image;
  bool? enabled;
  String? password;
  bool? reserved;
  String? timing;
  String? id;
  double? lat;
  double? long;
  String? from;
  String? to;
  double? ratings;

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
      this.reserved = true,
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
      'isEnabled': enabled,
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
      hourlyRate: json['user_hourly_rate'].toString(),
      image: json['user_image'],
      lat: double.parse(json['lat'].toString()),
      long: double.parse(json['lng'].toString()),
      from: json['timingFrom'],
      to: json['timingTo'],
      enabled: json['isEnabled'],
      ratings: double.parse(json['rating'].toString()),
    );
  }
}
