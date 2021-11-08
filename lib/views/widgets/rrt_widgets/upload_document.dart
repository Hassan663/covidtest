import 'dart:html';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:rrt_client_web_app/constants/rrt_sizes.dart';
import 'package:rrt_client_web_app/views/widgets/rrt_widgets/button.dart';
import 'package:open_file/open_file.dart';

class UploadDocument extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Color(0xffE5E5E5), //new Color.fromRGBO(255, 0, 0, 0.0),
          borderRadius: new BorderRadius.only(
              topLeft: Radius.circular(circular_radius_homeContainers),
              bottomLeft: Radius.circular(circular_radius_homeContainers))),
      child: Center(
        child: CircularButtons(
          backgroundColor: Colors.white,
          borderColor: const Color(0xfffc6359),
          text: "Upload Documents",
          height: 50,
          width: width * 0.15,
          onPressed: () async {
            final Document = await FilePicker.platform.pickFiles();
            if (Document == null) return;
            final file = Document.files.first;
            openFile(file);
          },
          textColor: Colors.black,
          textStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ));
  }

  void openFile(PlatformFile file) {
    OpenFile.open(file.path!);
  }
}
