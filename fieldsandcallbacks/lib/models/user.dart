import 'dart:math';
class User {
  String id;
  String username;
  String fullname;
  String email;
  String password;
  String gender;
  String principalInterest;
  String? profilePicture;

  User({
    this.id = '',
    this.profilePicture,
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
    this.profilePicture,
    this.password = '',
  });

  void setProfilePicture() {
    final Random _random = Random();
    profilePicture = "https://picsum.photos/id/${_random.nextInt(100)}/400/400";
  }

  String toStringMap() {
    return """
    {
      "id": \"$id\",
      "username": \"$username\",
      "fullname": \"$fullname\",
      "email": \"$email\",
      "principalInterest": \"$principalInterest\",
      "gender": \"$gender\",
      "profilePicture": \"$profilePicture\"
    }""" ;
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'fullname': fullname,
      'email': email,
      'gender': gender,
      'principalInterest': principalInterest,
      'profilePicture': profilePicture,
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
        'profilePicture': {'stringValue': profilePicture}
            
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
      profilePicture: fields['profilePicture'] != null
          ? fields['profilePicture']['stringValue'] as String
          : null,
    );
  }
}
