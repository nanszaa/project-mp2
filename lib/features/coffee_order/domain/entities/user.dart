class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String? phoneNumber;
  final bool isMember;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.phoneNumber,
    this.isMember = false,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map["id"]?.toString() ?? '',
      name: map["name"]?.toString() ?? '',
      email: map["email"]?.toString() ?? '',
      password: map["password"]?.toString() ?? '',
      phoneNumber: map["phone_number"]?.toString(),
      isMember: map["is_member"] ?? false,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) => User.fromMap(json);

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'email': email,
    'password': password,
    'phone_number': phoneNumber,
    'is_member': isMember,
  };

  Map<String, dynamic> toJson() => toMap();
}
