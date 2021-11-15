


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:rrt_client_web_app/controllers/help/help_controller.dart';

class HomeDashboardController extends GetxController{

  final patientAppointment = FirebaseFirestore.instance.collection("Appoinments");
  bool isSelected = true;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  late HelpController helpController;

  List appoinmentlist = [];

  @override
  void onInit() {
    
    if (Get.isRegistered<HelpController>())
      helpController = Get.find<HelpController>();
    else
      helpController = Get.put(HelpController());
    
    super.onInit();
  }

  @override
  void onReady() {
    getAppoinments();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


  Future<void> getAppoinments() async
  {
    Stream<QuerySnapshot> streambodytarget = patientAppointment.where("patientId" , isEqualTo: firebaseAuth.currentUser!.uid).snapshots();
    await streambodytarget.forEach((e) {
      appoinmentlist.clear();
      for (var value in e.docs) {
        print(value.data());
        appoinmentlist.add(value.data());
      }
      update();
    }).catchError((e) {
      print(e);
    });
  }

}