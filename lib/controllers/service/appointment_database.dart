
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rrt_client_web_app/constants/custom_snackbar.dart';
import 'package:rrt_client_web_app/constants/rrt_colors.dart';
import 'package:rrt_client_web_app/controllers/appointment/appointment_controller.dart';
import 'package:rrt_client_web_app/controllers/appointment/booked_appointments/booked_appointment.dart';
import 'package:rrt_client_web_app/controllers/authentication/auth_controller.dart';
import 'package:rrt_client_web_app/models/appointment/available_appointments.dart';
import 'package:rrt_client_web_app/models/appointment/booked_appointments/booked_appointment_model.dart';
import 'package:rrt_client_web_app/models/appointment/schedule.dart';
import 'package:rrt_client_web_app/models/appointment/slots.dart';

class AppointmentDatabase{
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final authController = Get.find<AuthController>();

  Stream<List<AvailableAppointments>> getAllPost() {
    return _fireStore
        .collection('available-appointments')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      List<AvailableAppointments> retVal = <AvailableAppointments>[];
      snapshot.docs.forEach((element) {
        retVal.add(AvailableAppointments.fromDocumentSnapshot(element));
      });
      return retVal;
    });

  }


  Future<bool> generateRequestInDatabase(AvailableAppointments app, String uid, Slots selectedChoice) async {
    try {
      Timestamp currentTime = Timestamp.now();
      List<Slots>slotsList = [selectedChoice];
      Schedule schedule = Schedule(date: app.schedule!.date, slots: slotsList);
      DocumentReference ref = _fireStore.collection('pending-request').doc();
      await ref.set({
        "reqId" : ref.id,
        "clientId": uid,
        "appId" : app.uid,
        "nurseId" : app.nurseId,
        "schedule" : schedule.toJson(),
        "appCreatedAt" : app.createdAt,
        "createdAt": currentTime,
        "status" : "Pending",
        "firstName" : authController.currentUser.value.firstName,
        "lastName" : authController.currentUser.value.lastName,
      });
      generateRequestInClientCollection(app, currentTime, uid, schedule, ref.id);
      CustomSnackBar.showSnackBar(
          title: "Request successfully created",
          message: '',
          backgroundColor: snackBarSuccess);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> generateRequestInClientCollection(
      AvailableAppointments app, Timestamp currentTime, String uid, Schedule schedule, String reqId) async {
    try {
      await _fireStore
          .collection('client')
          .doc(uid)
          .collection('booked')
          .doc(app.uid)
          .set({
        "clientId": uid,
        "reqId" : reqId,
        "appId" : app.uid,
        "nurseId" : app.nurseId,
        "schedule" : schedule.toJson(),
        "appCreatedAt" : app.createdAt,
        "createdAt": currentTime,
        "status" : "Pending",
        "firstName" : authController.currentUser.value.firstName,
        "lastName" : authController.currentUser.value.lastName,
      });
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }




  Future<bool> updateRequestInDatabase(AvailableAppointments app, String uid, Slots selectedChoice, String docId) async {
    try {
      List<Slots>slotsList = [];

      BookedAppointmentModel myAppointment = Get.put(BookedAppointmentController()).myAppointments.firstWhere((element) => element.reqId == docId);

      slotsList = myAppointment.schedule!.slots!;
      slotsList.add(selectedChoice);
      Schedule schedule = Schedule(date: myAppointment.schedule!.date!, slots: myAppointment.schedule!.slots!);

      await _fireStore.collection('pending-request').doc(docId).update({
        "schedule" : schedule.toJson(),
      });
      updateRequestInClientCollection(app, uid, schedule, docId);
      CustomSnackBar.showSnackBar(
          title: "Slot added in que",
          message: '',
          backgroundColor: snackBarSuccess);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> updateRequestInClientCollection(
      AvailableAppointments app, String uid, Schedule schedule, String docId) async {
    try {
      await _fireStore
          .collection('client')
          .doc(uid)
          .collection('booked')
          .doc(app.uid)
          .update({
        "schedule" : schedule.toJson(),
      });
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }



}