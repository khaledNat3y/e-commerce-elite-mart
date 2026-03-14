import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../models/user_model.dart';

@lazySingleton
class AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Dio _dio = Dio();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = UserModel(
      uid: credential.user!.uid,
      name: name,
      email: email,
      createdAt: DateTime.now(),
    );

    // Save user to Firestore
    await _firestore
        .collection('users')
        .doc(user.uid)
        .set(user.toJson());
    // ✅ Notify N8N — fire and forget
    await _dio.post('https://khalednatey.app.n8n.cloud/webhook/signup', data: {
      'name': name,
      'email': email,
    }).catchError((_){});
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logout() async => await _auth.signOut();

  User? get currentUser => _auth.currentUser;
  bool get isLoggedIn => _auth.currentUser != null;
}