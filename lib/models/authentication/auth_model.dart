import 'package:cloud_firestore/cloud_firestore.dart';

class AuthModel {
  String? uid;
  String? firstName;
  String? lastName;
  String? email;
  String? imageUrl;

  AuthModel(
      {this.uid, this.firstName, this.lastName, this.email, this.imageUrl});

  AuthModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    uid = doc['uid'];
    firstName = doc['firstName'];
    lastName = doc['lastName'];
    email = doc['email'];
    imageUrl = doc['imageUrl'];
  }
}
