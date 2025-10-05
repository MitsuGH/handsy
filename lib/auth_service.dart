import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Auth state changes stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign in with email and password
  Future<UserCredential?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return result;
    } on FirebaseAuthException catch (e) {
      throw AuthException(_getErrorMessage(e.code));
    } catch (e) {
      throw AuthException('An unexpected error occurred. Please try again.');
    }
  }

  // Create user with email and password
  Future<UserCredential?> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      // Update display name
      await result.user?.updateDisplayName(name);
      
      return result;
    } on FirebaseAuthException catch (e) {
      throw AuthException(_getErrorMessage(e.code));
    } catch (e) {
      throw AuthException('An unexpected error occurred. Please try again.');
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw AuthException('Failed to sign out. Please try again.');
    }
  }

  // Send password reset email
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      throw AuthException(_getErrorMessage(e.code));
    } catch (e) {
      throw AuthException('Failed to send password reset email.');
    }
  }

  // Convert Firebase error codes to user-friendly messages
  String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'No account found with this email address.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many failed attempts. Please try again later.';
      case 'operation-not-allowed':
        return 'Email/password sign-in is not enabled.';
      case 'weak-password':
        return 'Password should be at least 6 characters long.';
      case 'email-already-in-use':
        return 'An account already exists with this email address.';
      case 'invalid-credential':
        return 'The provided credentials are invalid.';
      default:
        return 'Authentication failed. Please try again.';
    }
  }
}

// Custom exception class for authentication errors
class AuthException implements Exception {
  final String message;
  
  AuthException(this.message);
  
  @override
  String toString() => message;
}