import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:icthub_new_repo/core/logic/extensions.dart';
import 'package:icthub_new_repo/data/data_models/user_data_model.dart';

import '../../main.dart';

class AuthDataSource {
  /// this variable is used to check if an error occurred or not
  static String errorMessage = '';

  /// this function is used to sign up the user to the app and save the user data to the [FireStore] collection 'users'
  static Future<UserCredential?> signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        await _saveUserDocTOFireStore(
          email: email,
          name: name,
          phone: phone,
          uid: credential.user!.uid,
        );
      }
      return credential;
    } on FirebaseAuthException catch (e) {
      errorMessage = e.code.handleSignUpException();
      return null;
    } catch (e) {
      log.e(e);
      errorMessage = e.toString();
      return null;
    }
  }

  /// this function is used to save the user data to the [FireStore] collection 'users'
  static Future<void> _saveUserDocTOFireStore({
    required String email,
    required String name,
    required String phone,
    required String uid,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).set(
        {
          'email': email,
          'name': name,
          'phone': phone,
          'uid': uid,
        },
        SetOptions(merge: true),
      );
    } on FirebaseException catch (e) {
      log.e(e);
    } catch (e) {
      log.e(e);
    }
  }

  /// this function is used to sign in the user to the app
  static Future<UserCredential?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      errorMessage = e.code.handleLoginException();
      return null;
    } catch (e) {
      log.e(e);
      errorMessage = e.toString();
      return null;
    }
  }

  /// this function is used to sign out the user from the app
  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  /// this function is used to get the data of the user from the [FireStore] collection 'users'
  static Future<UserDataModel?> getUserData() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      final doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      Map<String, dynamic> userMap = doc.data() ??
          {
            'email': 'null',
            'name': 'null',
            'phone': 'null',
            'uid': 'null',
          };

      UserDataModel user = UserDataModel.fromDoc(userMap);

      return user;
    } catch (e) {
      errorMessage = e.toString();
      log.e(e);

      return null;
    }
  }
}
