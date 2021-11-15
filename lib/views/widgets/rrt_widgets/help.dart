import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rrt_client_web_app/constants/rrt_colors.dart';
import 'package:rrt_client_web_app/constants/rrt_sizes.dart';
import 'package:rrt_client_web_app/constants/rtt_textstyle.dart';
import 'package:rrt_client_web_app/controllers/help/help_controller.dart';
import 'package:rrt_client_web_app/views/widgets/rrt_widgets/button.dart';
import 'package:rrt_client_web_app/views/widgets/rrt_widgets/header.dart';
import 'package:rrt_client_web_app/widget/commontextfield.dart';

import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: buildContainerHelp(context));
  }

  Widget buildContainerHelp(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Header(),
          ),
          buildVideoCall(context),
        ],
      ),
    );
  }

  Container buildVideoCall(BuildContext context) {
    return Container(
            height: MediaQuery.of(context).size.height * 0.85,
            width: MediaQuery.of(context).size.width,
            decoration: new BoxDecoration(
                color:
                    Color(0xffE5E5E5), //new Color.fromRGBO(255, 0, 0, 0.0),
                borderRadius: new BorderRadius.only(
                    topLeft: Radius.circular(circular_radius_homeContainers),
                    bottomLeft:
                        Radius.circular(circular_radius_homeContainers))),
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
                              crossAxisAlignment:
                                  CrossAxisAlignment.center,
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
                                              MainAxisAlignment
                                                  .spaceBetween,
                                          children: [
                                            Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10))),
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
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10))),
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
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10))),
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
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10))),
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
                                            borderColor:
                                                const Color(0xfffc6359),
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
                                                fontWeight:
                                                    FontWeight.w600),
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
                            decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),),
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




}
