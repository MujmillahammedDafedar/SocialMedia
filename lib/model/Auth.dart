import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'globals.dart' as globals;

class googleSignin{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);

    final FirebaseUser user = authResult.user;
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    if(authResult.additionalUserInfo.isNewUser == true){
      InsertNewUserDetails(user.displayName,user.email,user.photoUrl,user.phoneNumber);
    }
    if(authResult.user != null){
      globals.isLoggedIn = true;
    }
    return 'signInWithGoogle succeeded: $user';
  }
  void InsertNewUserDetails(String displayName, String email, String imageUrl, var number){
    Firestore.instance.collection('userlist').document()
        .setData({ 'displayName': '$displayName', 'email': '$email','photoUrl': '$imageUrl','phoneNumber':'$number' });
  }


  void signOutGoogle() async{
    bool isLoggedIn = false;
    await googleSignIn.signOut();
    print("User Sign Out");
  }
}