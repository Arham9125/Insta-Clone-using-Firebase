import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:instaclone/model/posts.dart';
import 'package:instaclone/resourses/storage.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethoeds {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<String> uploadPost(String discription, Uint8List file, String uid,
      String username, String profileImage) async {
    String res = "Something is wrong";

    try {
      String upload =
          await StorageMethoeds().uploadImageToStorage("posts", file, true);
      String postId = Uuid().v1();
      Post post = Post(
          description: discription,
          username: username,
          likes: [],
          datePublished: DateTime.now(),
          profileImage: profileImage,
          uid: uid,
          photoUrl: upload,
          postId: postId);

      _firebaseFirestore.collection("posts").doc(postId).set(post.toJson());
      res = "Sucess";
    } catch (err) {
      res = err.toString();
    }
 return res;
  }
 
}
