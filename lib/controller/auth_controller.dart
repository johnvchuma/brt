import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/state_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  Rx<User?> userController = Rx<User?>(null);
  User? get user => userController.value;
  GoogleSignIn googleSignIn = GoogleSignIn();
  Rx<GoogleSignInAccount?> accountController = Rx<GoogleSignInAccount?>(null);
  GoogleSignInAccount? get userDetails => accountController.value;

  @override
  void onInit() {
    userController.bindStream(auth.authStateChanges());
    super.onInit();
  }

  void googleLogin() async {
    var googleUser = await googleSignIn.signIn();
    // ignore: unnecessary_null_comparison
    if (googleUser == null) {
      return;
    } else {
      accountController.value = googleUser;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      await auth.signInWithCredential(credential);
    }
  }
}
