class User {
  final String email;
  final String uid;

  const User({
    required this.uid,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
      };
}
