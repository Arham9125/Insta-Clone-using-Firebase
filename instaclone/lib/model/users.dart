import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String upload;
  final String username;
  final String bio;
  final List followers;
  final List following;

  User(
      {required this.email,
      required this.bio,
      required this.followers,
      required this.following,
      required this.uid,
      required this.upload,
      required this.username});

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "bio": bio,
        "followers": followers,
        "following": following,
        "upload": upload,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      username: snapshot["username"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      bio: snapshot["bio"],
      followers: snapshot["followers"],
     following: snapshot["following"],
     upload: snapshot["upload"],
     
    );
  }
}
