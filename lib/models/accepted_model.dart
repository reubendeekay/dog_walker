class AcceptedModel {
  final String? basePrice;
  final String? experience;
  final String? from;
  final String? to;
  final String? time;
  final String? name;

  AcceptedModel(
      {this.basePrice,
      this.experience,
      this.from,
      this.to,
      this.time,
      this.name});

  Map<String, dynamic> toJson() {
    return {
      'base_price': basePrice,
      'experience': experience,
      'from': from,
      'to': to,
      'time': time,
      'name': name,
    };
  }

  factory AcceptedModel.fromJson(dynamic json) {
    return AcceptedModel(
      basePrice: json['base_price'] as String,
      experience: json['experience'] as String,
      from: json['from'] as String,
      to: json['to'] as String,
      time: json['time'] as String,
      name: json['name'] as String,
    );
  }
}
