import 'package:get/get.dart';
import 'package:rrt_client_web_app/controllers/authentication/auth_controller.dart';
import 'package:rrt_client_web_app/controllers/service/appointment_database.dart';
import 'package:rrt_client_web_app/controllers/service/database.dart';
import 'package:rrt_client_web_app/models/appointment/available_appointments.dart';
import 'package:rrt_client_web_app/models/appointment/schedule.dart';
import 'package:rrt_client_web_app/models/appointment/slots.dart';


class AppointmentController extends GetxController {
  var availableAppointments = <AvailableAppointments>[].obs;
  var chipList = <Slots>[].obs;
  var selectedChoice = Slots().obs;
  var selectedApp = AvailableAppointments().obs;
  final authController = Get.find<AuthController>();

  @override
  void onInit() {
    availableAppointments.bindStream(AppointmentDatabase().getAllPost());
    super.onInit();
  }

  void createRequestInDatabase(){
    AppointmentDatabase().generateRequestInDatabase(selectedApp.value, authController.currentUser.value.uid!);
  }

}