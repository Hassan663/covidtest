import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rrt_client_web_app/constants/rrt_colors.dart';
import 'package:rrt_client_web_app/constants/rtt_textstyle.dart';
import 'package:rrt_client_web_app/controllers/homeDashboard/homeController.dart';
import 'package:rrt_client_web_app/views/home/schedule_appointment.dart';
import 'package:rrt_client_web_app/views/widgets/rrt_widgets/button.dart';
import 'package:rrt_client_web_app/views/widgets/rrt_widgets/header.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (_){
        return SafeArea(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Header(),
                  Padding(
                    padding: EdgeInsets.only(top: 130),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 200.0,
                          width: Get.width * 0.23,
                          // margin: EdgeInsets.only(top: 18, right: 14, left: 14),
                          decoration: BoxDecoration(
                              color: fLabelTextColor,
                              borderRadius: BorderRadius.circular(15)),

                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 40),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Schedule",
                                        style: WhiteTitle1Text,
                                      ),
                                      Icon(
                                        Icons.event,
                                        color: Colors.white,
                                        size: 50,
                                      ),
                                    ],
                                  ),
                                ),
                                CircularButtons(
                                  backgroundColor: const Color(0xfffc6359),
                                  borderColor: const Color(0xfffc6359),
                                  text: "Set Appointment",
                                  height: 40,
                                  width: Get.width * 0.2,
                                  onPressed: () {
                                    // Get.to(ScheduleAppointment());
                                  },
                                  textColor: Colors.white,
                                  textStyle: TextStyle(
                                      fontSize: 17, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 200.0,
                          width: Get.width * 0.23,
                          // margin: EdgeInsets.only(top: 18, right: 14, left: 14),
                          decoration: BoxDecoration(
                              color: fLabelTextColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 40),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Appointments",
                                        style: WhiteTitle1Text,
                                      ),
                                      Icon(
                                        Icons.event_note,
                                        color: Colors.white,
                                        size: 50,
                                      ),
                                    ],
                                  ),
                                ),
                                CircularButtons(
                                  backgroundColor: const Color(0xfffc6359),
                                  borderColor: const Color(0xfffc6359),
                                  text: "All Appointment",
                                  height: 40,
                                  width: Get.width * 0.2,
                                  onPressed: () {
                                    // Get.to(HomeDashboard());
                                  },
                                  textColor: Colors.white,
                                  textStyle: TextStyle(
                                      fontSize: 17, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 200.0,
                          width: Get.width * 0.23,
                          // margin: EdgeInsets.only(top: 18, right: 14, left: 14),
                          decoration: BoxDecoration(
                              color: fLabelTextColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 40),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Results",
                                        style: WhiteTitle1Text,
                                      ),
                                      Icon(
                                        Icons.event,
                                        color: Colors.white,
                                        size: 50,
                                      ),
                                    ],
                                  ),
                                ),
                                CircularButtons(
                                  backgroundColor: const Color(0xfffc6359),
                                  borderColor: const Color(0xfffc6359),
                                  text: "View Results",
                                  height: 40,
                                  width: Get.width * 0.2,
                                  onPressed: () {
                                    // Get.to(Results());
                                  },
                                  textColor: Colors.white,
                                  textStyle: TextStyle(
                                      fontSize: 17, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

