import 'package:get/get.dart';
import 'package:rrt_client_web_app/controllers/service/appointment_database.dart';
import 'package:rrt_client_web_app/models/appointment/available_appointments.dart';
import 'package:rrt_client_web_app/models/appointment/schedule.dart';


class AppointmentController extends GetxController {
  var availableAppointments = <AvailableAppointments>[].obs;

  @override
  void onInit() {
    availableAppointments.bindStream(AppointmentDatabase().getAllPost());
    super.onInit();
  }

}