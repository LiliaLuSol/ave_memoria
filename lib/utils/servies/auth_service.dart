import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final GoTrueClient _auth = Supabase.instance.client.auth;

  AuthService();

  Future<void> signInWithEmail(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithPassword(email: email, password: password);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> signUpWithEmail(
      {required String email, required String password}) async {
    try {
      await _auth.signUp(email: email, password: password);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> resetPasswordForEmail({required String email}) async {
    try {
      await _auth.resetPasswordForEmail(email);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> updateUserPassword({required String password}) async {
    try {
      await _auth.updateUser(UserAttributes(
        password: password,
      ));
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> anounymousSignIn() async {
    try {
      await _auth.signInWithPassword(
          email: 'anounymous@gmail.com', password: '123456');
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      await _auth.signInWithOAuth(OAuthProvider.google);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw e.toString();
    }
  }
}
