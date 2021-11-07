import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rrt_client_web_app/controllers/appointment/appointment_controller.dart';
import 'package:rrt_client_web_app/controllers/appointment/booked_appointments/booked_appointment.dart';
import 'package:rrt_client_web_app/controllers/authentication/auth_controller.dart';
import 'package:rrt_client_web_app/views/home/main_screen.dart';
import 'package:rrt_client_web_app/views/home/schedule_appointment.dart';
import 'package:rrt_client_web_app/views/widgets/rrt_widgets/capture_picture.dart';
import 'package:rrt_client_web_app/views/widgets/rrt_widgets/change_password.dart';
import 'package:rrt_client_web_app/views/widgets/rrt_widgets/help.dart';
import 'package:rrt_client_web_app/views/widgets/rrt_widgets/home_dashboard.dart';
import 'package:rrt_client_web_app/views/widgets/rrt_widgets/results.dart';
import 'package:rrt_client_web_app/views/widgets/rrt_widgets/update_account.dart';
import 'package:rrt_client_web_app/views/widgets/rrt_widgets/upload_document.dart';

class HomePage extends StatefulWidget {
  // HomePage({Key? key,}) : super(key: key);

  // final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  PageController page = PageController(keepPage: true);
  final authController = Get.find<AuthController>();
  final appointmentController = Get.put(AppointmentController());
  final bookedAppointmentController = Get.put(BookedAppointmentController());


  @override
  void initState() {
    authController.getUserId().then((value) {
    bookedAppointmentController.getMyBookedAppointments(value);
    });
    super.initState();
  }

  @override
  void dispose() {
    appointmentController.dispose();
    bookedAppointmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            controller: page,
            style: SideMenuStyle(
                compactSideMenuWidth: width,
                displayMode: SideMenuDisplayMode.auto,
                hoverColor: Colors.transparent,
                selectedColor: Color(0xffEDF1F4),
                selectedTitleTextStyle:
                    TextStyle(color: Colors.redAccent, fontSize: 15),
                unselectedTitleTextStyle: TextStyle(fontSize: 15),
                selectedIconColor: Colors.redAccent,
                backgroundColor: Colors.white,
                iconSize: 15
                // openSideMenuWidth: 100
                ),
            title: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Image.asset(
                    'assets/rtt.png',
                    height: 100,
                    width: 250,
                  ),
                ),
              ],
            ),
            items: [
              SideMenuItem(
                priority: 0,
                title: 'Home',
                onTap: () {
                  page.jumpToPage(0);
                },
                icon: Icons.home,
              ),
              SideMenuItem(
                priority: 1,
                title: 'Appointments',
                onTap: () {
                  page.jumpToPage(1);
                },
                icon: Icons.event_available
              ),
              SideMenuItem(
                priority: 2,
                title: 'Schedule Appointment',
                onTap: () {
                  page.jumpToPage(2);
                },
                icon: Icons.schedule,
              ),
              SideMenuItem(
                priority: 3,
                title: 'Update Account',
                onTap: () {
                  page.jumpToPage(3);
                },
                icon: Icons.system_update_alt,
              ),
              SideMenuItem(
                priority: 4,
                title: 'Capture a Picture',
                onTap: () {
                  page.jumpToPage(4);
                },
                icon: Icons.camera_alt_outlined,
              ),
              SideMenuItem(
                priority: 5,
                title: 'Change Password',
                onTap: () {
                  page.jumpToPage(5);
                },
                icon: Icons.change_circle,
              ),
              SideMenuItem(
                priority: 6,
                title: 'Upload Document',
                onTap: () async {
                  page.jumpToPage(6);
                },
                icon: Icons.cloud_upload_outlined,
              ),
              SideMenuItem(
                priority: 7,
                title: 'Results',
                onTap: () async {
                  page.jumpToPage(7);
                },
                icon: Icons.document_scanner,
              ),
              SideMenuItem(
                priority: 8,
                title: 'Help',
                onTap: () async {
                  page.jumpToPage(8);
                },
                icon: Icons.help_outline,
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: page,
              children: [
                MainScreen(),
                HomeDashboard(),
                ScheduleAppointment(),
                UpdateAccount(),
                CapturePicture(),
                ChangePassword(),
                UploadDocument(),
                Results(),
                Help(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
