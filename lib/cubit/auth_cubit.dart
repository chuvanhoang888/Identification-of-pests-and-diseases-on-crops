import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as Path;
import 'package:project_detect_disease_datn/model/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthDefault());

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FacebookAuth _facebookAuth = FacebookAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  //login
  Future login(String email, String password) async {
    //when this is loading
    emit(const AuthLoginLoading());
    try {
      User? user = (await _firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user != null) {
        emit(AuthLoginSuccess(user: user));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthLoginError(error: e.message!));
    }
  }

  //logout firebase
  Future logout() async {
    await _firebaseAuth.signOut();
    await _facebookAuth.logOut();
    await _googleSignIn.signOut();
    emit(const AuthLogout());
  }

  //login google
  // gmail auth
  Future gmailAuth() async {
    emit(const AuthGoogleLoading());
    try {
      final GoogleSignInAccount? _googleUser = await _googleSignIn.signIn();
      if (_googleUser == null) {
        emit(AuthDefault());
      } else {
        final GoogleSignInAuthentication _googleAuth =
            await _googleUser.authentication;

        final AuthCredential _credential = GoogleAuthProvider.credential(
            idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);

        User? _user =
            (await _firebaseAuth.signInWithCredential(_credential)).user;

        if (_user != null) {
          emit(AuthGoogleSuccess(user: _user));
        }
      }
    } catch (e) {
      emit(AuthGoogleError(error: e.toString()));
    }
  }

  // gmail logout
  Future gmailLogout() async {
    await _googleSignIn.signOut();
    emit(const AuthLogout());
  }

  //login with facebook
  // facebook auth
  Future facebookAuth() async {
    emit(const AuthFBLoading());

    try {
      final LoginResult _loginResult = await _facebookAuth.login();
      if (_loginResult.status == LoginStatus.success) {
        final AccessToken accessToken = _loginResult.accessToken!;
        Fluttertoast.showToast(msg: accessToken.toString());
        final OAuthCredential _oAuthCreds =
            FacebookAuthProvider.credential(accessToken.token);

        User? _user =
            (await _firebaseAuth.signInWithCredential(_oAuthCreds)).user;

        Fluttertoast.showToast(msg: _oAuthCreds.toString());
        if (_user != null) {
          emit(AuthFbSuccess(user: _user));
        }
      }
    } catch (e) {
      emit(AUthFBError(error: e.toString()));
    }
  }

  //logout facebook
  Future facebookLogout() async {
    await _facebookAuth.logOut();
    emit(const AuthLogout());
  }

  //Signup
  Future signup(String email, String password, String name, String phone,
      File image) async {
    emit(const AuthSignUpLoading());
    try {
      User? user = (await _firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user != null) {
        //update the name of user
        await postDetailsToFirestore(image, name, phone);
        emit(const AuthSignUpSuccess());
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthSignUpError(e.message!));
    }
  }

  postDetailsToFirestore(File imageFile, String name, String phone) async {
    // FirebaseStorage storage = FirebaseStorage.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    String fileName = Path.basename(imageFile.path);
    Reference mStorage = FirebaseStorage.instance.ref().child("users_photos");
    Reference imageFilePath = mStorage.child(fileName);
    //imageFilePath.putFile(imageFile!).whenComplete(() => {});
    imageFilePath.putFile(imageFile).then((res) async {
      String downloadUrl = await res.ref.getDownloadURL();
      print(downloadUrl);
      User? user = _firebaseAuth.currentUser;
      user!.updatePhotoURL(downloadUrl);
      user.updateDisplayName(name);
      //user.updatePhoneNumber(phoneNumber)
      //user.updatePhoneNumber(phoneNumber);
      UserModel userModel = UserModel();
      //writing all the value
      userModel.uid = user.uid;
      userModel.email = user.email;
      userModel.name = name;
      userModel.phone = phone;
      userModel.imageUrl = downloadUrl;

      await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .set(userModel.toMap());

      //Fluttertoast.showToast(msg: "Đăng ký tài khoản thành công :)");
      //Navigator.pushNamed(context, SignInScreen.routeName);
    });
  }

  //forgot password
  Future forgotPassword(String email) async {
    emit(const AuthForgotPasswordLoading());
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      emit(const AuthForgotPasswordSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthForgotPasswordError(e.message!));
    }
  }

  //logout

}
