import 'dart:typed_data';
import 'package:clone_insta/resources/storage_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:clone_insta/models/users.dart' as model;
import 'package:flutter/material.dart';

// class AuthMethods{
//   final FirebaseAuth _auth=FirebaseAuth.instance;
//   final FirebaseFirestore _firestore=FirebaseFirestore.instance;
//   //sign up the user
//   Future<String> signUpUser({
//     required String username,
//     required String email,
//     required String password,
//     required String bio,
//     required Uint8List file,
// }) async {
//     String res="Some error occured";
//     try{
//       if(email.isNotEmpty && password.isNotEmpty && username.isNotEmpty){
//         UserCredential cred= await _auth.createUserWithEmailAndPassword(email: email, password: password);
//         String photoUrl= await StorageMethods().uploadImageToStorage('profilePics',file,false);
//         await _firestore.collection('users').doc(cred.user!.uid).set({
//           'username': username,
//           'uid': cred.user!.uid,
//           'email': email,
//           'bio': bio,
//           'followers': [],
//           'following': [],
//           'photoUrl': photoUrl,
//         });
//         res="Success";
//       }
//     }catch(err){
//       res=err.toString();
//     }
//     return res;
//   }
//   //log in the user
//   Future<String> loginUser({
//     required String email,
//     required String password
// }) async {
//     String res="Some error occurred";
//     try {
//       if(email.isNotEmpty&&password.isNotEmpty){
//         await _auth.signInWithEmailAndPassword(email: email, password: password);
//         res="Success";
//       }else{
//         res="Please enter all the fields";
//       }
//     }catch(err){
//       res=err.toString();
//     }
//     return res;
//   }
// }
class AuthMethods{
  final FirebaseAuth _auth= FirebaseAuth.instance;
  final FirebaseFirestore _firestore= FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async{
    User currentUser =_auth.currentUser!;

    DocumentSnapshot snap= await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  Future<String> signUpUser({
    required String username,
    required String email,
    required String password,
    required String bio,
    required Uint8List file,
  }) async {
    String res="Some error occured";
    try{
      if(email.isNotEmpty && password.isNotEmpty && username.isNotEmpty){
        UserCredential cred= await _auth.createUserWithEmailAndPassword(email: email, password: password);
        String photoUrl= await StorageMethods().uploadImageToStorage('profilePics',file,false);

        model.User user= model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          bio: bio,
          photoUrl: photoUrl,
          followers: [],
          following: [],
    );

        await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson(),);
        res="Success";
      }
    }catch(err){
      res=err.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password
  }) async {
    String res="Some error occured";
    try{
      if(email.isNotEmpty && password.isNotEmpty){
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res='Success';
      }else{
        res="Please enter all the fields";
      }
    } catch(err){
      res=err.toString();
    }
    return res;
  }
}