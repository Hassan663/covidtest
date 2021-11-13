


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  final nurseAppointment = FirebaseFirestore.instance.collection("NurseAppointment");
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
    var cdata =await nurseAppointment.where("adate" , isEqualTo: a).get();
    cdata.docs.forEach((element) {
      print(element.data());
      appoinmentlist.add(element.data());
    });
    update();
    print(appoinmentlist.length);
  }



}