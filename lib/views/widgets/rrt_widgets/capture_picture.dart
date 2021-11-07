import 'package:flutter/material.dart';
import 'package:rrt_client_web_app/constants/rrt_sizes.dart';
import 'package:rrt_client_web_app/views/widgets/rrt_widgets/header.dart';

class CapturePicture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: new BoxDecoration(
          color: Color(0xffE5E5E5), //new Color.fromRGBO(255, 0, 0, 0.0),
          borderRadius: new BorderRadius.only(
              topLeft: Radius.circular(circular_radius_homeContainers),
              bottomLeft: Radius.circular(circular_radius_homeContainers))),
      child: Column(
        children: [
          Header(),
          SizedBox(
            height: 35,
          ),
          Row(
            children: [
              Container(
                width: width * 0.45,
                height: height * 0.9,
                color: Colors.black,
              ),
              Container(
                width: width * 0.2,
                color: Colors.blue,
                height: height * 0.8,
              )
            ],
          ),
        ],
      ),
    ));
  }
}
