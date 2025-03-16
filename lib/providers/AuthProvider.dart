import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:nojia/model/user.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserModel? _user;
  bool _isLoading = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;

  AuthProvider() {
    _initAuth();
  }

  void _initAuth() {
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        await _loadUserData();
      } else {
        _user = null;
      }
      notifyListeners();
    });
  }

  Future<String?> signUp(String fname, String lname, String email,
      String password, String phone) async {
    try {
      _setLoading(true);

      if (await _isEmailRegistered(email)) {
        return 'Email already registered';
      }

      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _createUserDocument(
          userCredential.user!.uid, fname, lname, email, phone);

      await _createInitialAlert(userCredential.user!.uid);

      return null;
    } on FirebaseAuthException catch (e) {
      return _handleAuthError(e);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _createInitialAlert(String uid) async {
    await _firestore.collection('users').doc(uid).collection('alerts').add({
      'title': 'Welcome to Nojia!',
      'type': 'success',
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<String?> signIn(String email, String password) async {
    try {
      _setLoading(true);
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return _handleAuthError(e);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> _isEmailRegistered(String email) async {
    final query = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    return query.docs.isNotEmpty;
  }

  Future<void> _createUserDocument(String uid, String fname, String lname,
      String email, String phone) async {
    await _firestore.collection('users').doc(uid).set({
      'id': uid,
      'fname': fname,
      'lname': lname,
      'email': email,
      'phone': phone,
      'createdAt': DateTime.now(),
    });
  }

  Future<void> _loadUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      _user = UserModel.fromFirestore(doc.data()!);
      notifyListeners();
    }
  }

  String _handleAuthError(FirebaseAuthException e) {
    return switch (e.code) {
      'email-already-in-use' => 'Email already exists',
      'weak-password' => 'Password is too weak',
      'invalid-email' => 'Invalid email format',
      'user-not-found' => 'User not found',
      'wrong-password' => 'Wrong password',
      _ => e.message ?? 'Authentication error'
    };
  }
}
