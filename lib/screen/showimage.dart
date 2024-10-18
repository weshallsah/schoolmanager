import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:schoolmanager/controller/Leaving.controller.dart';
import 'package:schoolmanager/controller/progress.controller.dart';
import 'package:schoolmanager/screen/Leaveing.dart';

class Certificate extends StatelessWidget {
  ProgressController progressController;
  LeavingController leavingController;
  int type;
  Certificate(this.type, this.progressController, this.leavingController,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(
        () {
          return !leavingController.isloading.value &&
                  !progressController.isloading.value
              ? Container(
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.topCenter,
                  child: Container(
                    child: Image.file(
                      type == 0
                          ? progressController.progress
                          : leavingController.Lc,
                      // height: 800,
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
