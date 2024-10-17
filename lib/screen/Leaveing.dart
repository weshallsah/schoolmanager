import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:schoolmanager/controller/Leaving.controller.dart';
import 'package:schoolmanager/screen/auth.dart';

class LeaveingCertificate extends StatelessWidget {
  LeaveingCertificate({super.key});
  LeavingController leavingController = Get.put(LeavingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manager"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Text(
              "Leaving Certificates",
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 25.w,
                ),
                child: ListView.builder(
                  itemCount: leavingController.fieldnames.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 5.h,
                      ),
                      child: inputBox(leavingController.fieldnames[index],
                          TextEditingController(), false),
                    );
                  },
                ),
              ),
            ),
            InkWell(
              child: Container(
                height: 56.h,
                width: 200.w,
                margin: EdgeInsets.symmetric(
                  vertical: 10.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  border: Border.all(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 1.w),
                  borderRadius: BorderRadius.circular(9.r),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Generate Leave",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
