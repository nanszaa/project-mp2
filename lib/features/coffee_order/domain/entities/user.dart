class User {
  String id;
  String name;
  String email;
  String? phoneNumber;
  int points;

  User({
    required this.id, 
    required this.name, 
    required this.email,
    this.phoneNumber,
    this.points = 0,
  });

  User copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    int? points,
  }) {
    return User(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      points: points ?? this.points,
    );
  }
}