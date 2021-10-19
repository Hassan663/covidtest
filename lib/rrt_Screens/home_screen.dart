import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:rrt_client_web_app/rrt_widgets/capture_picture.dart';
import 'package:rrt_client_web_app/rrt_widgets/change_password.dart';
import 'package:rrt_client_web_app/rrt_widgets/help.dart';
import 'package:rrt_client_web_app/rrt_widgets/home_dashboard.dart';
import 'package:rrt_client_web_app/rrt_widgets/results.dart';
import 'package:rrt_client_web_app/rrt_widgets/rrt_colors.dart';
import 'package:rrt_client_web_app/rrt_Screens/schedule_appointment.dart';
import 'package:rrt_client_web_app/rrt_widgets/update_account.dart';
import 'package:rrt_client_web_app/rrt_widgets/upload_document.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  // HomePage({Key? key,}) : super(key: key);

  // final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController page = PageController();

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
                title: 'Schedule Appointment',
                onTap: () {
                  page.jumpToPage(1);
                },
                icon: Icons.schedule,
              ),
              SideMenuItem(
                priority: 2,
                title: 'Update Account',
                onTap: () {
                  page.jumpToPage(2);
                },
                icon: Icons.system_update_alt,
              ),
              SideMenuItem(
                priority: 3,
                title: 'Capture a Picture',
                onTap: () {
                  page.jumpToPage(3);
                },
                icon: Icons.camera_alt_outlined,
              ),
              SideMenuItem(
                priority: 4,
                title: 'Change Password',
                onTap: () {
                  page.jumpToPage(4);
                },
                icon: Icons.change_circle,
              ),
              SideMenuItem(
                priority: 5,
                title: 'Upload Document',
                onTap: () async {
                  page.jumpToPage(5);
                },
                icon: Icons.cloud_upload_outlined,
              ),
              SideMenuItem(
                priority: 6,
                title: 'Results',
                onTap: () async {
                  page.jumpToPage(6);
                },
                icon: Icons.document_scanner,
              ),
              SideMenuItem(
                priority: 7,
                title: 'Help',
                onTap: () async {
                  page.jumpToPage(7);
                },
                icon: Icons.help_outline,
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: page,
              children: [
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
}