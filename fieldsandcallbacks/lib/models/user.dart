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
  String? uid;

  User({
    this.id = '',
    this.profilePicture,
    required this.username,
    required this.fullname,
    required this.email,
    required this.password,
    required this.gender,
    required this.principalInterest,
    this.uid,
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
    this.uid,
  });

  void setProfilePicture() {
    final Random _random = Random();
    profilePicture = "https://picsum.photos/id/${_random.nextInt(100)}/400/400";
  }
  void setUid(String uid) {
    this.uid = uid;
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
      "profilePicture": \"$profilePicture\",
      "uid": \"$uid\",
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
      'uid': uid
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
        'profilePicture': {'stringValue': profilePicture},
        'uid': {'stringValue': uid}     
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
      uid: fields['uid']['stringValue'] as String
    );
  }

  factory User.fromFirebaseMap(Map<String, dynamic> json) {
    return User.withoutPassword(
      id: json['uid'],
      username: json['username'],
      fullname: json['fullname'],
      email: json['email'],
      gender: json['gender'],
      principalInterest: json['principalInterest'],
      profilePicture: json['profilePicture'],
      uid: json['uid']
    );
    }
}
