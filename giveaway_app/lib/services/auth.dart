import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smartcon_app/models/user.dart';

import 'database.dart';

class AuthService {

  GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  SmartconUser _userFromFirebaseUser(User user){
    return user != null ? SmartconUser(uid: user.uid) : null;
  }

  // change user stream
  Stream<SmartconUser> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future signInWithGoogle() async {
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser.authentication;
    // ignore: deprecated_member_use
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      UserCredential result = await _auth.signInWithCredential(credential);
      User user = result.user;

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = await _auth.currentUser;
      assert(user.uid == currentUser.uid);

      if (result.additionalUserInfo.isNewUser) {
        await DatabaseService(uid: user.uid).updateProfile('',[]);
      }
      return _userFromFirebaseUser(user);
    }
    catch (error) {
      print(error.toString());
      return null;
    }
  }

  void signOutGoogle() async {
    try {
      await googleSignIn.signOut();
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<SmartconUser> currentUser() async {
    final user = _auth.currentUser;
    return _userFromFirebaseUser(user);
  }

}