
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:rrt_client_web_app/models/authentication/auth_model.dart';

class Database{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<bool> createUserInDatabase(AuthModel user) async{
    try{
      await _firestore.collection('client').doc(user.uid).set({
        'uid' : user.uid,
        'firstName' : user.firstName,
        'lastName' : user.lastName,
        'email' : user.email,
        'imageUrl' : user.imageUrl,
        'createdAt' : user.createdAt,
        'role' : user.role,
      });
      return true;
    }catch(e){
      debugPrint(e.toString());
      return false;
    }
  }

  Future<AuthModel> getUser(String uid) async {
    try{
      DocumentSnapshot doc = await _firestore.collection("client").doc(uid).get();
      return AuthModel.fromDocumentSnapshot(doc);
    }catch(e){
      debugPrint(e.toString());
      rethrow;
    }
  }
}