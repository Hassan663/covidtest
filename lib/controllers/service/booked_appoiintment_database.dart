
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rrt_client_web_app/constants/custom_snackbar.dart';
import 'package:rrt_client_web_app/constants/rrt_colors.dart';
import 'package:rrt_client_web_app/controllers/appointment/appointment_controller.dart';
import 'package:rrt_client_web_app/controllers/authentication/auth_controller.dart';
import 'package:rrt_client_web_app/models/appointment/available_appointments.dart';
import 'package:rrt_client_web_app/models/appointment/booked_appointments/booked_appointment_model.dart';
import 'package:rrt_client_web_app/models/appointment/schedule.dart';

class BookedAppointmentDatabase{
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Stream<List<BookedAppointmentModel>> getAllBookedAppointments(String uid) {

    return _fireStore
        .collection('client')
        .doc(uid)
        .collection('booked')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      List<BookedAppointmentModel> retVal = <BookedAppointmentModel>[];
      snapshot.docs.forEach((element) {
        retVal.add(BookedAppointmentModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });

  }

}