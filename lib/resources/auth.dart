// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:sundaytask/src/models/user.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class AuthService {
//   // Dependencies
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final Firestore _db = Firestore.instance;


//   // Shared State for Widgets
//   Observable<FirebaseUser> user; // firebase user
//   Observable<Map<String, dynamic>> profile; // custom user data in Firestore
//   PublishSubject loading = PublishSubject();


//   AuthService() {
//     user = Observable(_auth.onAuthStateChanged);

//     profile = user.switchMap((FirebaseUser u) {
//       if (u != null) {
//         return _db
//             .collection('users')
//             .document(u.uid)
//             .snapshots()
//             .map((snap) => snap.data);
//       } else {
//         return Observable.just({});
//       }
//     });
//   }

//   Future<String> emailVerify() async {


//     FirebaseUser user;

//     print("bahia bhia");
//     //print(user.email);
//     try {
//       print("try");
//       await user.sendEmailVerification();
//       print("Success");
//       Fluttertoast.showToast(
//           timeInSecForIosWeb: 100,
//           msg:
//           "email Verification link has been sent to your mail");
//       return user.uid;
//     } catch (e) {
//       print("An error occured while trying to send email verification");
//       print(e.message);
//     }
//     return null;
//   }

//   final FirebaseAuth auth = FirebaseAuth.instance;

//   Future<FirebaseUser> hellogoogleSignIn() async {
//     loading.add(true);

//     // Step 1
//     GoogleSignInAccount googleUser = await _googleSignIn.signIn();

//     // Step 2
//     final GoogleSignInAuthentication googleAuth =
//     await googleUser.authentication;

//     final AuthCredential credential = GoogleAuthProvider.getCredential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );

//     final FirebaseUser user =
//         (await _auth.signInWithCredential(credential)).user;

// // Checking if email and name is null
//     checkuserexists(user.uid,user,user.displayName);

// //      updateUserData(user);


//     // Step 3

//     // Done
//     loading.add(false);

//     print("signed in " + user.displayName);

//     return user;
//   }

//   Future<bool> usernameCheck(String displayName) async {
//     final result = await Firestore.instance
//         .collection('users')
//         .where('displayName', isEqualTo: displayName)
//         .getDocuments();
//     return result.documents.isEmpty;
//   }


//   checkuserexists(String uid,FirebaseUser user,String displayName) async {
//     final snapShotX = await Firestore.instance
//         .collection('users')
//         .document(uid)
//         .get();


//     if (snapShotX.exists ) {
//       updateUserData(user);
//     }
//     else{
//       updatenewUserData(user);
//     }
// //        updatenewUserData(user);

//   }

//   User userdatax;


//   void updateUserData(FirebaseUser user) async {
//     DocumentReference ref = _db.collection('users').document(user.uid);

//     return ref.setData({
//       'uid': user.uid,
//       'email': user.email,
//       'photoURL': user.photoUrl,
//       'displayName': user.displayName.toLowerCase(),
//       'lastSeen': DateTime.now(),
//       'followers': userdatax.followers,
//       'following': userdatax.following,
//       'posts': userdatax.posts,
//       'bio' : "Proud Hashtager",
//       'emailVerified': false,
//       'phoneVerified': false,

//     }, merge: true);
//   }

//   void updatenewUserData(FirebaseUser user) async {
//     DocumentReference ref = _db.collection('users').document(user.uid);

//     return ref.setData({
//       'uid': user.uid,
//       'email': user.email,
//       'photoURL': user.photoUrl,
//       'displayName': user.displayName.toLowerCase(),
//       'lastSeen': DateTime.now(),
//       'followers': 0,
//       'following': 0,
//       'posts': 0,
//       'bio' : "Proud Hashtager",
//       'emailVerified': false,
//       'phoneVerified': false,

//     }, merge: true);
//   }

//   void signOut() {
//     _auth.signOut();
//   }
// }

// final AuthService authService = AuthService();