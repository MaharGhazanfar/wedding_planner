
import 'package:firebase_auth/firebase_auth.dart';

Future<String> signInWithEmail(
    {required String password, required String email}) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return 'Login Successful';
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return 'No user found for that email';
    } else if (e.code == 'wrong-password') {
      return 'Wrong password provided for that user';
    }
  }
  return 'SomeThing Went Wrong';
}
///////////////////////////////////////////////


Future<String> loginWithEmailPas(
    {required String email, required String password}) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return 'Login Successful';
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return 'The password provided is too weak';
    } else if (e.code == 'email-already-in-use') {
      return 'The account already exists for that email.';
    }
  } catch (e) {
    print(e);
    return 'SomeThing went wrong';
  }
  return 'Please try again later';
}
