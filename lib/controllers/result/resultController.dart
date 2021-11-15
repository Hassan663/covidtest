import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ResultController extends GetxController{

  final result = FirebaseFirestore.instance.collection("Result");

  List resultlist = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    getResult();
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> getResult() async
  {
    Stream<QuerySnapshot> streambodytarget = result.where("patientId" , isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots();
    await streambodytarget.forEach((e) {
      resultlist.clear();
      for (var value in e.docs) {
        print(value.data());
        resultlist.add(value.data());
      }
      update();
    }).catchError((e) {
      print(e);
    });
  }

}