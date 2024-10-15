import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:schoolmanager/controller/home.controller.dart';
import 'package:schoolmanager/controller/manage.controller.dart';

class Manage extends StatelessWidget {
  Manage({super.key});
  ManageController manageController = Get.put(ManageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage"),
      ),
      body: Container(
        height: double.infinity,
        child: Obx(
          () => ListView.builder(
            itemCount: manageController.list.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 10.h,
                ),
                width: double.infinity,
                // color: Colors.amber,
                child: Row(
                  children: [
                    Container(
                      height: 60.w,
                      width: 60.w,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(60.r),
                        image: DecorationImage(
                          image: NetworkImage(
                              "http://10.0.2.2:9000/api/v1/teacher/viewphoto/${manageController.list[index]['photo']}"),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          manageController.list[index]['name'],
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          manageController.list[index]['email'],
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "STD",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Container(
                          width: 40.w,
                          child: TextField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            size: 30.r,
                            Icons.delete_forever,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
// I/flutter ( 6668): {status: 200, payload: [{_id: 670cc33b5bdac530295bc0c3, name: Vishal sah, enroll: 0208cs211200, photo: 670cc33b5bdac530295bc0c2, fathername: shambhoo sah, mothername: pramila, phone: 9511286245, gender: false, dob: 2000-01-23, email: vishalk74064@gmail.com, isadmin: true, address: meena colony, school: New english high school, status: true, __v: 0}], message: teacher fetch sucessfully, issuccess: true}
