import 'dart:html';
import 'package:date_format/date_format.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rrt_client_web_app/constants/rrt_colors.dart';
import 'package:rrt_client_web_app/constants/rrt_sizes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rrt_client_web_app/constants/rtt_textstyle.dart';
import 'package:rrt_client_web_app/controllers/appointment/appointment_controller.dart';
import 'package:rrt_client_web_app/controllers/appointment/booked_appointments/booked_appointment.dart';
import 'package:rrt_client_web_app/controllers/schedule/schedule_controller.dart';
import 'package:rrt_client_web_app/models/appointment/booked_appointments/booked_appointment_model.dart';
import 'package:rrt_client_web_app/models/appointment/slots.dart';
import 'package:rrt_client_web_app/views/widgets/rrt_widgets/button.dart';
import 'package:rrt_client_web_app/views/widgets/rrt_widgets/cache.dart';
import 'package:rrt_client_web_app/views/widgets/rrt_widgets/header.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert';

class ScheduleAppointment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScheduleController>(
      init: ScheduleController(),
      builder: (_) {
        return _.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(
                          0xffE5E5E5), //new Color.fromRGBO(255, 0, 0, 0.0),
                      borderRadius: new BorderRadius.only(
                          topLeft:
                              Radius.circular(circular_radius_homeContainers),
                          bottomLeft:
                              Radius.circular(circular_radius_homeContainers))),
                  child: Padding(
                    padding: EdgeInsets.all(35.0.sp),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Header(),
                          SizedBox(
                            height: 35.h,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 20.w),
                                child: Text(
                                  'Calendar',
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Color(0xff5FA4A4),
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Expanded(
                                  child: Divider(
                                color: Color(0xff5FA4A4),
                              )),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
// Container(
//                             height: MediaQuery.of(context).size.height * 0.30,
//                             width: MediaQuery.of(context).size.width,
//                             child: Obx(
//                               () => GridView.builder(
//                                   gridDelegate:
//                                       SliverGridDelegateWithFixedCrossAxisCount(
//                                           crossAxisCount: 4,

//                                           //childAspectRatio: 3.w / 3.h,
//                                           crossAxisSpacing: 20.w,
//                                           mainAxisSpacing: 10.h),
//                                   itemCount: _.appointmentController
//                                       .availableAppointments.length,
//                                   itemBuilder: (BuildContext ctx, index) {
//                                     DateTime date =
//                                         DateTime.fromMillisecondsSinceEpoch(_
//                                                 .appointmentController
//                                                 .availableAppointments[index]
//                                                 .schedule!
//                                                 .date!
//                                                 .seconds *
//                                             1000);
//                                     return Padding(
//                                       padding: EdgeInsets.all(8.0.sp),
//                                       child: SingleChildScrollView(
//                                         child: Container(
//                                           //height: 100.0.h,
//                                           // margin: EdgeInsets.only(top: 18, right: 14, left: 14),
//                                           decoration: BoxDecoration(
//                                               color: fLabelTextColor,
//                                               borderRadius:
//                                                   BorderRadius.circular(15)),
//                                           child: Column(
//                                             children: [
//                                               Padding(
//                                                 padding:
//                                                     EdgeInsets.all(15.0.sp),
//                                                 child: Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceBetween,
//                                                   children: [
//                                                     Padding(
//                                                       padding: EdgeInsets.only(
//                                                           top: 15.h),
//                                                       child: Container(
//                                                         width: 150,
//                                                         child: Text(
//                                                           "Nurse: ${_.appointmentController.availableAppointments[index].nurseId}",
//                                                           overflow: TextOverflow
//                                                               .ellipsis,
//                                                           softWrap: true,
//                                                           maxLines: 2,
//                                                           style:
//                                                               GoogleFonts.inter(
//                                                                   fontSize:
//                                                                       20.sp,
//                                                                   fontStyle:
//                                                                       FontStyle
//                                                                           .normal,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w600,
//                                                                   color: Colors
//                                                                       .white),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     // Image.asset("assets/video.png"),
//                                                   ],
//                                                 ),
//                                               ),
//                                               Container(
//                                                 margin: EdgeInsets.only(
//                                                     left: 10.w,
//                                                     right: 10.w,
//                                                     top: 20.h),
//                                                 height: 60.h,
//                                                 decoration: BoxDecoration(
//                                                     color: fContainerColor,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             10)),
//                                                 child: Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceEvenly,
//                                                   children: [
//                                                     Container(
//                                                         height: 25.h,
//                                                         width: 25.w,
//                                                         child: Image.asset(
//                                                             "assets/datetime.png")),
//                                                     Container(
//                                                       width: 150,
//                                                       child: Text(
//                                                         "${date.day}-${date.month}-${date.year}",
//                                                         overflow: TextOverflow
//                                                             .ellipsis,
//                                                         style:
//                                                             GoogleFonts.inter(
//                                                                 fontSize: 15.sp,
//                                                                 fontStyle:
//                                                                     FontStyle
//                                                                         .normal,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w500,
//                                                                 color: Colors
//                                                                     .white),
//                                                       ),
//                                                     )
//                                                   ],
//                                                 ),
//                                               ),
//                                               Padding(
//                                                 padding: EdgeInsets.only(
//                                                     left: 10.w,
//                                                     right: 10.w,
//                                                     top: 30.h),
//                                                 child: Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceBetween,
//                                                   children: [
//                                                     ElevatedButton(
//                                                         onPressed: () {
//                                                           // showDialog(
//                                                           //     context: context,
//                                                           //     builder: (BuildContext
//                                                           //         context) {
//                                                           //       return AlertDialog(
//                                                           //           shape: RoundedRectangleBorder(
//                                                           //               borderRadius: BorderRadius
//                                                           //                   .all(Radius
//                                                           //                       .circular(
//                                                           //                           20.0))),
//                                                           //           backgroundColor:
//                                                           //               Colors.white,
//                                                           //           content: Container(
//                                                           //             height: 300,
//                                                           //             width: 500,
//                                                           //             child: Column(
//                                                           //               mainAxisAlignment:
//                                                           //                   MainAxisAlignment
//                                                           //                       .spaceAround,
//                                                           //               children: [
//                                                           //                 Row(
//                                                           //                   mainAxisAlignment:
//                                                           //                       MainAxisAlignment
//                                                           //                           .center,
//                                                           //                   children: [
//                                                           //                     Text(
//                                                           //                       'Countdown Started',
//                                                           //                       style: TextStyle(
//                                                           //                           color:
//                                                           //                               fButtonColor,
//                                                           //                           fontSize:
//                                                           //                               25,
//                                                           //                           fontWeight:
//                                                           //                               FontWeight.bold),
//                                                           //                     ),
//                                                           //                   ],
//                                                           //                 ),
//                                                           //                 Row(
//                                                           //                   mainAxisAlignment:
//                                                           //                       MainAxisAlignment
//                                                           //                           .spaceAround,
//                                                           //                   children: [
//                                                           //                     Container(
//                                                           //                       height:
//                                                           //                           170.0,
//                                                           //                       width:
//                                                           //                           270,
//                                                           //                       // margin: EdgeInsets.only(top: 18, right: 14, left: 14),
//                                                           //                       decoration: BoxDecoration(
//                                                           //                           color:
//                                                           //                               fLabelTextColor,
//                                                           //                           borderRadius:
//                                                           //                               BorderRadius.circular(15)),
//                                                           //                       child:
//                                                           //                           Column(
//                                                           //                         children: [
//                                                           //                           Padding(
//                                                           //                             padding: const EdgeInsets.all(15.0),
//                                                           //                             child: Row(
//                                                           //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                           //                               children: [
//                                                           //                                 Text(
//                                                           //                                   "Appointment $index",
//                                                           //                                   style: GoogleFonts.inter(fontSize: 20, fontStyle: FontStyle.normal, fontWeight: FontWeight.w600, color: Colors.white),
//                                                           //                                 ),
//                                                           //                                 // Image.asset("assets/video.png"),
//                                                           //                               ],
//                                                           //                             ),
//                                                           //                           ),
//                                                           //                           Container(
//                                                           //                             margin: EdgeInsets.only(left: 10, right: 10),
//                                                           //                             height: 60,
//                                                           //                             decoration: BoxDecoration(color: fContainerColor, borderRadius: BorderRadius.circular(10)),
//                                                           //                             child: Padding(
//                                                           //                               padding: const EdgeInsets.all(10.0),
//                                                           //                               child: Row(
//                                                           //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                           //                                 children: [
//                                                           //                                   Image.asset("assets/datetime.png"),
//                                                           //                                   Text(
//                                                           //                                     "Fri, May 23, 10:00 am - 11:00 am",
//                                                           //                                     style: GoogleFonts.inter(fontSize: 12, fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: Colors.white),
//                                                           //                                   )
//                                                           //                                 ],
//                                                           //                               ),
//                                                           //                             ),
//                                                           //                           ),
//                                                           //                           Padding(
//                                                           //                             padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
//                                                           //                             child: Row(
//                                                           //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                           //                               children: [
//                                                           //                                 ElevatedButton(
//                                                           //                                     onPressed: () {},
//                                                           //                                     child: Text(
//                                                           //                                       "Start Soon",
//                                                           //                                       style: GoogleFonts.inter(fontSize: 15.sp, fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: Colors.white),
//                                                           //                                     ),
//                                                           //                                     style: ElevatedButton.styleFrom(fixedSize: Size(110, 30), primary: Colors.orangeAccent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
//                                                           //                                 ElevatedButton(
//                                                           //                                     onPressed: () {
//                                                           //                                       Navigator.of(context).pop();
//                                                           //                                     },
//                                                           //                                     child: Text(
//                                                           //                                       "Cancel",
//                                                           //                                       style: GoogleFonts.inter(fontSize: 15.sp, fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: Colors.white),
//                                                           //                                     ),
//                                                           //                                     style: ElevatedButton.styleFrom(fixedSize: Size(110, 30), primary: fButtonColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
//                                                           //                               ],
//                                                           //                             ),
//                                                           //                           )
//                                                           //                         ],
//                                                           //                       ),
//                                                           //                     ),
//                                                           //                     Column(
//                                                           //                       children: [
//                                                           //                         Icon(
//                                                           //                             Icons.timer,
//                                                           //                             size: 60,
//                                                           //                             color: Colors.red),
//                                                           //                         TimerCountdown(
//                                                           //                           enableDescriptions:
//                                                           //                               false,
//                                                           //                           timeTextStyle:
//                                                           //                               TextStyle(fontSize: 35, fontWeight: FontWeight.w900),
//                                                           //                           colonsTextStyle:
//                                                           //                               TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//                                                           //                           spacerWidth:
//                                                           //                               0,
//                                                           //                           format:
//                                                           //                               CountDownTimerFormat.hoursMinutesSeconds,
//                                                           //                           endTime:
//                                                           //                               DateTime.now().add(
//                                                           //                             Duration(
//                                                           //                               minutes: 27,
//                                                           //                               seconds: 34,
//                                                           //                             ),
//                                                           //                           ),
//                                                           //                           onEnd:
//                                                           //                               () {
//                                                           //                             print("Timer finished");
//                                                           //                           },
//                                                           //                         ),
//                                                           //                       ],
//                                                           //                     )
//                                                           //                   ],
//                                                           //                 )
//                                                           //               ],
//                                                           //             ),
//                                                           //             // decoration: BoxDecoration(
//                                                           //             // image: DecorationImage(
//                                                           //             // image: NetworkImage('https://media.istockphoto.com/photos/freedom-chains-that-transform-into-birds-charge-concept-picture-id1322104312?b=1&k=20&m=1322104312&s=170667a&w=0&h=VQyPkFkMKmo0e4ixjhiOLjiRs_ZiyKR_4SAsagQQdkk='),
//                                                           //             // fit: BoxFit.cover))
//                                                           //           ));
//                                                           //     });
//                                                           _.appointmentController
//                                                                   .chipList.value =
//                                                               _
//                                                                   .appointmentController
//                                                                   .availableAppointments[
//                                                                       index]
//                                                                   .schedule!
//                                                                   .slots!;
//                                                           _
//                                                               .appointmentController
//                                                               .selectedApp
//                                                               .value = _
//                                                                   .appointmentController
//                                                                   .availableAppointments[
//                                                               index];
//                                                         },
//                                                         child: Text(
//                                                           "Check Slots",
//                                                           overflow: TextOverflow
//                                                               .ellipsis,
//                                                           style:
//                                                               GoogleFonts.inter(
//                                                                   fontSize:
//                                                                       15.sp,
//                                                                   fontStyle:
//                                                                       FontStyle
//                                                                           .normal,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w500,
//                                                                   color: Colors
//                                                                       .white),
//                                                         ),
//                                                         style: ElevatedButton.styleFrom(
//                                                             fixedSize: Size(
//                                                                 130.w, 30.h),
//                                                             primary:
//                                                                 fButtonColor,
//                                                             shape: RoundedRectangleBorder(
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                             20)))),
//                                                     ElevatedButton(
//                                                         onPressed: () {},
//                                                         child: Text(
//                                                           "Cancel",
//                                                           overflow: TextOverflow
//                                                               .ellipsis,
//                                                           style:
//                                                               GoogleFonts.inter(
//                                                                   fontSize:
//                                                                       15.sp,
//                                                                   fontStyle:
//                                                                       FontStyle
//                                                                           .normal,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w500,
//                                                                   color: Colors
//                                                                       .white),
//                                                         ),
//                                                         style: ElevatedButton.styleFrom(
//                                                             fixedSize: Size(
//                                                                 130.w, 30.h),
//                                                             primary:
//                                                                 fButtonColor,
//                                                             shape: RoundedRectangleBorder(
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                             20)))),
//                                                   ],
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 height: 30.h,
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   }),
//                             ),
//                           ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: new BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                    color: Colors
                                        .white, //new Color.fromRGBO(255, 0, 0, 0.0),
                                    borderRadius: new BorderRadius.all(
                                      Radius.circular(5),
                                    )),
                                height:
                                    MediaQuery.of(context).size.height * 0.57,
                                width: Get.width * 0.36,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TableCalendar(
                                    firstDay: DateTime.now(),
                                    lastDay: DateTime.utc(2030, 3, 14),
                                    focusedDay: _.focusedDays,
                                    calendarFormat: _.calendarFormat,
                                    calendarStyle: CalendarStyle(
                                      selectedDecoration: BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle),
                                      rangeHighlightColor: Colors.red,
                                    ),
                                    pageJumpingEnabled: true,
                                    daysOfWeekHeight: 25.h,
                                    rowHeight: 60.h,
                                    pageAnimationEnabled: true,
                                    daysOfWeekVisible: true,
                                    headerStyle: HeaderStyle(
                                      formatButtonVisible: false,
                                      titleCentered: true,
                                      titleTextStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                      rightChevronIcon: CircleAvatar(
                                        backgroundColor: Colors.red,
                                        child: Icon(Icons.chevron_right),
                                      ),
                                      leftChevronIcon: CircleAvatar(
                                        backgroundColor: Colors.red,
                                        child: Icon(Icons.chevron_left),
                                      ),
                                    ),
                                    availableGestures:
                                        AvailableGestures.horizontalSwipe,
                                    headerVisible: true,
                                    selectedDayPredicate: (day) {
                                      return isSameDay(_.selectedDays, day);
                                    },
                                    onDaySelected: (selectedDay, focusedDay) {
                                      if (!isSameDay(
                                          _.selectedDays, selectedDay)) {
                                        _.selectedDays = selectedDay;
                                        _.focusedDays = focusedDay;
                                        _.update();
                                        _.getAppoinment();
                                        print(_.selectedDays);
                                      }
                                    },
                                    onFormatChanged: (format) {
                                      if (_.calendarFormat != format) {
                                        _.calendarFormat = format;
                                        _.update();
                                      }
                                    },
                                    onPageChanged: (focusedDay) {
                                      _.focusedDays = focusedDay;
                                      _.update();
                                    },
                                  ),
                                  
                                ),
                              ),
                              //second row choice chip
                              Container(
                                decoration: new BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: new BorderRadius.all(
                                      Radius.circular(5),
                                    )),
                                height:
                                    MediaQuery.of(context).size.height * 0.57,
                                width: Get.width * 0.36,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 30),
                                        child: Text(
                                          "Select Time Slot",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      ListView.separated(
                                        itemCount: _.appoinmentlist.length,
                                        shrinkWrap: true,
                                        separatorBuilder: (c, e) {
                                          return SizedBox(
                                            height: 10.0,
                                          );
                                        },
                                        itemBuilder: (c, e) {
                                          return Container(
                                            width: Get.width * 0.36,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10.0),
                                                topRight: Radius.circular(10.0),
                                                bottomLeft:
                                                    Radius.circular(10.0),
                                                bottomRight:
                                                    Radius.circular(10.0),
                                              ),
                                            ),
                                            height: 50.0,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "${_.appoinmentlist[e]['startappointmentTime']}",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  Text(" - ",
                                                      style: TextStyle(
                                                          color: Colors.black)),
                                                  Text(
                                                      "${_.appoinmentlist[e]['endappointmentTime']}",
                                                      style: TextStyle(
                                                          color: Colors.black)),
                                                ],
                                              ).marginOnly(
                                                  left: 10.0, right: 10.0),
                                            ),
                                          );
                                        },
                                      ).marginOnly(left: 10.0, right: 10.0)
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: CircularButtons(
                                backgroundColor: const Color(0xfffc6359),
                                borderColor: const Color(0xfffc6359),
                                text: "Set Appointment",
                                height: 50,
                                textColor: Colors.white,
                                textStyle: WhiteText,
                                width: Get.width * 0.3,
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0))),
                                            backgroundColor: Colors.white,
                                            content: Container(
                                              height: 200,
                                              width: 400,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Do you want to book this time slot',
                                                        style: TextStyle(
                                                            color: fButtonColor,
                                                            fontSize: 25,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      CircularButtons(
                                                        backgroundColor:
                                                            const Color(
                                                                0xff4F8484),
                                                        borderColor:
                                                            const Color(
                                                                0xff4F8484),
                                                        text: "Yes",
                                                        height: 50,
                                                        width: Get.width * 0.1,
                                                        textColor: Colors.white,
                                                        textStyle: WhiteText,
                                                        onPressed: () {
                                                          final bookedAppointmentController =
                                                              Get.find<
                                                                  BookedAppointmentController>();

                                                          if (bookedAppointmentController
                                                              .myAppointments
                                                              .isEmpty) {
                                                            _.appointmentController
                                                                .createRequestInDatabase();
                                                          } else {
                                                            // CHECKING IF THE SLOT IS ALREADY IN OUR LIST

                                                            // for (var element in bookedAppointmentController.myAppointments) {
                                                            //   if(element.schedule!.slots!.length == appointmentController.selectedApp.value.schedule!.slots!.length){
                                                            //     for (var slot in element.schedule!.slots!){
                                                            //       if(slot.startSlot == appointmentController.selectedChoice.value.startSlot && slot.endSlot == appointmentController.selectedChoice.value.endSlot){
                                                            //         print("SLOT ALREADY EXISTS");
                                                            //       }else{
                                                            //
                                                            //       }
                                                            //     }
                                                            //   }else{
                                                            //     print("DOES NOT EXISTS");
                                                            //   }
                                                            // }

                                                            for (var element
                                                                in bookedAppointmentController
                                                                    .myAppointments) {
                                                              if (element
                                                                      .docId ==
                                                                  _
                                                                      .appointmentController
                                                                      .selectedApp
                                                                      .value
                                                                      .uid) {
                                                                _.appointmentController
                                                                    .updateRequestInDatabase(
                                                                        element
                                                                            .reqId!);
                                                                break;
                                                              } else {
                                                                _.appointmentController
                                                                    .createRequestInDatabase();
                                                                break;
                                                              }
                                                            }
                                                          }
                                                          print(_
                                                              .appointmentController
                                                              .selectedApp
                                                              .value
                                                              .uid);
                                                          // FirebaseFirestore.instance
                                                          //     .collection(
                                                          //     'available-appointments')
                                                          //     .doc(
                                                          //     appointmentController
                                                          //         .selectedApp
                                                          //         .value
                                                          //         .uid)
                                                          //     .get()
                                                          //     .then((value) {
                                                          //   if (value.exists) {
                                                          //     appointmentController
                                                          //         .createRequestInDatabase();
                                                          //     print(value.exists);
                                                          //   } else {
                                                          //     print(value.exists);
                                                          //     appointmentController
                                                          //         .updateRequestInDatabase(
                                                          //         appointmentController
                                                          //             .selectedApp
                                                          //             .value
                                                          //             .uid!);
                                                          //   }
                                                          // });

                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                      CircularButtons(
                                                        backgroundColor:
                                                            const Color(
                                                                0xfffc6359),
                                                        borderColor:
                                                            const Color(
                                                                0xfffc6359),
                                                        text: "No",
                                                        height: 50,
                                                        width: Get.width * 0.1,
                                                        textColor: Colors.white,
                                                        textStyle: WhiteText,
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ));
                                      });
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }
}

// class ScheduleAppointment extends StatefulWidget {
//   @override
//   _ScheduleAppointmentState createState() => _ScheduleAppointmentState();
// }
//
// class _ScheduleAppointmentState extends State<ScheduleAppointment>
//     with AutomaticKeepAliveClientMixin {
//   @override
//   Widget build(BuildContext context) {
//
//     var formatted = formatDate(DateTime.now(), [mm]);
//     var formatted1;
//     List<String> _subjectCollection = <String>[];
//     List<Color> _colorCollection = <Color>[];
//
// //     Map<DateTime, List> _listEvents;
// // final currentDay = DateTime.now();
// // _listEvents = {
// //     currentDay.add( Duration(days: 12)): [‘Event 1’, ‘Event 2’],
// // };
//
//     //List<Appointment> _shiftCollection = <Appointment>[];
//     //List<CalendarResource> _employeeCollection = <CalendarResource>[];
//     //_DataSource? _events;
//
//     //DateTime? selectedDay;
//     // List<Event> _getEventsForDay(DateTime day) {
//     //   return;
//     // }
//
//     // void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
//     //   if (!isSameDay(selectedDay, selectedDay)) {
//     //     setState(() {
//     //       focusedDay = focusedDay;
//     //       selectedDay = selectedDay;
//     //       selectedEvents = _getEventsForDay(selectedDay);
//     //     });
//     //   }
//     // }
//     // CalendarFormat format = CalendarFormat.month;
//     // DateTime selectedDay = DateTime.now();
//     // DateTime focusedDay = DateTime.now();
//     //  @override
//     // void initState() {
//     //   _events = _DataSource(_shiftCollection, _employeeCollection);
//     //   _selectedDay = _focusedDay;
//     //   super.initState();
//     // }
//
//     @override
//     void dispose() {
//       super.dispose();
//     }
//
//     return SafeArea(
//         child: Container(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             decoration: BoxDecoration(
//                 color: Color(0xffE5E5E5), //new Color.fromRGBO(255, 0, 0, 0.0),
//                 borderRadius: new BorderRadius.only(
//                     topLeft: Radius.circular(circular_radius_homeContainers),
//                     bottomLeft:
//                         Radius.circular(circular_radius_homeContainers))),
//             child: Padding(
//               padding: EdgeInsets.all(35.0.sp),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Header(),
//                     SizedBox(
//                       height: 35.h,
//                     ),
//                     Row(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(right: 20.w),
//                           child: Text(
//                             'Calendar',
//                             maxLines: 1,
//                             style: TextStyle(
//                                 color: Color(0xff5FA4A4),
//                                 fontWeight: FontWeight.w700),
//                           ),
//                         ),
//                         Expanded(
//                             child: Divider(
//                           color: Color(0xff5FA4A4),
//                         )),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     Container(
//                       height: MediaQuery.of(context).size.height * 0.30,
//                       width: MediaQuery.of(context).size.width,
//                       child: Obx(
//                         () => GridView.builder(
//                             gridDelegate:
//                                 SliverGridDelegateWithFixedCrossAxisCount(
//                                     crossAxisCount: 4,
//
//                                     //childAspectRatio: 3.w / 3.h,
//                                     crossAxisSpacing: 20.w,
//                                     mainAxisSpacing: 10.h),
//                             itemCount: appointmentController
//                                 .availableAppointments.length,
//                             itemBuilder: (BuildContext ctx, index) {
//                               DateTime date =
//                                   DateTime.fromMillisecondsSinceEpoch(
//                                       appointmentController
//                                               .availableAppointments[index]
//                                               .schedule!
//                                               .date!
//                                               .seconds *
//                                           1000);
//                               return Padding(
//                                 padding: EdgeInsets.all(8.0.sp),
//                                 child: SingleChildScrollView(
//                                   child: Container(
//                                     //height: 100.0.h,
//                                     // margin: EdgeInsets.only(top: 18, right: 14, left: 14),
//                                     decoration: BoxDecoration(
//                                         color: fLabelTextColor,
//                                         borderRadius:
//                                             BorderRadius.circular(15)),
//                                     child: Column(
//                                       children: [
//                                         Padding(
//                                           padding: EdgeInsets.all(15.0.sp),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Padding(
//                                                 padding:
//                                                     EdgeInsets.only(top: 15.h),
//                                                 child: Container(
//                                                   width: 150,
//                                                   child: Text(
//                                                     "Nurse: ${appointmentController.availableAppointments[index].nurseId}",
//                                                     overflow:
//                                                         TextOverflow.ellipsis,
//                                                     softWrap: true,
//                                                     maxLines: 2,
//                                                     style: GoogleFonts.inter(
//                                                         fontSize: 20.sp,
//                                                         fontStyle:
//                                                             FontStyle.normal,
//                                                         fontWeight:
//                                                             FontWeight.w600,
//                                                         color: Colors.white),
//                                                   ),
//                                                 ),
//                                               ),
//                                               // Image.asset("assets/video.png"),
//                                             ],
//                                           ),
//                                         ),
//                                         Container(
//                                           margin: EdgeInsets.only(
//                                               left: 10.w,
//                                               right: 10.w,
//                                               top: 20.h),
//                                           height: 60.h,
//                                           decoration: BoxDecoration(
//                                               color: fContainerColor,
//                                               borderRadius:
//                                                   BorderRadius.circular(10)),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceEvenly,
//                                             children: [
//                                               Container(
//                                                   height: 25.h,
//                                                   width: 25.w,
//                                                   child: Image.asset(
//                                                       "assets/datetime.png")),
//                                               Container(
//                                                 width: 150,
//                                                 child: Text(
//                                                   "${date.day}-${date.month}-${date.year}",
//                                                   overflow:
//                                                       TextOverflow.ellipsis,
//                                                   style: GoogleFonts.inter(
//                                                       fontSize: 15.sp,
//                                                       fontStyle:
//                                                           FontStyle.normal,
//                                                       fontWeight:
//                                                           FontWeight.w500,
//                                                       color: Colors.white),
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: EdgeInsets.only(
//                                               left: 10.w,
//                                               right: 10.w,
//                                               top: 30.h),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               ElevatedButton(
//                                                   onPressed: () {
//                                                     // showDialog(
//                                                     //     context: context,
//                                                     //     builder: (BuildContext
//                                                     //         context) {
//                                                     //       return AlertDialog(
//                                                     //           shape: RoundedRectangleBorder(
//                                                     //               borderRadius: BorderRadius
//                                                     //                   .all(Radius
//                                                     //                       .circular(
//                                                     //                           20.0))),
//                                                     //           backgroundColor:
//                                                     //               Colors.white,
//                                                     //           content: Container(
//                                                     //             height: 300,
//                                                     //             width: 500,
//                                                     //             child: Column(
//                                                     //               mainAxisAlignment:
//                                                     //                   MainAxisAlignment
//                                                     //                       .spaceAround,
//                                                     //               children: [
//                                                     //                 Row(
//                                                     //                   mainAxisAlignment:
//                                                     //                       MainAxisAlignment
//                                                     //                           .center,
//                                                     //                   children: [
//                                                     //                     Text(
//                                                     //                       'Countdown Started',
//                                                     //                       style: TextStyle(
//                                                     //                           color:
//                                                     //                               fButtonColor,
//                                                     //                           fontSize:
//                                                     //                               25,
//                                                     //                           fontWeight:
//                                                     //                               FontWeight.bold),
//                                                     //                     ),
//                                                     //                   ],
//                                                     //                 ),
//                                                     //                 Row(
//                                                     //                   mainAxisAlignment:
//                                                     //                       MainAxisAlignment
//                                                     //                           .spaceAround,
//                                                     //                   children: [
//                                                     //                     Container(
//                                                     //                       height:
//                                                     //                           170.0,
//                                                     //                       width:
//                                                     //                           270,
//                                                     //                       // margin: EdgeInsets.only(top: 18, right: 14, left: 14),
//                                                     //                       decoration: BoxDecoration(
//                                                     //                           color:
//                                                     //                               fLabelTextColor,
//                                                     //                           borderRadius:
//                                                     //                               BorderRadius.circular(15)),
//                                                     //                       child:
//                                                     //                           Column(
//                                                     //                         children: [
//                                                     //                           Padding(
//                                                     //                             padding: const EdgeInsets.all(15.0),
//                                                     //                             child: Row(
//                                                     //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                     //                               children: [
//                                                     //                                 Text(
//                                                     //                                   "Appointment $index",
//                                                     //                                   style: GoogleFonts.inter(fontSize: 20, fontStyle: FontStyle.normal, fontWeight: FontWeight.w600, color: Colors.white),
//                                                     //                                 ),
//                                                     //                                 // Image.asset("assets/video.png"),
//                                                     //                               ],
//                                                     //                             ),
//                                                     //                           ),
//                                                     //                           Container(
//                                                     //                             margin: EdgeInsets.only(left: 10, right: 10),
//                                                     //                             height: 60,
//                                                     //                             decoration: BoxDecoration(color: fContainerColor, borderRadius: BorderRadius.circular(10)),
//                                                     //                             child: Padding(
//                                                     //                               padding: const EdgeInsets.all(10.0),
//                                                     //                               child: Row(
//                                                     //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                     //                                 children: [
//                                                     //                                   Image.asset("assets/datetime.png"),
//                                                     //                                   Text(
//                                                     //                                     "Fri, May 23, 10:00 am - 11:00 am",
//                                                     //                                     style: GoogleFonts.inter(fontSize: 12, fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: Colors.white),
//                                                     //                                   )
//                                                     //                                 ],
//                                                     //                               ),
//                                                     //                             ),
//                                                     //                           ),
//                                                     //                           Padding(
//                                                     //                             padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
//                                                     //                             child: Row(
//                                                     //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                     //                               children: [
//                                                     //                                 ElevatedButton(
//                                                     //                                     onPressed: () {},
//                                                     //                                     child: Text(
//                                                     //                                       "Start Soon",
//                                                     //                                       style: GoogleFonts.inter(fontSize: 15.sp, fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: Colors.white),
//                                                     //                                     ),
//                                                     //                                     style: ElevatedButton.styleFrom(fixedSize: Size(110, 30), primary: Colors.orangeAccent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
//                                                     //                                 ElevatedButton(
//                                                     //                                     onPressed: () {
//                                                     //                                       Navigator.of(context).pop();
//                                                     //                                     },
//                                                     //                                     child: Text(
//                                                     //                                       "Cancel",
//                                                     //                                       style: GoogleFonts.inter(fontSize: 15.sp, fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: Colors.white),
//                                                     //                                     ),
//                                                     //                                     style: ElevatedButton.styleFrom(fixedSize: Size(110, 30), primary: fButtonColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
//                                                     //                               ],
//                                                     //                             ),
//                                                     //                           )
//                                                     //                         ],
//                                                     //                       ),
//                                                     //                     ),
//                                                     //                     Column(
//                                                     //                       children: [
//                                                     //                         Icon(
//                                                     //                             Icons.timer,
//                                                     //                             size: 60,
//                                                     //                             color: Colors.red),
//                                                     //                         TimerCountdown(
//                                                     //                           enableDescriptions:
//                                                     //                               false,
//                                                     //                           timeTextStyle:
//                                                     //                               TextStyle(fontSize: 35, fontWeight: FontWeight.w900),
//                                                     //                           colonsTextStyle:
//                                                     //                               TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//                                                     //                           spacerWidth:
//                                                     //                               0,
//                                                     //                           format:
//                                                     //                               CountDownTimerFormat.hoursMinutesSeconds,
//                                                     //                           endTime:
//                                                     //                               DateTime.now().add(
//                                                     //                             Duration(
//                                                     //                               minutes: 27,
//                                                     //                               seconds: 34,
//                                                     //                             ),
//                                                     //                           ),
//                                                     //                           onEnd:
//                                                     //                               () {
//                                                     //                             print("Timer finished");
//                                                     //                           },
//                                                     //                         ),
//                                                     //                       ],
//                                                     //                     )
//                                                     //                   ],
//                                                     //                 )
//                                                     //               ],
//                                                     //             ),
//                                                     //             // decoration: BoxDecoration(
//                                                     //             // image: DecorationImage(
//                                                     //             // image: NetworkImage('https://media.istockphoto.com/photos/freedom-chains-that-transform-into-birds-charge-concept-picture-id1322104312?b=1&k=20&m=1322104312&s=170667a&w=0&h=VQyPkFkMKmo0e4ixjhiOLjiRs_ZiyKR_4SAsagQQdkk='),
//                                                     //             // fit: BoxFit.cover))
//                                                     //           ));
//                                                     //     });
//                                                     setState(() {
//                                                       appointmentController
//                                                               .chipList.value =
//                                                           appointmentController
//                                                               .availableAppointments[
//                                                                   index]
//                                                               .schedule!
//                                                               .slots!;
//                                                       appointmentController
//                                                               .selectedApp
//                                                               .value =
//                                                           appointmentController
//                                                                   .availableAppointments[
//                                                               index];
//                                                     });
//                                                   },
//                                                   child: Text(
//                                                     "Check Slots",
//                                                     overflow:
//                                                         TextOverflow.ellipsis,
//                                                     style: GoogleFonts.inter(
//                                                         fontSize: 15.sp,
//                                                         fontStyle:
//                                                             FontStyle.normal,
//                                                         fontWeight:
//                                                             FontWeight.w500,
//                                                         color: Colors.white),
//                                                   ),
//                                                   style: ElevatedButton.styleFrom(
//                                                       fixedSize: Size(
//                                                           130.w, 30.h),
//                                                       primary: fButtonColor,
//                                                       shape:
//                                                           RoundedRectangleBorder(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           20)))),
//                                               ElevatedButton(
//                                                   onPressed: () {},
//                                                   child: Text(
//                                                     "Cancel",
//                                                     overflow:
//                                                         TextOverflow.ellipsis,
//                                                     style: GoogleFonts.inter(
//                                                         fontSize: 15.sp,
//                                                         fontStyle:
//                                                             FontStyle.normal,
//                                                         fontWeight:
//                                                             FontWeight.w500,
//                                                         color: Colors.white),
//                                                   ),
//                                                   style: ElevatedButton.styleFrom(
//                                                       fixedSize: Size(
//                                                           130.w, 30.h),
//                                                       primary: fButtonColor,
//                                                       shape:
//                                                           RoundedRectangleBorder(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           20)))),
//                                             ],
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           height: 30.h,
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             }),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           decoration: new BoxDecoration(
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.3),
//                                   spreadRadius: 2,
//                                   blurRadius: 10,
//                                   offset: Offset(
//                                       0, 3), // changes position of shadow
//                                 ),
//                               ],
//                               color: Colors
//                                   .white, //new Color.fromRGBO(255, 0, 0, 0.0),
//                               borderRadius: new BorderRadius.all(
//                                 Radius.circular(5),
//                               )),
//                           height: MediaQuery.of(context).size.height * 0.57,
//                           width: width * 0.36,
//                           child: Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child: TableCalendar(
//                               //onDayLongPressed: _DaySelected,
//                               onPageChanged: (focusedDay) {
//                                 _focusedDay = focusedDay;
//                               },
//                               selectedDayPredicate: (day) =>
//                                   isSameDay(_selectedDay, day),
//                               onRangeSelected: _onRangeSelected,
//                               onDaySelected: _onDaySelected,
//                               calendarStyle: CalendarStyle(
//                                 selectedDecoration: BoxDecoration(
//                                     color: Colors.red, shape: BoxShape.circle),
//                                 rangeHighlightColor: Colors.red,
//                               ),
//                               pageJumpingEnabled: true,
//                               daysOfWeekHeight: 25.h,
//                               rowHeight: 60.h,
//                               pageAnimationEnabled: true,
//                               daysOfWeekVisible: true,
//                               headerStyle: HeaderStyle(
//                                   formatButtonVisible: false,
//                                   titleCentered: true,
//                                   titleTextStyle: TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w700),
//                                   rightChevronIcon: CircleAvatar(
//                                     backgroundColor: Colors.red,
//                                     child: Icon(Icons.chevron_right),
//                                   ),
//                                   leftChevronIcon: CircleAvatar(
//                                     backgroundColor: Colors.red,
//                                     child: Icon(Icons.chevron_left),
//                                   )),
//                               firstDay: DateTime.utc(2010, 10, 16),
//                               lastDay: DateTime.utc(2030, 3, 14),
//                               availableGestures:
//                                   AvailableGestures.horizontalSwipe,
//                               headerVisible: true,
//                               focusedDay: _focusedDay,
//                             ),
//                             // TableCalendar(onDayLongPressed:
//                             // ,
//                             //   selectedDayPredicate: (day) {
//                             //     return isSameDay(selectedDay, day);
//                             //   },
//                             //   onDaySelected: (selectedDay, focusedDay) {
//                             //     setState(() {
//                             //       selectedDay = selectedDay;
//                             //       focusedDay =
//                             //           focusedDay; // update `_focusedDay` here as well
//                             //     });
//                             //   },
//                             //   calendarStyle: CalendarStyle(
//                             //       selectedDecoration: BoxDecoration(
//                             //         color: Colors.red,
//                             //       ),
//                             //       rangeHighlightColor: Colors.red,
//                             //       markerDecoration: BoxDecoration(
//                             //         color: Colors.red,
//                             //       )),
//                             //   pageJumpingEnabled: true,
//                             //   daysOfWeekHeight: 25.h,
//                             //   rowHeight: 60.h,
//                             //   pageAnimationEnabled: true,
//                             //   daysOfWeekVisible: true,
//                             //   headerStyle: HeaderStyle(
//                             //       formatButtonVisible: false,
//                             //       titleCentered: true,
//                             //       titleTextStyle: TextStyle(
//                             //           color: Colors.black,
//                             //           fontWeight: FontWeight.w700),
//                             //       rightChevronIcon: CircleAvatar(
//                             //         backgroundColor: Colors.red,
//                             //         child: Icon(Icons.chevron_right),
//                             //       ),
//                             //       leftChevronIcon: CircleAvatar(
//                             //         backgroundColor: Colors.red,
//                             //         child: Icon(Icons.chevron_left),
//                             //       )),
//                             //   firstDay: DateTime.utc(2010, 10, 16),
//                             //   lastDay: DateTime.utc(2030, 3, 14),
//                             //   availableGestures:
//                             //       AvailableGestures.horizontalSwipe,
//                             //   headerVisible: true,
//                             //   focusedDay: DateTime.now(),
//                             // ),
//                           ),
//                         ),
//                         //second row choice chip
//                         Container(
//                           decoration: new BoxDecoration(
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.3),
//                                   spreadRadius: 2,
//                                   blurRadius: 10,
//                                   offset: Offset(
//                                       0, 3), // changes position of shadow
//                                 ),
//                               ],
//                               color: Colors.white,
//                               borderRadius: new BorderRadius.all(
//                                 Radius.circular(5),
//                               )),
//                           height: MediaQuery.of(context).size.height * 0.57,
//                           width: width * 0.36,
//                           child: SingleChildScrollView(
//                             child: Column(
//                               children: [
//                                 Padding(
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 30),
//                                   child: Text(
//                                     "Select Time Slot",
//                                     style: TextStyle(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.w700),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 30.h,
//                                 ),
//                                 Container(
//                                     child: Wrap(
//                                   //spacing: 5.0.sp,
//                                   //runSpacing: 15.0.sp,
//                                   children: <Widget>[
//                                     choiceChipWidget(
//                                         appointmentController.chipList),
//                                   ],
//                                 )),
//                               ],
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     Padding(
//                         padding: EdgeInsets.only(bottom: 10.h),
//                         child: CircularButtons(
//                             backgroundColor: const Color(0xfffc6359),
//                             borderColor: const Color(0xfffc6359),
//                             text: "Set Appointment",
//                             height: 50,
//                             textColor: Colors.white,
//                             textStyle: WhiteText,
//                             width: width * 0.3,
//                             onPressed: () {
//                               showDialog(
//                                   context: context,
//                                   builder: (BuildContext context) {
//                                     return AlertDialog(
//                                         shape: RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.all(
//                                                 Radius.circular(20.0))),
//                                         backgroundColor: Colors.white,
//                                         content: Container(
//                                           height: 200,
//                                           width: 400,
//                                           child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceAround,
//                                             children: [
//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 children: [
//                                                   Text(
//                                                     'Do you want to book this time slot',
//                                                     style: TextStyle(
//                                                         color: fButtonColor,
//                                                         fontSize: 25,
//                                                         fontWeight:
//                                                             FontWeight.bold),
//                                                   ),
//                                                 ],
//                                               ),
//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceEvenly,
//                                                 children: [
//                                                   CircularButtons(
//                                                     backgroundColor:
//                                                         const Color(0xff4F8484),
//                                                     borderColor:
//                                                         const Color(0xff4F8484),
//                                                     text: "Yes",
//                                                     height: 50,
//                                                     width: width * 0.1,
//                                                     textColor: Colors.white,
//                                                     textStyle: WhiteText,
//                                                     onPressed: () {
//                                                       final bookedAppointmentController =
//                                                           Get.find<
//                                                               BookedAppointmentController>();
//
//                                                       if (bookedAppointmentController
//                                                           .myAppointments
//                                                           .isEmpty) {
//                                                         appointmentController
//                                                             .createRequestInDatabase();
//                                                       } else {
//                                                         // CHECKING IF THE SLOT IS ALREADY IN OUR LIST
//
//                                                         // for (var element in bookedAppointmentController.myAppointments) {
//                                                         //   if(element.schedule!.slots!.length == appointmentController.selectedApp.value.schedule!.slots!.length){
//                                                         //     for (var slot in element.schedule!.slots!){
//                                                         //       if(slot.startSlot == appointmentController.selectedChoice.value.startSlot && slot.endSlot == appointmentController.selectedChoice.value.endSlot){
//                                                         //         print("SLOT ALREADY EXISTS");
//                                                         //       }else{
//                                                         //
//                                                         //       }
//                                                         //     }
//                                                         //   }else{
//                                                         //     print("DOES NOT EXISTS");
//                                                         //   }
//                                                         // }
//
//                                                         for (var element
//                                                             in bookedAppointmentController
//                                                                 .myAppointments) {
//                                                           if (element.docId ==
//                                                               appointmentController
//                                                                   .selectedApp
//                                                                   .value
//                                                                   .uid) {
//                                                             appointmentController
//                                                                 .updateRequestInDatabase(
//                                                                     element
//                                                                         .reqId!);
//                                                             break;
//                                                           } else {
//                                                             appointmentController
//                                                                 .createRequestInDatabase();
//                                                             break;
//                                                           }
//                                                         }
//                                                       }
//                                                       print(
//                                                           appointmentController
//                                                               .selectedApp
//                                                               .value
//                                                               .uid);
//                                                       // FirebaseFirestore.instance
//                                                       //     .collection(
//                                                       //     'available-appointments')
//                                                       //     .doc(
//                                                       //     appointmentController
//                                                       //         .selectedApp
//                                                       //         .value
//                                                       //         .uid)
//                                                       //     .get()
//                                                       //     .then((value) {
//                                                       //   if (value.exists) {
//                                                       //     appointmentController
//                                                       //         .createRequestInDatabase();
//                                                       //     print(value.exists);
//                                                       //   } else {
//                                                       //     print(value.exists);
//                                                       //     appointmentController
//                                                       //         .updateRequestInDatabase(
//                                                       //         appointmentController
//                                                       //             .selectedApp
//                                                       //             .value
//                                                       //             .uid!);
//                                                       //   }
//                                                       // });
//
//                                                       Navigator.pop(context);
//                                                     },
//                                                   ),
//                                                   CircularButtons(
//                                                     backgroundColor:
//                                                         const Color(0xfffc6359),
//                                                     borderColor:
//                                                         const Color(0xfffc6359),
//                                                     text: "No",
//                                                     height: 50,
//                                                     width: width * 0.1,
//                                                     textColor: Colors.white,
//                                                     textStyle: WhiteText,
//                                                     onPressed: () {
//                                                       Navigator.pop(context);
//                                                     },
//                                                   ),
//                                                 ],
//                                               )
//                                             ],
//                                           ),
//                                         ));
//                                   });
//                             }))
//                   ],
//                 ),
//               ),
//             )));
//   }
//
//   @override
//   bool get wantKeepAlive => true;
// }
//
// class choiceChipWidget extends StatefulWidget {
//   final List<Slots> reportList;
//
//   choiceChipWidget(this.reportList);
//
//   @override
//   _choiceChipWidgetState createState() => _choiceChipWidgetState();
// }
//
// class _choiceChipWidgetState extends State<choiceChipWidget> {
//   final appointmentController = Get.find<AppointmentController>();
//
//   _buildChoiceList() {
//     List<Widget> choices = [];
//     widget.reportList.forEach((item) {
//       choices.add(Container(
//         padding: EdgeInsets.symmetric(vertical: 20.h),
//         child: FilterChip(
//           showCheckmark: false,
//           //inside chip padding
//           labelPadding: EdgeInsets.symmetric(horizontal: 150.w, vertical: 15.h),
//           padding: EdgeInsets.symmetric(horizontal: 35.h),
//           label: SingleChildScrollView(
//               child: Text("${item.startSlot} to ${item.endSlot}")),
//           labelStyle: TextStyle(
//               color: Color(0xff3A3A3A),
//               fontSize: 20.0,
//               fontWeight: FontWeight.w600),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15.0),
//           ),
//           backgroundColor: Color(0xffC4C4C4),
//           selectedColor: Colors.red,
//           selected: appointmentController.selectedChoice.value == item,
//           onSelected: (selected) {
//             setState(() {
//               appointmentController.selectedChoice.value = item;
//
//               //selected == true;
//             });
//           },
//         ),
//       ));
//     });
//     return choices;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       children: _buildChoiceList(),
//     );
//   }
// }
