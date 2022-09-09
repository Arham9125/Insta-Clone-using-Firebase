import 'package:flutter/cupertino.dart';
import 'package:instaclone/model/users.dart';
import 'package:instaclone/resourses/auth_meth.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethoeds _authMethoeds = AuthMethoeds();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethoeds.getUserData();
    _user = user;
    notifyListeners();
  }
}
