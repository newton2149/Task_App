import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UiProvider with ChangeNotifier {
  DateTime dateTimeSelected = DateTime.now();

  void updateTime(DateTime date) {
    dateTimeSelected = date;
    print(dateTimeSelected);
    notifyListeners();
  }

  Future<void> signIn(String email, String passWord) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email,
              password: passWord);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
       
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
