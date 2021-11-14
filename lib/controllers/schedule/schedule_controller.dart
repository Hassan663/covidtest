


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rrt_client_web_app/constants/custom_snackbar.dart';
import 'package:rrt_client_web_app/constants/rrt_colors.dart';
import 'package:rrt_client_web_app/controllers/appointment/appointment_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleController extends GetxController
{
  String month = formatDate(DateTime.now(), [mm]);
  String year = formatDate(DateTime.now(), [yy]);
  String day = formatDate(DateTime.now(), [dd]);
  DateTime? selectedDay;
  late AppointmentController appointmentController;
  var formatted = formatDate(DateTime.now(), [mm]);
  var formatted1;
  List<String> subjectCollection = <String>[];
  List<Color> colorCollection = <Color>[];
  List months = [];

  bool isLoading = true;

  TextEditingController selecttime = TextEditingController();
  TextEditingController selectdatetime = TextEditingController();

  final nurseAppointment = FirebaseFirestore.instance.collection("NurseAppointment");
  final patientAppointment = FirebaseFirestore.instance.collection("Appoinments");

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  DateTime focusedDays = DateTime.now();
  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime? selectedDays;

  List appoinmentlist = [];

  @override
  void onInit() {
    if (Get.isRegistered<AppointmentController>())
      appointmentController = Get.find<AppointmentController>();
    else
      appointmentController = Get.put(AppointmentController());
    selectedDays = focusedDays;
    months = [
      'jan',
      'feb',
      'mar',
      'apr',
      'may',
      'jun',
      'jul',
      'aug',
      'sep',
      'oct',
      'nov',
      'dec'
    ];
    super.onInit();
  }

  @override
  void onReady()async {
    await getAppoinment();
    isLoading = false;
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


  Future<void> getAppoinment() async{
    print(selectedDays);
    print("function Call");
    appoinmentlist.clear();
    final Timestamp d = Timestamp. fromDate(selectedDays!);
    final DateTime today =DateTime.parse(d.toDate().toString());
    String da = today.toString().split(' at').first;
    String a = da.split(" ").first;
    print("date a $a");
    var cdata =await nurseAppointment.where("adate" , isEqualTo: a).get();
    cdata.docs.forEach((element) {
      print(element.data());
      appoinmentlist.add(element.data());
    });
    update();
    print(appoinmentlist.length);
  }

  Future<void> addAppoinment() async{
    isLoading = true;
    update();
    final Timestamp d = Timestamp. fromDate(selectedDays!);
    final DateTime today =DateTime.parse(d.toDate().toString());
    String da = today.toString().split(' at').first;
    String a = da.split(" ").first;
    print("date a $a");
    var c = await patientAppointment.where("starttime" , isEqualTo: selectdatetime.text).where("patientId" ,isEqualTo: firebaseAuth.currentUser!.uid).get();
    if(c.docs.length == 0)
      {
        var data = patientAppointment.doc();
        var docSnap = await data.get();
       data.set({
         "docId": docSnap.reference.id,
         "date" : a,
          "starttime" : selectdatetime.text,
          "patientId" : firebaseAuth.currentUser!.uid,
         "status" : "pending"
        }).then((value){
          isLoading = false;
          update();
          CustomSnackBar.showSnackBar(
              title: "Success",
              message: 'appointment Added Successfully',
              backgroundColor: snackBarSuccess);
        });
      }
    else
      {
        String doci = "";
        c.docs.forEach((element) {
          doci = element['docId'];
        });
        patientAppointment.doc(doci).update({
          "starttime" : selectdatetime.text,
        }).then((value){
          isLoading = false;
          update();
          CustomSnackBar.showSnackBar(
              title: "Success",
              message: 'appointment Added Successfully',
              backgroundColor: snackBarSuccess);
        });
      }
  }



}