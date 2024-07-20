import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:icthub_new_repo/data/data_models/user_data_model.dart';

class AuthDataSource {
  static String errorMessage = '';
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
        await _saveUserDocTOFirestore(
          email: email,
          name: name,
          phone: phone,
          uid: credential.user!.uid,
        );
      }
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      errorMessage = e.message ?? '';
      return null;
    } catch (e) {
      print(e);
      errorMessage = e.toString();
      return null;
    }
  }

  static Future<void> _saveUserDocTOFirestore({
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
      print(e);
    } catch (e) {
      print(e);
    }
  }

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
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      errorMessage = e.message ?? '';
      return null;
    } catch (e) {
      print(e);
      errorMessage = e.toString();
      return null;
    }
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

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
      print(e);
      return null;
    }
  }
}
