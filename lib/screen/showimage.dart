import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:schoolmanager/controller/progress.controller.dart';

class Certificate extends StatelessWidget {
  ProgressController progressController;
  Certificate(this.progressController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => progressController.isloaded.value
            ? Container(
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.topCenter,
                child: Container(
                  child: Image.file(
                    progressController.progress,
                    height: 600,
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
