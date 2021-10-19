import 'package:flutter/material.dart';
import 'package:rrt_client_web_app/rrt_widgets/rrt_sizes.dart';

class CapturePicture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: new BoxDecoration(
              color: Color(0xffE5E5E5), //new Color.fromRGBO(255, 0, 0, 0.0),
              borderRadius: new BorderRadius.only(
                  topLeft:  Radius.circular(circular_radius_homeContainers),
                  bottomLeft: Radius.circular(circular_radius_homeContainers))
          ),
          child: Center(child: Text('Capture a Picture'),),
        )
    );
  }
}
