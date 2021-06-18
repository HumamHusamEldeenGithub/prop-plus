
import 'package:firebase_auth/firebase_auth.dart'as firebaseAuth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:prop_plus/modules/user_module.dart';

class AuthService{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Stream<String> get onAuthStateChanged => _firebaseAuth.authStateChanges().map(
        (User user) => user ?.uid,
  );
  Future<UserModule> getUserModule() async{
    var firebaseUser =  await _firebaseAuth.currentUser;
    return UserModule(uid: firebaseUser.uid,userName: firebaseUser.displayName);
  }
  //get User UID
  Future<String>getCurrentUID()async{
    return await _firebaseAuth.currentUser.uid;
  }

  Future getCurrentUser()async{
    return await _firebaseAuth.currentUser;
  }
  Future<String>getCurrentName()async{
    return await _firebaseAuth.currentUser.displayName;
  }
  //Email & Password SignUp
  Future<UserModule> createUserWithEmailAndPassword(String email , String password ,String userName) async{
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password,);
    //Update the UserName
    updateUserName(userName,authResult.user);
    return UserModule(uid: authResult.user.uid , userName: authResult.user.displayName);
  }
  //Add UserName to Account
  Future updateUserName(String name , firebaseAuth.User firebaseUser ) async {
    firebaseUser.updateProfile(displayName: name);
    await firebaseUser.reload();
  }

  //Email & Password SignIn
  Future<UserModule>signInWithEmailAndPassword(String email , String password) async{
    var authResult= (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password));
    return UserModule(uid: authResult.user.uid , userName: authResult.user.displayName);
  }
//Sign Out
  Future signOut() async{
   return await _firebaseAuth.signOut();
  }
//Reset Password
  Future sendPasswordResetEmail(String email) async{
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }
  Future signInAnonymously(){
    return _firebaseAuth.signInAnonymously();

  }

  Future<String> signInWithGoogle() async{
    //by using  the google API
    final GoogleSignInAccount account = await _googleSignIn.signIn();
    final GoogleSignInAuthentication _googleAuth = await account.authentication;
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        idToken: _googleAuth.idToken,
        accessToken: _googleAuth.accessToken
    );

    return (await _firebaseAuth.signInWithCredential(credential)).user.uid;

  }

}