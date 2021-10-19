import 'package:flutter/material.dart';
import 'package:rrt_client_web_app/rrt_widgets/header.dart';
import 'package:rrt_client_web_app/rrt_widgets/rrt_sizes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert';

class ScheduleAppointment extends StatefulWidget {
  @override
  _ScheduleAppointmentState createState() => _ScheduleAppointmentState();
}

class _ScheduleAppointmentState extends State<ScheduleAppointment> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    List<String> chipList = [
      "11:00 to 11:15 AM",
      "11:00 to 11:15 AM",
      "11:00 to 11:15 AM",
      "11:00 to 11:15 AM",
      "11:00 to 11:15 AM",
      "11:00 to 11:15 AM"
    ];

    return SafeArea(
        child: SingleChildScrollView(
      child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: new BoxDecoration(
              color: Color(0xffE5E5E5), //new Color.fromRGBO(255, 0, 0, 0.0),
              borderRadius: new BorderRadius.only(
                  topLeft: Radius.circular(circular_radius_homeContainers),
                  bottomLeft: Radius.circular(circular_radius_homeContainers))),
          child: Padding(
            padding: EdgeInsets.all(35.0.sp),
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
                              offset:
                                  Offset(0, 3), // changes position of shadow
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
                          focusedDay: DateTime.now(),
                          availableGestures: AvailableGestures.horizontalSwipe,
                          headerVisible: true,
                        ),
                      ),
                    ),
                    //second row choice chip
                    SingleChildScrollView(
                      child: Container(
                        decoration: new BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: new BorderRadius.all(
                              Radius.circular(5),
                            )),
                        height: MediaQuery.of(context).size.height * 0.57,
                        width: width * 0.36,
                        child: Padding(
                          padding: EdgeInsets.all(30.0.sp),
                          child: Column(
                            children: [
                              Text(
                                "Select Time Slot",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0.sp),
                                child: Container(
                                    child: Wrap(
                                  spacing: 5.0.sp,
                                  runSpacing: 5.0.sp,
                                  children: <Widget>[
                                    choiceChipWidget(chipList),
                                  ],
                                )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )),
    ));
  }
}

class choiceChipWidget extends StatefulWidget {
  final List<String> reportList;

  choiceChipWidget(this.reportList);

  @override
  _choiceChipWidgetState createState() => new _choiceChipWidgetState();
}

class _choiceChipWidgetState extends State<choiceChipWidget> {
  String selectedChoice = "";

  _buildChoiceList() {
    List<Widget> choices = [];
    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: EdgeInsets.all(30.0.sp),
        child: ChoiceChip(
          labelPadding: EdgeInsets.all(15.sp),
          //padding: EdgeInsets.all(20.sp),
          label: Text(item),

          labelStyle: TextStyle(
              color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          backgroundColor: Color(0xffC4C4C4),
          selectedColor: Colors.red,
          selected: selectedChoice == item,
          onSelected: (selected) {
            setState(() {
              selected == true;
              selectedChoice = item;
              if (selected) {
                TextStyle(
                    color: Colors.white,
                    fontSize: 16.0.sp,
                    fontWeight: FontWeight.bold);
              }
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
