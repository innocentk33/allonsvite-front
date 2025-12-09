class AuthUser {
  final int id;
  final String username;
  final String phone;
  final List<String> roles;
  final String password;
  final String firstname;
  final String lastname;
  final String userIdentifier;

  AuthUser({
    required this.id,
    required this.username,
    required this.phone,
    required this.roles,
    required this.password,
    required this.firstname,
    required this.lastname,
    required this.userIdentifier,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      id: json['id'],
      username: json['username'],
      phone: json['phone'],
      roles: List<String>.from(json['roles']),
      password: json['password'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      userIdentifier: json['userIdentifier'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'phone': phone,
      'roles': roles,
      'password': password,
      'firstname': firstname,
      'lastname': lastname,
      'userIdentifier': userIdentifier,
    };
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
      roles: roles ?? this.roles,
      password: password ?? this.password,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      userIdentifier: userIdentifier ?? this.userIdentifier,
    );
  }

  @override
  int get hashCode => Object.hash(
    id,
    username,
    phone,
    roles,
    password,
    firstname,
    lastname,
    userIdentifier,
  );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AuthUser &&
            other.id == id &&
            other.username == username &&
            other.phone == phone &&
            other.roles == roles &&
            other.password == password &&
            other.firstname == firstname &&
            other.lastname == lastname &&
            other.userIdentifier == userIdentifier);
  }
}
