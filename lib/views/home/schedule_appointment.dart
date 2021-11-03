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
import 'package:rrt_client_web_app/models/appointment/slots.dart';
import 'package:rrt_client_web_app/views/widgets/rrt_widgets/button.dart';
import 'package:rrt_client_web_app/views/widgets/rrt_widgets/cache.dart';
import 'package:rrt_client_web_app/views/widgets/rrt_widgets/header.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert';

class ScheduleAppointment extends StatefulWidget {
  @override
  _ScheduleAppointmentState createState() => _ScheduleAppointmentState();
}

class _ScheduleAppointmentState extends State<ScheduleAppointment>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final appointmentController = Get.find<AppointmentController>();

    double width = MediaQuery.of(context).size.width;

    DateTime? selectedDay;
    return SafeArea(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Color(0xffE5E5E5), //new Color.fromRGBO(255, 0, 0, 0.0),
                borderRadius: new BorderRadius.only(
                    topLeft: Radius.circular(circular_radius_homeContainers),
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
                    Container(
                      height: MediaQuery.of(context).size.height * 0.30,
                      width: MediaQuery.of(context).size.width,
                      child: Obx(
                        () => GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,

                                    //childAspectRatio: 3.w / 3.h,
                                    crossAxisSpacing: 20.w,
                                    mainAxisSpacing: 10.h),
                            itemCount: appointmentController
                                .availableAppointments.length,
                            itemBuilder: (BuildContext ctx, index) {
                              DateTime date =
                                  DateTime.fromMillisecondsSinceEpoch(
                                      appointmentController
                                              .availableAppointments[index]
                                              .schedule!
                                              .date!
                                              .seconds *
                                          1000);
                              return Padding(
                                padding: EdgeInsets.all(8.0.sp),
                                child: SingleChildScrollView(
                                  child: Container(
                                    //height: 100.0.h,
                                    // margin: EdgeInsets.only(top: 18, right: 14, left: 14),
                                    decoration: BoxDecoration(
                                        color: fLabelTextColor,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(15.0.sp),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 15.h),
                                                child: Container(
                                                  width: 150,
                                                  child: Text(
                                                    "Nurse: ${appointmentController.availableAppointments[index].nurseId}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    softWrap: true,
                                                    maxLines: 2,
                                                    style: GoogleFonts.inter(
                                                        fontSize: 20.sp,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              // Image.asset("assets/video.png"),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 10.w,
                                              right: 10.w,
                                              top: 20.h),
                                          height: 60.h,
                                          decoration: BoxDecoration(
                                              color: fContainerColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                  height: 25.h,
                                                  width: 25.w,
                                                  child: Image.asset(
                                                      "assets/datetime.png")),
                                              Container(
                                                width: 150,
                                                child: Text(
                                                  "${date.day}-${date.month}-${date.year}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.inter(
                                                      fontSize: 15.sp,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 10.w,
                                              right: 10.w,
                                              top: 30.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    // showDialog(
                                                    //     context: context,
                                                    //     builder: (BuildContext
                                                    //         context) {
                                                    //       return AlertDialog(
                                                    //           shape: RoundedRectangleBorder(
                                                    //               borderRadius: BorderRadius
                                                    //                   .all(Radius
                                                    //                       .circular(
                                                    //                           20.0))),
                                                    //           backgroundColor:
                                                    //               Colors.white,
                                                    //           content: Container(
                                                    //             height: 300,
                                                    //             width: 500,
                                                    //             child: Column(
                                                    //               mainAxisAlignment:
                                                    //                   MainAxisAlignment
                                                    //                       .spaceAround,
                                                    //               children: [
                                                    //                 Row(
                                                    //                   mainAxisAlignment:
                                                    //                       MainAxisAlignment
                                                    //                           .center,
                                                    //                   children: [
                                                    //                     Text(
                                                    //                       'Countdown Started',
                                                    //                       style: TextStyle(
                                                    //                           color:
                                                    //                               fButtonColor,
                                                    //                           fontSize:
                                                    //                               25,
                                                    //                           fontWeight:
                                                    //                               FontWeight.bold),
                                                    //                     ),
                                                    //                   ],
                                                    //                 ),
                                                    //                 Row(
                                                    //                   mainAxisAlignment:
                                                    //                       MainAxisAlignment
                                                    //                           .spaceAround,
                                                    //                   children: [
                                                    //                     Container(
                                                    //                       height:
                                                    //                           170.0,
                                                    //                       width:
                                                    //                           270,
                                                    //                       // margin: EdgeInsets.only(top: 18, right: 14, left: 14),
                                                    //                       decoration: BoxDecoration(
                                                    //                           color:
                                                    //                               fLabelTextColor,
                                                    //                           borderRadius:
                                                    //                               BorderRadius.circular(15)),
                                                    //                       child:
                                                    //                           Column(
                                                    //                         children: [
                                                    //                           Padding(
                                                    //                             padding: const EdgeInsets.all(15.0),
                                                    //                             child: Row(
                                                    //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    //                               children: [
                                                    //                                 Text(
                                                    //                                   "Appointment $index",
                                                    //                                   style: GoogleFonts.inter(fontSize: 20, fontStyle: FontStyle.normal, fontWeight: FontWeight.w600, color: Colors.white),
                                                    //                                 ),
                                                    //                                 // Image.asset("assets/video.png"),
                                                    //                               ],
                                                    //                             ),
                                                    //                           ),
                                                    //                           Container(
                                                    //                             margin: EdgeInsets.only(left: 10, right: 10),
                                                    //                             height: 60,
                                                    //                             decoration: BoxDecoration(color: fContainerColor, borderRadius: BorderRadius.circular(10)),
                                                    //                             child: Padding(
                                                    //                               padding: const EdgeInsets.all(10.0),
                                                    //                               child: Row(
                                                    //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    //                                 children: [
                                                    //                                   Image.asset("assets/datetime.png"),
                                                    //                                   Text(
                                                    //                                     "Fri, May 23, 10:00 am - 11:00 am",
                                                    //                                     style: GoogleFonts.inter(fontSize: 12, fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: Colors.white),
                                                    //                                   )
                                                    //                                 ],
                                                    //                               ),
                                                    //                             ),
                                                    //                           ),
                                                    //                           Padding(
                                                    //                             padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                                                    //                             child: Row(
                                                    //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    //                               children: [
                                                    //                                 ElevatedButton(
                                                    //                                     onPressed: () {},
                                                    //                                     child: Text(
                                                    //                                       "Start Soon",
                                                    //                                       style: GoogleFonts.inter(fontSize: 15.sp, fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: Colors.white),
                                                    //                                     ),
                                                    //                                     style: ElevatedButton.styleFrom(fixedSize: Size(110, 30), primary: Colors.orangeAccent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
                                                    //                                 ElevatedButton(
                                                    //                                     onPressed: () {
                                                    //                                       Navigator.of(context).pop();
                                                    //                                     },
                                                    //                                     child: Text(
                                                    //                                       "Cancel",
                                                    //                                       style: GoogleFonts.inter(fontSize: 15.sp, fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: Colors.white),
                                                    //                                     ),
                                                    //                                     style: ElevatedButton.styleFrom(fixedSize: Size(110, 30), primary: fButtonColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
                                                    //                               ],
                                                    //                             ),
                                                    //                           )
                                                    //                         ],
                                                    //                       ),
                                                    //                     ),
                                                    //                     Column(
                                                    //                       children: [
                                                    //                         Icon(
                                                    //                             Icons.timer,
                                                    //                             size: 60,
                                                    //                             color: Colors.red),
                                                    //                         TimerCountdown(
                                                    //                           enableDescriptions:
                                                    //                               false,
                                                    //                           timeTextStyle:
                                                    //                               TextStyle(fontSize: 35, fontWeight: FontWeight.w900),
                                                    //                           colonsTextStyle:
                                                    //                               TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                    //                           spacerWidth:
                                                    //                               0,
                                                    //                           format:
                                                    //                               CountDownTimerFormat.hoursMinutesSeconds,
                                                    //                           endTime:
                                                    //                               DateTime.now().add(
                                                    //                             Duration(
                                                    //                               minutes: 27,
                                                    //                               seconds: 34,
                                                    //                             ),
                                                    //                           ),
                                                    //                           onEnd:
                                                    //                               () {
                                                    //                             print("Timer finished");
                                                    //                           },
                                                    //                         ),
                                                    //                       ],
                                                    //                     )
                                                    //                   ],
                                                    //                 )
                                                    //               ],
                                                    //             ),
                                                    //             // decoration: BoxDecoration(
                                                    //             // image: DecorationImage(
                                                    //             // image: NetworkImage('https://media.istockphoto.com/photos/freedom-chains-that-transform-into-birds-charge-concept-picture-id1322104312?b=1&k=20&m=1322104312&s=170667a&w=0&h=VQyPkFkMKmo0e4ixjhiOLjiRs_ZiyKR_4SAsagQQdkk='),
                                                    //             // fit: BoxFit.cover))
                                                    //           ));
                                                    //     });
                                                    print(appointmentController
                                                        .availableAppointments[
                                                            index]
                                                        .schedule
                                                        ?.slots!
                                                        .toList());
                                                    setState(() {
                                                      appointmentController
                                                              .chipList.value =
                                                          appointmentController
                                                              .availableAppointments[
                                                                  index]
                                                              .schedule!
                                                              .slots!;
                                                      appointmentController
                                                              .selectedApp
                                                              .value =
                                                          appointmentController
                                                                  .availableAppointments[
                                                              index];
                                                    });

                                                    print(appointmentController
                                                        .chipList.length);
                                                  },
                                                  child: Text(
                                                    "Check Slots",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.inter(
                                                        fontSize: 15.sp,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white),
                                                  ),
                                                  style: ElevatedButton.styleFrom(
                                                      fixedSize: Size(
                                                          130.w, 30.h),
                                                      primary: fButtonColor,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)))),
                                              ElevatedButton(
                                                  onPressed: () {},
                                                  child: Text(
                                                    "Cancel",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.inter(
                                                        fontSize: 15.sp,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white),
                                                  ),
                                                  style: ElevatedButton.styleFrom(
                                                      fixedSize: Size(
                                                          130.w, 30.h),
                                                      primary: fButtonColor,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)))),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30.h,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
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
                          height: MediaQuery.of(context).size.height * 0.57,
                          width: width * 0.36,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TableCalendar(
                              selectedDayPredicate: (day) {
                                return isSameDay(selectedDay, day);
                              },
                              onDaySelected: (selectedDay, focusedDay) {
                                setState(() {
                                  selectedDay = selectedDay;
                                  focusedDay =
                                      focusedDay; // update `_focusedDay` here as well
                                });
                              },
                              calendarStyle: CalendarStyle(
                                  selectedDecoration: BoxDecoration(
                                    color: Colors.red,
                                  ),
                                  rangeHighlightColor: Colors.red,
                                  markerDecoration: BoxDecoration(
                                    color: Colors.red,
                                  )),
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
                                  )),
                              firstDay: DateTime.utc(2010, 10, 16),
                              lastDay: DateTime.utc(2030, 3, 14),
                              availableGestures:
                                  AvailableGestures.horizontalSwipe,
                              headerVisible: true,
                              focusedDay: DateTime.now(),
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
                          height: MediaQuery.of(context).size.height * 0.57,
                          width: width * 0.36,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 30),
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
                                Container(
                                    child: Wrap(
                                  //spacing: 5.0.sp,
                                  //runSpacing: 15.0.sp,
                                  children: <Widget>[
                                    choiceChipWidget(
                                        appointmentController.chipList),
                                  ],
                                )),
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
                            width: width * 0.3,
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
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Do you want to book this time slot',
                                                    style: TextStyle(
                                                        color: fButtonColor,
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold),
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
                                                        const Color(0xff4F8484),
                                                    borderColor:
                                                        const Color(0xff4F8484),
                                                    text: "Yes",
                                                    height: 50,
                                                    width: width * 0.1,
                                                    textColor: Colors.white,
                                                    textStyle: WhiteText,
                                                    onPressed: () {
                                                      appointmentController
                                                          .createRequestInDatabase();
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  CircularButtons(
                                                    backgroundColor:
                                                        const Color(0xfffc6359),
                                                    borderColor:
                                                        const Color(0xfffc6359),
                                                    text: "No",
                                                    height: 50,
                                                    width: width * 0.1,
                                                    textColor: Colors.white,
                                                    textStyle: WhiteText,
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ));
                                  });
                            }))
                  ],
                ),
              ),
            )));
  }

  @override
  bool get wantKeepAlive => true;
}

class choiceChipWidget extends StatefulWidget {
  final List<Slots> reportList;

  choiceChipWidget(this.reportList);

  @override
  _choiceChipWidgetState createState() => _choiceChipWidgetState();
}

class _choiceChipWidgetState extends State<choiceChipWidget> {
  final appointmentController = Get.find<AppointmentController>();

  _buildChoiceList() {
    List<Widget> choices = [];
    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: FilterChip(
          showCheckmark: false,
          //inside chip padding
          labelPadding: EdgeInsets.symmetric(horizontal: 180.w, vertical: 15.h),
          padding: EdgeInsets.symmetric(horizontal: 35.h),
          label: SingleChildScrollView(
              child: Text("${item.startSlot} to ${item.endSlot}")),
          labelStyle: TextStyle(
              color: Color(0xff3A3A3A),
              fontSize: 20.0,
              fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          backgroundColor: Color(0xffC4C4C4),
          selectedColor: Colors.red,
          selected: appointmentController.selectedChoice.value == item,
          onSelected: (selected) {
            setState(() {
              appointmentController.selectedChoice.value = item;

              //selected == true;
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
