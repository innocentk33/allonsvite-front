class AuthUser {
  final int id;
  final String? username;
  final String phone;
  final String? password;
  final String? firstname;
  final String? lastname;

  AuthUser({
    required this.id,
    required this.username,
    required this.phone,
    required this.password,
    required this.firstname,
    required this.lastname,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      id: json['id'],
      username: json['username'],
      phone: json['phone'],
      password: json['password'],
      firstname: json['firstname'],
      lastname: json['lastname'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'phone': phone,
      'password': password,
      'firstname': firstname,
      'lastname': lastname,
    };
  }

  bool get isProfileCompleted {
    return (firstname != null && firstname!.isNotEmpty) &&
        (lastname != null && lastname!.isNotEmpty);
  }

  // copyWith method
  AuthUser copyWith({
    int? id,
    String? username,
    String? phone,
    List<String>? roles,
    String? password,
    String? firstname,
    String? lastname,
    String? userIdentifier,
  }) {
    return AuthUser(
      id: id ?? this.id,
      username: username ?? this.username,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
    );
  }

  @override
  int get hashCode => Object.hash(
    id,
    username,
    phone,
    password,
    firstname,
    lastname,
  );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AuthUser &&
            other.id == id &&
            other.username == username &&
            other.phone == phone &&
            other.password == password &&
            other.firstname == firstname &&
            other.lastname == lastname);
  }
}
