import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rrt_client_web_app/constants/rrt_colors.dart';
import 'package:rrt_client_web_app/constants/rrt_sizes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rrt_client_web_app/controllers/appointment/booked_appointments/booked_appointment.dart';
import 'package:rrt_client_web_app/controllers/homeDashboard/homeDashboard_controller.dart';
import 'package:rrt_client_web_app/models/appointment/booked_appointments/booked_appointment_model.dart';

import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:rrt_client_web_app/controllers/help/help_controller.dart';
import 'package:rrt_client_web_app/widget/commontextfield.dart';
import 'button.dart';
import 'header.dart';

class HomeDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeDashboardController>(
      init: HomeDashboardController(),
      builder: (_) {
        return SafeArea(
            child: _.isSelected
                ? buildContainerDashBord(context, _)
                : buildVideoCall(context));
      },
    );
  }

  Container buildVideoCall(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.85,
        width: MediaQuery.of(context).size.width,
        decoration: new BoxDecoration(
            color: Color(0xffE5E5E5), //new Color.fromRGBO(255, 0, 0, 0.0),
            borderRadius: new BorderRadius.only(
                topLeft: Radius.circular(circular_radius_homeContainers),
                bottomLeft: Radius.circular(circular_radius_homeContainers))),
        child: GetBuilder<HelpController>(
          init: HelpController(),
          builder: (_) {
            return _.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    child: Row(
                      children: [
                        Container(
                          color: fLabelTextColor,
                          width: Get.width / 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: Get.width,
                                child: Row(
                                  children: [],
                                ),
                              ),
                              renderVideo(_),
                              Container(
                                height: 150,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            child: IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.videocam_sharp,
                                                  color: Colors.white,
                                                )),
                                          ),
                                          Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            child: IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.mic_none,
                                                  color: Colors.white,
                                                )),
                                          ),
                                          Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            child: IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.chat,
                                                  color: Colors.white,
                                                )),
                                          ),
                                          Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            child: IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.more_vert,
                                                  color: Colors.white,
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircularButtons(
                                          backgroundColor:
                                              const Color(0xfffc6359),
                                          borderColor: const Color(0xfffc6359),
                                          text:
                                              '${_.isJoined ? 'Leave' : 'Join'} Session',
                                          height: 50,
                                          width: 150,
                                          onPressed: () {
                                            _.isJoined
                                                ? _.leaveChannel()
                                                : _.joinChannel();
                                          },
                                          textColor: Colors.white,
                                          textStyle: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(10)),
                          ),
                          width: Get.width / 4,
                          child: Column(
                            children: [
                              Expanded(
                                child: messages(_),
                              ),
                              sendmessage(_),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
          },
        ));
  }

  Widget messages(HelpController _) {
    return _.messagelist.length == 0
        ? SizedBox()
        : ListView.builder(
            itemCount: _.messagelist.length,
            reverse: true,
            itemBuilder: (ctx, index) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: _.firebaseAuth.currentUser!.uid ==
                            _.messagelist[index]['senderid']
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: _.firebaseAuth.currentUser!.uid !=
                                  _.messagelist[index]['senderid']
                              ? Colors.grey[200]
                              : Colors.lightBlue[600],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                            bottomLeft: _.firebaseAuth.currentUser!.uid !=
                                    _.messagelist[index]['senderid']
                                ? Radius.circular(0)
                                : Radius.circular(12),
                            bottomRight: _.firebaseAuth.currentUser!.uid !=
                                    _.messagelist[index]['senderid']
                                ? Radius.circular(0)
                                : Radius.circular(12),
                          ),
                        ),
                        width: 160,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        margin:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        child: _.messagelist[index]['type'].toString() != "null"
                            ? Column(
                                crossAxisAlignment:
                                    _.firebaseAuth.currentUser!.uid ==
                                            _.messagelist[index]['senderid']
                                        ? CrossAxisAlignment.start
                                        : CrossAxisAlignment.start,
                                children: [
                                  _.messagelist[index]['type'].toString() ==
                                          "text"
                                      ? Text(
                                          _.messagelist[index]['message'],
                                          style: TextStyle(
                                              color: _.firebaseAuth.currentUser!
                                                          .uid ==
                                                      _.messagelist[index]
                                                          ['senderid']
                                                  ? Colors.white
                                                  : Colors.black),
                                        )
                                      : SizedBox()
                                ],
                              )
                            : SizedBox(),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
  }

  Widget sendmessage(HelpController _) {
    return Container(
      child: Row(
        children: [
          // IconButton(
          //   icon: Icon(Icons.add),
          //   onPressed: () {
          //     showAttachmentBox(_);
          //   },
          // ),
          Expanded(
              child: CommonTextField(
            controller: _.message,
            hintText: "TyPe Here",
            isTextHidden: false,
            borderColor: Color(0xffF9F9F9),
          )
              // TextField(
              //   controller: _.message,
              //   decoration: InputDecoration(labelText: "Send a Message"),
              // ),
              ),
          IconButton(
              icon: Icon(Icons.send),
              onPressed: () async {
                if (_.message.text.isEmpty) {
                  print("Please Put SOme Text");
                } else {
                  await _.sendmessage();
                }
              })
        ],
      ),
    ).marginOnly(top: 8.0).paddingAll(8.0);
  }

  renderVideo(HelpController _) {
    return Expanded(
      child: Stack(
        children: [
          RtcLocalView.SurfaceView(),
          Align(
            alignment: Alignment.topLeft,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.of(_.remoteUid.map(
                  (e) => GestureDetector(
                    onTap: _.switchRenders,
                    child: Container(
                      width: 120,
                      height: 120,
                      child: RtcRemoteView.SurfaceView(
                        uid: e,
                        channelId: _.channelId,
                      ),
                    ),
                  ),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buildContainerDashBord(
      BuildContext context, HomeDashboardController _) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: new BoxDecoration(
          color: Color(0xffEDF1F4),
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
                    'All Appointment',
                    maxLines: 1,
                    style: TextStyle(
                        color: Color(0xff5FA4A4), fontWeight: FontWeight.w700),
                  ),
                ),
                Expanded(
                    child: Divider(
                  color: Color(0xff5FA4A4),
                )),
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Text('See all',
                      style: TextStyle(color: Color(0xff5FA4A4))),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              decoration: new BoxDecoration(
                  color: Colors.white, //new Color.fromRGBO(255, 0, 0, 0.0),
                  borderRadius: new BorderRadius.all(
                    Radius.circular(5),
                  )),
              // color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.73,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.all(12.0.sp),
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        //childAspectRatio: 3.w / 3.h,
                        crossAxisSpacing: 20.w,
                        mainAxisSpacing: 10.h),
                    itemCount: _.appoinmentlist.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return Padding(
                        padding: EdgeInsets.all(8.0.sp),
                        child: SingleChildScrollView(
                          child: Container(
                            decoration: BoxDecoration(
                                color: fLabelTextColor,
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(15.0.sp),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 15.h),
                                        child: Text(
                                          "Appointment ${index + 1}",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.inter(
                                              fontSize: 20.sp,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        ),
                                      ),
                                      // Image.asset("assets/video.png"),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 10.w, right: 10.w, top: 20.h),
                                  height: 60.h,
                                  decoration: BoxDecoration(
                                      color: fContainerColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                          height: 25.h,
                                          width: 25.w,
                                          child: Image.asset(
                                              "assets/datetime.png")),
                                      Text(
                                        "${_.appoinmentlist[index]['starttime']}",
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.inter(
                                            fontSize: 15.sp,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 10.w, right: 10.w, top: 30.h),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            _.isSelected = false;
                                            _.update();
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (context) => Help(),
                                            //   ),
                                            // );

                                            // showDialog(
                                            //     context: context,
                                            //     builder:
                                            //         (BuildContext context) {
                                            //       return AlertDialog(
                                            //           shape: RoundedRectangleBorder(
                                            //               borderRadius:
                                            //               BorderRadius.all(
                                            //                   Radius.circular(
                                            //                       20.0))),
                                            //           backgroundColor:
                                            //           Colors.white,
                                            //           content: Container(
                                            //             height: 300,
                                            //             width: 500,
                                            //             child: Column(
                                            //               mainAxisAlignment:
                                            //               MainAxisAlignment
                                            //                   .spaceAround,
                                            //               children: [
                                            //                 Row(
                                            //                   mainAxisAlignment:
                                            //                   MainAxisAlignment
                                            //                       .center,
                                            //                   children: [
                                            //                     Text(
                                            //                       'Countdown Started',
                                            //                       style: TextStyle(
                                            //                           color:
                                            //                           fButtonColor,
                                            //                           fontSize:
                                            //                           25,
                                            //                           fontWeight:
                                            //                           FontWeight
                                            //                               .bold),
                                            //                     ),
                                            //                   ],
                                            //                 ),
                                            //                 Row(
                                            //                   mainAxisAlignment:
                                            //                   MainAxisAlignment
                                            //                       .spaceAround,
                                            //                   children: [
                                            //                     Container(
                                            //                       height: 170.0,
                                            //                       width: 270,
                                            //                       // margin: EdgeInsets.only(top: 18, right: 14, left: 14),
                                            //                       decoration: BoxDecoration(
                                            //                           color:
                                            //                           fLabelTextColor,
                                            //                           borderRadius:
                                            //                           BorderRadius.circular(
                                            //                               15)),
                                            //                       child: Column(
                                            //                         children: [
                                            //                           Padding(
                                            //                             padding:
                                            //                             const EdgeInsets.all(15.0),
                                            //                             child:
                                            //                             Row(
                                            //                               mainAxisAlignment:
                                            //                               MainAxisAlignment.spaceBetween,
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
                                            //                             margin: EdgeInsets.only(
                                            //                                 left:
                                            //                                 10,
                                            //                                 right:
                                            //                                 10),
                                            //                             height:
                                            //                             60,
                                            //                             decoration: BoxDecoration(
                                            //                                 color:
                                            //                                 fContainerColor,
                                            //                                 borderRadius:
                                            //                                 BorderRadius.circular(10)),
                                            //                             child:
                                            //                             Padding(
                                            //                               padding:
                                            //                               const EdgeInsets.all(10.0),
                                            //                               child:
                                            //                               Row(
                                            //                                 mainAxisAlignment:
                                            //                                 MainAxisAlignment.spaceBetween,
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
                                            //                             padding: const EdgeInsets.only(
                                            //                                 left:
                                            //                                 10,
                                            //                                 right:
                                            //                                 10,
                                            //                                 top:
                                            //                                 10),
                                            //                             child:
                                            //                             Row(
                                            //                               mainAxisAlignment:
                                            //                               MainAxisAlignment.spaceBetween,
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
                                            //                             Icons
                                            //                                 .timer,
                                            //                             size:
                                            //                             60,
                                            //                             color: Colors
                                            //                                 .red),
                                            //                         TimerCountdown(
                                            //                           enableDescriptions:
                                            //                           false,
                                            //                           timeTextStyle: TextStyle(
                                            //                               fontSize:
                                            //                               35,
                                            //                               fontWeight:
                                            //                               FontWeight.w900),
                                            //                           colonsTextStyle: TextStyle(
                                            //                               fontWeight: FontWeight
                                            //                                   .bold,
                                            //                               fontSize:
                                            //                               15),
                                            //                           spacerWidth:
                                            //                           0,
                                            //                           format: CountDownTimerFormat
                                            //                               .hoursMinutesSeconds,
                                            //                           endTime:
                                            //                           DateTime.now()
                                            //                               .add(
                                            //                             Duration(
                                            //                               minutes:
                                            //                               27,
                                            //                               seconds:
                                            //                               34,
                                            //                             ),
                                            //                           ),
                                            //                           onEnd:
                                            //                               () {
                                            //                             print(
                                            //                                 "Timer finished");
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
                                          },
                                          child: Text(
                                            "Start",
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.inter(
                                                fontSize: 15.sp,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              fixedSize: Size(130.w, 30.h),
                                              primary: fButtonColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)))),
                                      ElevatedButton(
                                          onPressed: () {},
                                          child: Text(
                                            "Cancel",
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.inter(
                                                fontSize: 15.sp,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              fixedSize: Size(130.w, 30.h),
                                              primary: fButtonColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
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
            )
          ],
        ),
      ),
    );
  }
}

// class HomeDashboard extends StatefulWidget {
//   @override
//   State<HomeDashboard> createState() => _HomeDashboardState();
// }
//
// class _HomeDashboardState extends State<HomeDashboard>
//     with AutomaticKeepAliveClientMixin {
//   final bookedAppointment = Get.find<BookedAppointmentController>();
//   bool isSelected = true;
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: isSelected
//             ? buildContainerDashBord(context)
//             : buildContainerHelp(context));
//   }
//
//   Container buildContainerHelp(BuildContext context) {
//     return Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         decoration: new BoxDecoration(
//             color: Color(0xffE5E5E5), //new Color.fromRGBO(255, 0, 0, 0.0),
//             borderRadius: new BorderRadius.only(
//                 topLeft: Radius.circular(circular_radius_homeContainers),
//                 bottomLeft: Radius.circular(circular_radius_homeContainers))),
//         child: GetBuilder<HelpController>(
//           init: HelpController(),
//           builder: (_) {
//             return _.isLoading
//                 ? Center(
//                     child: CircularProgressIndicator(),
//                   )
//                 : Row(
//                     children: [
//                       Container(
//                         width: Get.width / 2.8,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Container(
//                               width: Get.width,
//                               child: TextField(
//                                 controller: _.controller,
//                                 decoration:
//                                     InputDecoration(hintText: 'Channel ID'),
//                                 onChanged: (text) {
//                                   _.channelId = text;
//                                 },
//                               ),
//                             ),
//                             SizedBox(
//                               height: 30.0,
//                             ),
//                             Container(
//                               width: Get.width,
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     flex: 1,
//                                     child: ElevatedButton(
//                                       onPressed: _.isJoined
//                                           ? _.leaveChannel
//                                           : _.joinChannel,
//                                       child: Text(
//                                           '${_.isJoined ? 'Leave' : 'Join'} channel'),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             renderVideo(_),
//                             SizedBox(
//                               height: 30.0,
//                             ),
//                             Align(
//                               alignment: Alignment.bottomRight,
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   ElevatedButton(
//                                     onPressed: _.switchCameras,
//                                     child: Text(
//                                         'Camera ${_.switchCamera ? 'front' : 'rear'}'),
//                                   ),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       Container(
//                         width: Get.width / 2.8,
//                         child: Column(
//                           children: [
//                             Expanded(
//                               child: messages(_),
//                             ),
//                             sendmessage(_),
//                           ],
//                         ),
//                       )
//                     ],
//                   );
//           },
//         ));
//   }
//
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
//
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
//
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
//                       width: 120,
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
//
//   Container buildContainerDashBord(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height,
//       width: MediaQuery.of(context).size.width,
//       decoration: new BoxDecoration(
//           color: Color(0xffEDF1F4),
//           borderRadius: new BorderRadius.only(
//               topLeft: Radius.circular(circular_radius_homeContainers),
//               bottomLeft: Radius.circular(circular_radius_homeContainers))),
//       child: Padding(
//         padding: EdgeInsets.all(35.0.sp),
//         child: Column(
//           children: [
//             Header(),
//             SizedBox(
//               height: 35.h,
//             ),
//             Row(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(right: 20.w),
//                   child: Text(
//                     'All Appointment',
//                     maxLines: 1,
//                     style: TextStyle(
//                         color: Color(0xff5FA4A4), fontWeight: FontWeight.w700),
//                   ),
//                 ),
//                 Expanded(
//                     child: Divider(
//                   color: Color(0xff5FA4A4),
//                 )),
//                 Padding(
//                   padding: EdgeInsets.only(left: 20.w),
//                   child: Text('See all',
//                       style: TextStyle(color: Color(0xff5FA4A4))),
//                 )
//               ],
//             ),
//             SizedBox(
//               height: 30,
//             ),
//             Container(
//               decoration: new BoxDecoration(
//                   color: Colors.white, //new Color.fromRGBO(255, 0, 0, 0.0),
//                   borderRadius: new BorderRadius.all(
//                     Radius.circular(5),
//                   )),
//               // color: Colors.white,
//               height: MediaQuery.of(context).size.height * 0.73,
//               width: MediaQuery.of(context).size.width,
//               child: Padding(
//                 padding: EdgeInsets.all(12.0.sp),
//                 child: Obx(() => GridView.builder(
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 4,
//                         //childAspectRatio: 3.w / 3.h,
//                         crossAxisSpacing: 20.w,
//                         mainAxisSpacing: 10.h),
//                     itemCount: bookedAppointment.myAppointments.length,
//                     itemBuilder: (BuildContext ctx, index) {
//                       BookedAppointmentModel data =
//                           bookedAppointment.myAppointments[index];
//                       return Padding(
//                         padding: EdgeInsets.all(8.0.sp),
//                         child: SingleChildScrollView(
//                           child: Container(
//                             //height: 100.0.h,
//                             // margin: EdgeInsets.only(top: 18, right: 14, left: 14),
//                             decoration: BoxDecoration(
//                                 color: fLabelTextColor,
//                                 borderRadius: BorderRadius.circular(15)),
//                             child: Column(
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsets.all(15.0.sp),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Padding(
//                                         padding: EdgeInsets.only(top: 15.h),
//                                         child: Text(
//                                           "Appointment ${index + 1}",
//                                           maxLines: 1,
//                                           overflow: TextOverflow.ellipsis,
//                                           style: GoogleFonts.inter(
//                                               fontSize: 20.sp,
//                                               fontStyle: FontStyle.normal,
//                                               fontWeight: FontWeight.w600,
//                                               color: Colors.white),
//                                         ),
//                                       ),
//                                       // Image.asset("assets/video.png"),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   margin: EdgeInsets.only(
//                                       left: 10.w, right: 10.w, top: 20.h),
//                                   height: 60.h,
//                                   decoration: BoxDecoration(
//                                       color: fContainerColor,
//                                       borderRadius: BorderRadius.circular(10)),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       Container(
//                                           height: 25.h,
//                                           width: 25.w,
//                                           child: Image.asset(
//                                               "assets/datetime.png")),
//                                       Text(
//                                         "Fri, May 23, 10:00 am - 11:00 am",
//                                         overflow: TextOverflow.ellipsis,
//                                         style: GoogleFonts.inter(
//                                             fontSize: 15.sp,
//                                             fontStyle: FontStyle.normal,
//                                             fontWeight: FontWeight.w500,
//                                             color: Colors.white),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.only(
//                                       left: 10.w, right: 10.w, top: 30.h),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       ElevatedButton(
//                                           onPressed: () {
//                                             setState(() {
//                                               isSelected = false;
//                                             });
//                                             // Navigator.push(
//                                             //   context,
//                                             //   MaterialPageRoute(
//                                             //     builder: (context) => Help(),
//                                             //   ),
//                                             // );
//
//                                             // showDialog(
//                                             //     context: context,
//                                             //     builder:
//                                             //         (BuildContext context) {
//                                             //       return AlertDialog(
//                                             //           shape: RoundedRectangleBorder(
//                                             //               borderRadius:
//                                             //               BorderRadius.all(
//                                             //                   Radius.circular(
//                                             //                       20.0))),
//                                             //           backgroundColor:
//                                             //           Colors.white,
//                                             //           content: Container(
//                                             //             height: 300,
//                                             //             width: 500,
//                                             //             child: Column(
//                                             //               mainAxisAlignment:
//                                             //               MainAxisAlignment
//                                             //                   .spaceAround,
//                                             //               children: [
//                                             //                 Row(
//                                             //                   mainAxisAlignment:
//                                             //                   MainAxisAlignment
//                                             //                       .center,
//                                             //                   children: [
//                                             //                     Text(
//                                             //                       'Countdown Started',
//                                             //                       style: TextStyle(
//                                             //                           color:
//                                             //                           fButtonColor,
//                                             //                           fontSize:
//                                             //                           25,
//                                             //                           fontWeight:
//                                             //                           FontWeight
//                                             //                               .bold),
//                                             //                     ),
//                                             //                   ],
//                                             //                 ),
//                                             //                 Row(
//                                             //                   mainAxisAlignment:
//                                             //                   MainAxisAlignment
//                                             //                       .spaceAround,
//                                             //                   children: [
//                                             //                     Container(
//                                             //                       height: 170.0,
//                                             //                       width: 270,
//                                             //                       // margin: EdgeInsets.only(top: 18, right: 14, left: 14),
//                                             //                       decoration: BoxDecoration(
//                                             //                           color:
//                                             //                           fLabelTextColor,
//                                             //                           borderRadius:
//                                             //                           BorderRadius.circular(
//                                             //                               15)),
//                                             //                       child: Column(
//                                             //                         children: [
//                                             //                           Padding(
//                                             //                             padding:
//                                             //                             const EdgeInsets.all(15.0),
//                                             //                             child:
//                                             //                             Row(
//                                             //                               mainAxisAlignment:
//                                             //                               MainAxisAlignment.spaceBetween,
//                                             //                               children: [
//                                             //                                 Text(
//                                             //                                   "Appointment $index",
//                                             //                                   style: GoogleFonts.inter(fontSize: 20, fontStyle: FontStyle.normal, fontWeight: FontWeight.w600, color: Colors.white),
//                                             //                                 ),
//                                             //                                 // Image.asset("assets/video.png"),
//                                             //                               ],
//                                             //                             ),
//                                             //                           ),
//                                             //                           Container(
//                                             //                             margin: EdgeInsets.only(
//                                             //                                 left:
//                                             //                                 10,
//                                             //                                 right:
//                                             //                                 10),
//                                             //                             height:
//                                             //                             60,
//                                             //                             decoration: BoxDecoration(
//                                             //                                 color:
//                                             //                                 fContainerColor,
//                                             //                                 borderRadius:
//                                             //                                 BorderRadius.circular(10)),
//                                             //                             child:
//                                             //                             Padding(
//                                             //                               padding:
//                                             //                               const EdgeInsets.all(10.0),
//                                             //                               child:
//                                             //                               Row(
//                                             //                                 mainAxisAlignment:
//                                             //                                 MainAxisAlignment.spaceBetween,
//                                             //                                 children: [
//                                             //                                   Image.asset("assets/datetime.png"),
//                                             //                                   Text(
//                                             //                                     "Fri, May 23, 10:00 am - 11:00 am",
//                                             //                                     style: GoogleFonts.inter(fontSize: 12, fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: Colors.white),
//                                             //                                   )
//                                             //                                 ],
//                                             //                               ),
//                                             //                             ),
//                                             //                           ),
//                                             //                           Padding(
//                                             //                             padding: const EdgeInsets.only(
//                                             //                                 left:
//                                             //                                 10,
//                                             //                                 right:
//                                             //                                 10,
//                                             //                                 top:
//                                             //                                 10),
//                                             //                             child:
//                                             //                             Row(
//                                             //                               mainAxisAlignment:
//                                             //                               MainAxisAlignment.spaceBetween,
//                                             //                               children: [
//                                             //                                 ElevatedButton(
//                                             //                                     onPressed: () {},
//                                             //                                     child: Text(
//                                             //                                       "Start Soon",
//                                             //                                       style: GoogleFonts.inter(fontSize: 15.sp, fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: Colors.white),
//                                             //                                     ),
//                                             //                                     style: ElevatedButton.styleFrom(fixedSize: Size(110, 30), primary: Colors.orangeAccent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
//                                             //                                 ElevatedButton(
//                                             //                                     onPressed: () {
//                                             //                                       Navigator.of(context).pop();
//                                             //                                     },
//                                             //                                     child: Text(
//                                             //                                       "Cancel",
//                                             //                                       style: GoogleFonts.inter(fontSize: 15.sp, fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: Colors.white),
//                                             //                                     ),
//                                             //                                     style: ElevatedButton.styleFrom(fixedSize: Size(110, 30), primary: fButtonColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
//                                             //                               ],
//                                             //                             ),
//                                             //                           )
//                                             //                         ],
//                                             //                       ),
//                                             //                     ),
//                                             //                     Column(
//                                             //                       children: [
//                                             //                         Icon(
//                                             //                             Icons
//                                             //                                 .timer,
//                                             //                             size:
//                                             //                             60,
//                                             //                             color: Colors
//                                             //                                 .red),
//                                             //                         TimerCountdown(
//                                             //                           enableDescriptions:
//                                             //                           false,
//                                             //                           timeTextStyle: TextStyle(
//                                             //                               fontSize:
//                                             //                               35,
//                                             //                               fontWeight:
//                                             //                               FontWeight.w900),
//                                             //                           colonsTextStyle: TextStyle(
//                                             //                               fontWeight: FontWeight
//                                             //                                   .bold,
//                                             //                               fontSize:
//                                             //                               15),
//                                             //                           spacerWidth:
//                                             //                           0,
//                                             //                           format: CountDownTimerFormat
//                                             //                               .hoursMinutesSeconds,
//                                             //                           endTime:
//                                             //                           DateTime.now()
//                                             //                               .add(
//                                             //                             Duration(
//                                             //                               minutes:
//                                             //                               27,
//                                             //                               seconds:
//                                             //                               34,
//                                             //                             ),
//                                             //                           ),
//                                             //                           onEnd:
//                                             //                               () {
//                                             //                             print(
//                                             //                                 "Timer finished");
//                                             //                           },
//                                             //                         ),
//                                             //                       ],
//                                             //                     )
//                                             //                   ],
//                                             //                 )
//                                             //               ],
//                                             //             ),
//                                             //             // decoration: BoxDecoration(
//                                             //             // image: DecorationImage(
//                                             //             // image: NetworkImage('https://media.istockphoto.com/photos/freedom-chains-that-transform-into-birds-charge-concept-picture-id1322104312?b=1&k=20&m=1322104312&s=170667a&w=0&h=VQyPkFkMKmo0e4ixjhiOLjiRs_ZiyKR_4SAsagQQdkk='),
//                                             //             // fit: BoxFit.cover))
//                                             //           ));
//                                             //     });
//                                           },
//                                           child: Text(
//                                             "Start",
//                                             overflow: TextOverflow.ellipsis,
//                                             style: GoogleFonts.inter(
//                                                 fontSize: 15.sp,
//                                                 fontStyle: FontStyle.normal,
//                                                 fontWeight: FontWeight.w500,
//                                                 color: Colors.white),
//                                           ),
//                                           style: ElevatedButton.styleFrom(
//                                               fixedSize: Size(130.w, 30.h),
//                                               primary: fButtonColor,
//                                               shape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           20)))),
//                                       ElevatedButton(
//                                           onPressed: () {},
//                                           child: Text(
//                                             "Cancel",
//                                             overflow: TextOverflow.ellipsis,
//                                             style: GoogleFonts.inter(
//                                                 fontSize: 15.sp,
//                                                 fontStyle: FontStyle.normal,
//                                                 fontWeight: FontWeight.w500,
//                                                 color: Colors.white),
//                                           ),
//                                           style: ElevatedButton.styleFrom(
//                                               fixedSize: Size(130.w, 30.h),
//                                               primary: fButtonColor,
//                                               shape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           20)))),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 30.h,
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     })),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   // TODO: implement wantKeepAlive
//   bool get wantKeepAlive => true;
// }
