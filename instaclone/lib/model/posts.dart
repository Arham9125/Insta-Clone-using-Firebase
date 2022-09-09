import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String photoUrl;
  final String postId;
  final  datePublished;
  final String profileImage;
  final likes;
  final String username;

  Post(
      {required this.description,
      required this.likes,
      required this.datePublished,
      required this.profileImage,
      required this.uid,
      required this.photoUrl,
      required this.username,
      required this.postId});

  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "postId": postId,
        "datePublished": datePublished,
        "profileImage": profileImage,
        "likes": likes,
        "upload": photoUrl,
        "username": username,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
      description: snapshot["description"],
      uid: snapshot["uid"],
      postId: snapshot["postId"],
      likes: snapshot["likes"],
      datePublished: snapshot["datePublished"],
     profileImage: snapshot["profileImage"],
     photoUrl: snapshot["photoUrl"],
     username: snapshot["username"],
     
    );
  }
}
