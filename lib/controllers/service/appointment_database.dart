
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rrt_client_web_app/constants/custom_snackbar.dart';
import 'package:rrt_client_web_app/constants/rrt_colors.dart';
import 'package:rrt_client_web_app/controllers/appointment/appointment_controller.dart';
import 'package:rrt_client_web_app/controllers/authentication/auth_controller.dart';
import 'package:rrt_client_web_app/models/appointment/available_appointments.dart';
import 'package:rrt_client_web_app/models/appointment/schedule.dart';

class AppointmentDatabase{
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

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

  }Future<bool> generateRequestInDatabase(AvailableAppointments app, String uid) async {
    try {
      Timestamp currentTime = Timestamp.now();
      await _fireStore.collection('pending-request').doc().set({
        "clientId": uid,
        "appId" : app.uid,
        "nurseId" : app.nurseId,
        "schedule" : app.schedule!.toJson(),
        "appCreatedAt" : app.createdAt,
        "createdAt": currentTime,
        "status" : "Pending"
      });
      generateRequestInClientCollection(app, currentTime, uid);
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
      AvailableAppointments app, Timestamp currentTime, String uid) async {
    try {
      await _fireStore
          .collection('client')
          .doc(uid)
          .collection('booked')
          .doc()
          .set({
        "clientId": uid,
        "appId" : app.uid,
        "nurseId" : app.nurseId,
        "schedule" : app.schedule!.toJson(),
        "appCreatedAt" : app.createdAt,
        "createdAt": currentTime,
        "status" : "Pending"
      });
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }



}