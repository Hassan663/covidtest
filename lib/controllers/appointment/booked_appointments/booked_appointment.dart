import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:rrt_client_web_app/controllers/authentication/auth_controller.dart';
import 'package:rrt_client_web_app/controllers/service/booked_appoiintment_database.dart';
import 'package:rrt_client_web_app/models/appointment/booked_appointments/booked_appointment_model.dart';

class BookAppointmentController extends GetxController {
  var myAppointments = <BookedAppointmentModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    myAppointments.bindStream(BookedAppointmentDatabase().getAllBookedAppointments());
  }



}