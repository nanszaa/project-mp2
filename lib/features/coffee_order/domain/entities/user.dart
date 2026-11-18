class User {
  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  final bool isMember;

  User({
    required this.id, 
    required this.name, 
    required this.email,
    this.phoneNumber,
    this.isMember = false,
  });

  User copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    bool? isMember,
  }) {
    return User(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isMember: isMember ?? this.isMember,
    );
  }
}