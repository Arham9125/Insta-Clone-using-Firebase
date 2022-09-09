import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instaclone/model/users.dart' as model;

import 'package:instaclone/resourses/storage.dart';

class AuthMethoeds {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  
  Future<model.User> getUserData() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection("users").doc(currentUser.uid).get();
    return model.User.fromSnap(snap);
  }

  Future<String> signUpUser(
      {required String email,
      required String pass,
      required String bio,
      required String username,
      required Uint8List file}) async {
    String res = "Some error occured";

    try {
      if (email.isNotEmpty ||
          pass.isNotEmpty ||
          bio.isNotEmpty ||
          username.isNotEmpty ||
          file != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: pass);

        print(cred.user!.uid);

        String upload = await StorageMethoeds()
            .uploadImageToStorage("profile", file, false);
        //add user to database
//model of user//
        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          bio: bio,
          followers: [],
          following: [],
          upload: upload,
        );
        //model of user//
        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.toJson());
        res = "Sucess";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginscr({required String email, required String pass}) async {
    String res = "Some errors occured";

    try {
      if (email.isNotEmpty || pass.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(email: email, password: pass);
        res = "Sucess";
      } else {
        res = "Please enter all details";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
