import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:schoolmanager/controller/Bonafide.controller.dart';
import 'package:schoolmanager/screen/auth.dart';

class Bonafide extends StatelessWidget {
  Bonafide({super.key});
  BonafideController bonafideController = Get.put(BonafideController());
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text("Manager"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            inputBox("Enroll", bonafideController.enroll, false),
            SizedBox(
              height: 20.h,
            ),
            Obx(
              () => InkWell(
                onTap: () {
                  bonafideController.generate(_globalKey);
                },
                child: Container(
                  height: 56.h,
                  width: 200.w,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    border: Border.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 1.w),
                    borderRadius: BorderRadius.circular(9.r),
                  ),
                  alignment: Alignment.center,
                  child: bonafideController.isloading.value
                      ? CircularProgressIndicator()
                      : Text(
                          "Generate bonafide",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            GetBuilder<BonafideController>(builder: (controller) {
              return Expanded(
                child: Obx(() => bonafideController.isloaded.value
                    ? Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(),
                          ),
                        ),
                        alignment: Alignment.topCenter,
                        child: Container(
                          child: Image.file(bonafideController.bonafide
                              // height: 800,
                              ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Bonafide is not generated yet",
                          ),
                        ),
                      )),
              );
            }),
          ],
        ),
      ),
    );
  }
}
