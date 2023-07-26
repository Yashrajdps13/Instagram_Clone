import 'package:clone_insta/models/users.dart';
import 'package:clone_insta/resources/auth_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class UserProvider with ChangeNotifier{
  User? _user;
  final AuthMethods _authMethods=AuthMethods();

  User get getUser => _user!;

  Future<void> refreshUser() async{
  User user= await _authMethods.getUserDetails();
  _user=user;
  notifyListeners();
}
}