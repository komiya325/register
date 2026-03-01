import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../entity/user_entity.dart';

class AuthRepository {
  AuthRepository({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
    GoogleSignIn? googleSignIn,
  }) : _auth = firebaseAuth ?? FirebaseAuth.instance,
       _firestore = firestore ?? FirebaseFirestore.instance,
       _googleSignIn = googleSignIn ?? GoogleSignIn();

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;

  Future<UserEntity> signInWithGoogle() async {
    final googleUser = await _signInGoogleUser();
    if (googleUser == null) {
      throw Exception('Googleログインがキャンセルされました。');
    }

    final googleAuth = await _googleAuthentication(googleUser);
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth['accessToken'],
      idToken: googleAuth['idToken'],
    );

    final userCredential = await _auth.signInWithCredential(credential);
    final user = userCredential.user;
    if (user == null) {
      throw Exception('ユーザー情報の取得に失敗しました。');
    }

    return UserEntity(
      uid: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
      photoUrl: user.photoURL ?? '',
      createdAt: DateTime.now(),
    );
  }

  Future<bool> checkUserExists(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    return doc.exists;
  }

  Future<void> saveUser(UserEntity user) async {
    await _firestore.collection('users').doc(user.uid).set({
      'name': user.name,
      'email': user.email,
      'photoUrl': user.photoUrl,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> signOut() async {
    await Future.wait<void>([_auth.signOut(), _googleSignIn.signOut()]);
  }

  Stream<UserEntity?> authStateChanges() {
    return _auth.authStateChanges().map((user) {
      if (user == null) {
        return null;
      }

      return UserEntity(
        uid: user.uid,
        name: user.displayName ?? '',
        email: user.email ?? '',
        photoUrl: user.photoURL ?? '',
      );
    });
  }

  Future<dynamic> _signInGoogleUser() async {
    final dynamic signIn = _googleSignIn;
    try {
      return await signIn.signIn();
    } catch (_) {
      // google_sign_in v7系向けフォールバック
      return await signIn.authenticate();
    }
  }

  Future<Map<String, String?>> _googleAuthentication(dynamic googleUser) async {
    final dynamic auth = await googleUser.authentication;
    return {
      'accessToken': auth.accessToken as String?,
      'idToken': auth.idToken as String?,
    };
  }
}
