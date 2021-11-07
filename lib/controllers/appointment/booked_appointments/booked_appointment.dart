import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:rrt_client_web_app/controllers/authentication/auth_controller.dart';
import 'package:rrt_client_web_app/controllers/service/booked_appoiintment_database.dart';
import 'package:rrt_client_web_app/models/appointment/booked_appointments/booked_appointment_model.dart';

class BookedAppointmentController extends GetxController {
  var myAppointments = <BookedAppointmentModel>[].obs;

  void getMyBookedAppointments(String uid){
    myAppointments.bindStream(BookedAppointmentDatabase().getAllBookedAppointments(uid));
  }

}