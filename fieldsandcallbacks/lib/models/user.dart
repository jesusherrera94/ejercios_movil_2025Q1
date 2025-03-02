class User {
  String id;
  String username;
  String fullname;
  String email;
  String password;
  String gender;
  String principalInterest;

  User({
    this.id = '',
    required this.username,
    required this.fullname,
    required this.email,
    required this.password,
    required this.gender,
    required this.principalInterest,
  });

  User.withoutPassword({
    required this.id,
    required this.username,
    required this.fullname,
    required this.email,
    required this.gender,
    required this.principalInterest,
    this.password = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'fullname': fullname,
      'email': email,
      'gender': gender,
      'principalInterest': principalInterest,
    };
  }

  Map<String, dynamic> toFirestoreRestMap() {
    return {
      'fields': {
        'username': {
          'stringValue': username,
        },
        'fullname': {'stringValue': fullname},
        'email': {'stringValue': email},
        'gender': {'stringValue': gender},
        'principalInterest': {'stringValue': principalInterest},
      }
    };
  }

  factory User.fromMap(Map<String, dynamic> json) {
    final fields = json['fields'] as Map<String, dynamic>;
    return User.withoutPassword(
      id: json['name'].split('/').last,
      username: fields['username']['stringValue'] as String,
      fullname: fields['fullname']['stringValue'] as String,
      email: fields['email']['stringValue'] as String,
      gender: fields['gender']['stringValue'] as String,
      principalInterest: fields['principalInterest']['stringValue'] as String,
    );
  }
}
