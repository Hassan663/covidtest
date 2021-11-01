

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rrt_client_web_app/constants/custom_snackbar.dart';
import 'package:rrt_client_web_app/constants/rrt_colors.dart';
import 'package:rrt_client_web_app/constants/utils/auth_exception_handler.dart';
import 'package:rrt_client_web_app/controllers/service/database.dart';
import 'package:rrt_client_web_app/models/authentication/auth_model.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final firebaseUser = FirebaseAuth.instance.currentUser.obs;
  var currentUser = AuthModel().obs;
  AuthResultStatus? _status;

  @override
  void onInit() {
    super.onInit();
    // BINDING AUTH LISTENER
    firebaseUser.bindStream(_auth.authStateChanges());
  }

  // CHECKING DUPLICATE EMAIL
  Future<List<String>> checkDuplicateEmail(String email) async {
    try{
      return await _auth.fetchSignInMethodsForEmail(email);
    } on FirebaseAuthException catch(e){
      rethrow;
    }

  }


  //  CREATE USER WITH EMAIL AND PASSWORD
  Future<AuthResultStatus> createUser(String email, String password, String firstName, String lastName) async {
    try {
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);

      if(_authResult.user != null){
        _status = AuthResultStatus.successful;
        AuthModel _user = AuthModel(
            uid: _authResult.user!.uid,
            firstName: firstName,
            lastName: lastName,
            email: email.trim(),
            imageUrl: ''
        );
        currentUser.value = _user;
      }else{
        _status = AuthResultStatus.undefined;
      }

    } on FirebaseAuthException catch  (e) {
      debugPrint(e.code);
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status!;
  }


  // Login with email and password
  Future<AuthResultStatus> loginUser(String email, String password) async {
    try {
      UserCredential _authResult = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);

      if (_authResult.user != null) {
        _status = AuthResultStatus.successful;

        AuthModel _user = AuthModel(
          uid: _authResult.user!.uid,
          email: email.trim(),
        );

        currentUser.value = _user;

        // TODO :: LOAD USER INFO FROM FIRESTORE COLLECTION
        currentUser.value = await Database().getUser(_authResult.user!.uid);

      } else {
        _status = AuthResultStatus.undefined;
      }

    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status!;
  }

  // LOGOUT
  void logOut() async {
    try {
      await _auth.signOut();
      // TODO :: TAKE USER TO LOGIN SCREEN
    } catch (e) {
      CustomSnackBar.showSnackBar(title: e.toString(), message: '', backgroundColor: snackBarError);
    }
  }

}