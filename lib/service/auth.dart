import 'package:firebase_auth/firebase_auth.dart';
import 'package:icu/models/usermodel.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel? _userFromUserCredential(User? user){
    return user != null ? UserModel(uid: user.uid,email: user.email!) : null;
  }
  // ليه عملها ستريم
  Stream<UserModel?> get user {
    return _auth.authStateChanges()
        // .map((User? user) => _userFromUserCredential(user) );
    .map(_userFromUserCredential);
  }
//   sign in anonymously
// ----------------------
  // Future loginAnon() async {
  //   try{
  //     UserCredential result = await _auth.signInAnonymously();
  //     User? user = result.user;
  //     return _userFromUserCredential(user);
  //   }catch(error){
  //     print(error.toString());
  //     return null;
  //   }
  // }

//   sign in email & pass
  Future loginEmailPass(email,password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email,
          // 'ahmed@mail.com',
          password: password
          // 'test123'
          );
      User? user = result.user;
      return _userFromUserCredential(user);
    }catch(error){
      print(error.toString());
      return null;
    }
  }
//   register
//   sign out
// -----------
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(error){
      print(error.toString());
      return null;
    }
  }

}