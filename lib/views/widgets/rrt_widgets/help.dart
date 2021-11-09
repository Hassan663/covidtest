import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  const Help({ Key? key }) : super(key: key);

  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("data"),
      
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:rrt_client_web_app/constants/rrt_sizes.dart';
// import 'package:rrt_client_web_app/controllers/help/help_controller.dart';
// import 'package:rrt_client_web_app/views/widgets/rrt_widgets/header.dart';
// import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
// import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
// import 'package:rrt_client_web_app/widget/commontextfield.dart';

// class Help extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     double width=MediaQuery.of(context).size.width;
//     return SafeArea(
//         child: Scaffold(
//           backgroundColor: Color(0xffE5E5E5) ,
//           body: Column(
//             children: [
//               Padding(
//                 padding:  EdgeInsets.all(25.0),
//                 child: Header(),
//               ),
//               Container(
//                   height: MediaQuery.of(context).size.height*0.75,
//                   width: MediaQuery.of(context).size.width,
//                   decoration: new BoxDecoration(
//                       color: Color(0xffE5E5E5), //new Color.fromRGBO(255, 0, 0, 0.0),
//                       borderRadius: new BorderRadius.only(
//                           topLeft: Radius.circular(circular_radius_homeContainers),
//                           bottomLeft:
//                               Radius.circular(circular_radius_homeContainers))),
//                   child: GetBuilder<HelpController>(
//                     init: HelpController(),
//                     builder: (_) {
//                       return _.isLoading
//                           ? Center(
//                               child: CircularProgressIndicator(),
//                             )
//                           : Row(
//                               children: [
//                                 Container(
//                                   color: Colors.transparent,
//                                   width: width * 0.5,
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     children: [
//                                       Container(
//                                         width: Get.width,
//                                         child: TextField(
//                                           controller: _.controller,
//                                           decoration:
//                                               InputDecoration(hintText: 'Channel ID'),
//                                           onChanged: (text) {
//                                             _.channelId = text;
//                                           },
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: 30.0,
//                                       ),
//                                       Container(
//                                         width: Get.width,
//                                         child: Row(
//                                           children: [
//                                             Expanded(
//                                               flex: 1,
//                                               child: ElevatedButton(
//                                                 onPressed: _.isJoined
//                                                     ? _.leaveChannel
//                                                     : _.joinChannel,
//                                                 child: Text(
//                                                     '${_.isJoined ? 'Leave' : 'Join'} channel'),
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                       renderVideo(_),
//                                       SizedBox(
//                                         height: 30.0,
//                                       ),
//                                       Expanded(
                                        
//                                         child: Container(
//                                           color: Colors.black,
//                                           child: Align(
//                                             alignment: Alignment.bottomRight,
//                                             child: Column(
//                                               mainAxisSize: MainAxisSize.min,
//                                               children: [
//                                                 ElevatedButton(
//                                                   onPressed: _.switchCameras,
//                                                   child: Text(
//                                                       'Camera ${_.switchCamera ? 'front' : 'rear'}'),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   width: width *0.25,
//                                   child: Column(
//                                     children: [
//                                       Expanded(
//                                         child: messages(_),
//                                       ),
//                                       sendmessage(_),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             );
//                     },
//                   )),
//             ],
//           ),
//         ));
//   }
//   Widget messages(HelpController _) {
//     return _.messagelist.length == 0
//         ? SizedBox()
//         : ListView.builder(
//             itemCount: _.messagelist.length,
//             reverse: true,
//             itemBuilder: (ctx, index) {
//               return Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: _.firebaseAuth.currentUser!.uid ==
//                             _.messagelist[index]['senderid']
//                         ? MainAxisAlignment.end
//                         : MainAxisAlignment.start,
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                           color: _.firebaseAuth.currentUser!.uid !=
//                                   _.messagelist[index]['senderid']
//                               ? Colors.grey[200]
//                               : Colors.lightBlue[600],
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(12),
//                             topRight: Radius.circular(12),
//                             bottomLeft: _.firebaseAuth.currentUser!.uid !=
//                                     _.messagelist[index]['senderid']
//                                 ? Radius.circular(0)
//                                 : Radius.circular(12),
//                             bottomRight: _.firebaseAuth.currentUser!.uid !=
//                                     _.messagelist[index]['senderid']
//                                 ? Radius.circular(0)
//                                 : Radius.circular(12),
//                           ),
//                         ),
//                         width: 160,
//                         padding:
//                             EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//                         margin:
//                             EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//                         child: _.messagelist[index]['type'].toString() != "null"
//                             ? Column(
//                                 crossAxisAlignment:
//                                     _.firebaseAuth.currentUser!.uid ==
//                                             _.messagelist[index]['senderid']
//                                         ? CrossAxisAlignment.start
//                                         : CrossAxisAlignment.start,
//                                 children: [
//                                   _.messagelist[index]['type'].toString() ==
//                                           "text"
//                                       ? Text(
//                                           _.messagelist[index]['message'],
//                                           style: TextStyle(
//                                               color: _.firebaseAuth.currentUser!
//                                                           .uid ==
//                                                       _.messagelist[index]
//                                                           ['senderid']
//                                                   ? Colors.white
//                                                   : Colors.black),
//                                         )
//                                       : SizedBox()
//                                 ],
//                               )
//                             : SizedBox(),
//                       ),
//                     ],
//                   ),
//                 ],
//               );
//             },
//           );
//   }

//   Widget sendmessage(HelpController _) {
//     return Container(
//       child: Row(
//         children: [
//           // IconButton(
//           //   icon: Icon(Icons.add),
//           //   onPressed: () {
//           //     showAttachmentBox(_);
//           //   },
//           // ),
//           Expanded(
//               child: CommonTextField(
//             controller: _.message,
//             hintText: "Typing..........",
//             isTextHidden: false,
//             borderColor: Color(0xffF9F9F9),
//           )
//               // TextField(
//               //   controller: _.message,
//               //   decoration: InputDecoration(labelText: "Send a Message"),
//               // ),
//               ),
//           IconButton(
//               icon: Icon(Icons.send),
//               onPressed: () async {
//                 if (_.message.text.isEmpty) {
//                   print("Please Put SOme Text");
//                 } else {
//                   await _.sendmessage();
//                 }
//               })
//         ],
//       ),
//     ).marginOnly(top: 8.0).paddingAll(8.0);
//   }

//   renderVideo(HelpController _) {
//     return Expanded(
//       child: Stack(
//         children: [
//           RtcLocalView.SurfaceView(),
//           Align(
//             alignment: Alignment.topLeft,
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: List.of(_.remoteUid.map(
//                   (e) => GestureDetector(
//                     onTap: _.switchRenders,
//                     child: Container(
//                       width: 200,
//                       height: 120,
//                       child: RtcRemoteView.SurfaceView(
//                         uid: e,
//                         channelId: _.channelId,
//                       ),
//                     ),
//                   ),
//                 )),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
// // import 'package:flutter/material.dart';
// // import 'package:rrt_client_web_app/rrt_widgets/header.dart';
// // import 'package:rrt_client_web_app/rrt_widgets/rrt_sizes.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:rrt_client_web_app/rrt_widgets/textfield.dart';
// // import 'package:table_calendar/table_calendar.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:table_calendar/table_calendar.dart';
// // import 'dart:convert';
// // import 'package:flutter_responsive_screen/flutter_responsive_screen.dart';

// // class SetAvailability extends StatefulWidget {
// //   @override
// //   _SetAvailabilityState createState() => _SetAvailabilityState();
// // }

// // class _SetAvailabilityState extends State<SetAvailability> {
// //   @override
// //   Widget build(BuildContext context) {
// //     final Function wp = Screen(MediaQuery.of(context).size).wp;
// //     final Function hp = Screen(MediaQuery.of(context).size).hp;
// //     double width = MediaQuery.of(context).size.width;
// //     TextEditingController? availablefromController = TextEditingController();
// //     TextEditingController? availabletoController = TextEditingController();

// //     // List<String> chipList = [
// //     //   "11:00 to 11:16 AM",
// //     //   "11:00 to 11:7 AM",
// //     //   "11:00 to 11:1 AM",
// //     //   "11:00 to 11:5 AM",
// //     //   "11:00 to 11:25 AM",
// //     //   "11:00

// //     // DateTime? selectedDay;
// //     DateTime day = DateTime.now();
// //     DateTime? _selectedDay;
// //     DateTime? _focusedDay;

// //     return SafeArea(
// //         child: SingleChildScrollView(
// //       child: Container(
// //           height: MediaQuery.of(context).size.height,
// //           width: MediaQuery.of(context).size.width,
// //           decoration: new BoxDecoration(
// //               color: Color(0xffE5E5E5), //new Color.fromRGBO(255, 0, 0, 0.0),
// //               borderRadius: new BorderRadius.only(
// //                   topLeft: Radius.circular(circular_radius_homeContainers),
// //                   bottomLeft: Radius.circular(circular_radius_homeContainers))),
// //           child: Padding(
// //             padding: EdgeInsets.all(35.0.sp),
// //             child: Column(
// //               children: [
// //                 Header(),
// //                 SizedBox(
// //                   height: 35.h,
// //                 ),
// //                 Row(
// //                   children: [
// //                     Padding(
// //                       padding: EdgeInsets.only(right: 20.w),
// //                       child: Text(
// //                         'Calendar',
// //                         maxLines: 1,
// //                         style: TextStyle(
// //                             color: Color(0xff5FA4A4),
// //                             fontWeight: FontWeight.w700),
// //                       ),
// //                     ),
// //                     Expanded(
// //                         child: Divider(
// //                       color: Color(0xff5FA4A4),
// //                     )),
// //                   ],
// //                 ),
// //                 SizedBox(
// //                   height: 30,
// //                 ),
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     Container(
// //                       decoration: new BoxDecoration(
// //                           boxShadow: [
// //                             BoxShadow(
// //                               color: Colors.grey.withOpacity(0.3),
// //                               spreadRadius: 2,
// //                               blurRadius: 10,
// //                               offset:
// //                                   Offset(0, 3), // changes position of shadow
// //                             ),
// //                           ],
// //                           color: Colors
// //                               .white, //new Color.fromRGBO(255, 0, 0, 0.0),
// //                           borderRadius: new BorderRadius.all(
// //                             Radius.circular(5),
// //                           )),
// //                       height: MediaQuery.of(context).size.height * 0.57,
// //                       width: width * 0.36,
// //                       child: Padding(
// //                         padding: EdgeInsets.all(8.0),
// //                         child: TableCalendar(
// //                           selectedDayPredicate: (day) {
// //                             return isSameDay(_selectedDay, day);
// //                           },
// //                           onDaySelected: (selectedDay, focusedDay) {
// //                              focusedDay = selectedDay;
// //                               day = selectedDay;
// //                             setState(() {
// //                               // focusedDay = selectedDay;
// //                               // day = selectedDay;

// //                               // _selectedDay = selectedDay;
// //                               // // day = selectedDay;
// //                               // _focusedDay = focusedDay;
// //                               // day = selectedDay;
// //                               // focusedDay = day;
// //                               // update `_focusedDay` here as well
// //                             });
// //                           },
// //                           calendarStyle: CalendarStyle(
// //                               selectedDecoration: BoxDecoration(
// //                                 color: Colors.red,
// //                               ),
// //                               rangeHighlightColor: Colors.red,
// //                               markerDecoration: BoxDecoration(
// //                                 color: Colors.red,
// //                               )),
// //                           pageJumpingEnabled: true,
// //                           daysOfWeekHeight: 25.h,
// //                           rowHeight: 60.h,
// //                           pageAnimationEnabled: true,
// //                           daysOfWeekVisible: true,
// //                           headerStyle: HeaderStyle(
// //                               formatButtonVisible: false,
// //                               titleCentered: true,
// //                               titleTextStyle: TextStyle(
// //                                   color: Colors.black,
// //                                   fontWeight: FontWeight.w700),
// //                               rightChevronIcon: CircleAvatar(
// //                                 backgroundColor: Colors.red,
// //                                 child: Icon(Icons.chevron_right),
// //                               ),
// //                               leftChevronIcon: CircleAvatar(
// //                                 backgroundColor: Colors.red,
// //                                 child: Icon(Icons.chevron_left),
// //                               )),
// //                           firstDay: DateTime.utc(2010, 10, 16),
// //                           lastDay: DateTime.utc(2030, 3, 14),
// //                           availableGestures: AvailableGestures.horizontalSwipe,
// //                           headerVisible: true,
// //                           focusedDay: day,
// //                         ),
// //                       ),
// //                     ),
// //                     //second row choice chip
// //                     Container(
// //                       decoration: new BoxDecoration(
// //                           boxShadow: [
// //                             BoxShadow(
// //                               color: Colors.grey.withOpacity(0.3),
// //                               spreadRadius: 2,
// //                               blurRadius: 10,
// //                               offset:
// //                                   Offset(0, 3), // changes position of shadow
// //                             ),
// //                           ],
// //                           color: Colors.white,
// //                           borderRadius: new BorderRadius.all(
// //                             Radius.circular(5),
// //                           )),
// //                       height: MediaQuery.of(context).size.height * 0.57,
// //                       width: width * 0.36,
// //                       child: Padding(
// //                         padding: EdgeInsets.symmetric(
// //                             horizontal: 30.w, vertical: 30.h),
// //                         child: Column(
// //                           children: [
// //                             Text(
// //                               "Enter Your Availabilty Timings",
// //                               style: TextStyle(
// //                                   color: Colors.black,
// //                                   fontWeight: FontWeight.w700),
// //                             ),
// //                             SizedBox(
// //                               height: 30,
// //                             ),
// //                             Container(
// //                               decoration: new BoxDecoration(
// //                                   boxShadow: [
// //                                     BoxShadow(
// //                                       color: Colors.grey.withOpacity(0.3),
// //                                       spreadRadius: 2,
// //                                       blurRadius: 10,
// //                                       offset: Offset(
// //                                           0, 3), // changes position of shadow
// //                                     ),
// //                                   ],
// //                                   color: Colors.red,
// //                                   borderRadius: new BorderRadius.all(
// //                                     Radius.circular(5),
// //                                   )),
// //                               height: 250.h,
// //                               width: 250.h,
// //                               child: Column(
// //                                 children: [
// //                                   Text(day.toString()),
// //                                   Text("data")
// //                                 ],
// //                               ),
// //                             ),
// //                             SizedBox(
// //                               height: 30.h,
// //                             ),
// //                             Row(
// //                               mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                               children: [
// //                                 Flexible(
// //                                   child: Container(
// //                                     width: 200.w,
// //                                     child: textformfield1(
// //                                       availablefromController,
// //                                       "Available From",
// //                                       "From",
// //                                       false,
// //                                       TextInputType.name,
// //                                     ),
// //                                   ),
// //                                 ),
// //                                 Text(
// //                                   "To",
// //                                   style: TextStyle(
// //                                       color: Colors.red,
// //                                       fontWeight: FontWeight.w700),
// //                                 ),
// //                                 Flexible(
// //                                   child: Container(
// //                                     width: 200.w,
// //                                     child: textformfield1(
// //                                       availablefromController,
// //                                       "Available To",
// //                                       "To",
// //                                       false,
// //                                       TextInputType.name,
// //                                     ),
// //                                   ),
// //                                 )
// //                               ],
// //                             )
// //                           ],
// //                         ),
// //                       ),
// //                     )
// //                   ],
// //                 )
// //               ],
// //             ),
// //           )),
// //     ));
// //   }
// // }

// // class choiceChipWidget extends StatefulWidget {
// //   final List<String> reportList;

// //   choiceChipWidget(this.reportList);

// //   @override
// //   _choiceChipWidgetState createState() => new _choiceChipWidgetState();
// // }

// // class _choiceChipWidgetState extends State<choiceChipWidget> {
// //   String selectedChoice = "";

// //   _buildChoiceList() {
// //     List<Widget> choices = [];
// //     widget.reportList.forEach((item) {
// //       choices.add(Container(
// //         padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
// //         child: FilterChip(
// //           showCheckmark: false,
// //           //inside chip padding
// //           labelPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
// //           padding: EdgeInsets.symmetric(horizontal: 32.w),
// //           label: SingleChildScrollView(child: Text(item)),
// //           labelStyle: TextStyle(
// //               color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold),
// //           shape: RoundedRectangleBorder(
// //             borderRadius: BorderRadius.circular(30.0),
// //           ),
// //           backgroundColor: Color(0xffC4C4C4),
// //           selectedColor: Colors.red,
// //           selected: selectedChoice == item,
// //           onSelected: (selected) {
// //             setState(() {
// //               //selected == true;
// //               selectedChoice = item;
// //             });
// //           },
// //         ),
// //       ));
// //     });
// //     return choices;
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Wrap(
// //       children: _buildChoiceList(),
// //     );
// //   }
// // }
// // class choiceChipWidget extends StatefulWidget {
// //   final List<String> reportList;

// //   choiceChipWidget(this.reportList);

// //   @override
// //   _choiceChipWidgetState createState() => new _choiceChipWidgetState();
// // }

// // class _choiceChipWidgetState extends State<choiceChipWidget> {
// //   String selectedChoice = "";

// //   _buildChoiceList() {
// //     List<Widget> choices = [];
// //     widget.reportList.forEach((item) {
// //       choices.add(Container(
// //         padding: const EdgeInsets.all(2.0),
// //         child: ChoiceChip(
// //           label: Text(item),
// //           labelStyle: TextStyle(
// //               color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
// //           shape: RoundedRectangleBorder(
// //             borderRadius: BorderRadius.circular(30.0),
// //           ),
// //           backgroundColor: Color(0xffededed),
// //           selectedColor: Color(0xffffc107),
// //           selected: selectedChoice == item,
// //           onSelected: (selected) {
// //             setState(() {
// //               selectedChoice = item;
// //             });
// //           },
// //         ),
// //       ));
// //     });
// //     return choices;
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Wrap(
// //       children: _buildChoiceList(),
// //     );
// //   }
// // }

