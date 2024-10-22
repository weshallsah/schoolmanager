import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:schoolmanager/controller/home.controller.dart';
import 'package:schoolmanager/controller/manage.controller.dart';

class Manage extends StatelessWidget {
  Manage({super.key});
  ManageController manageController = Get.put(ManageController());
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text("Manage"),
      ),
      body: Container(
        height: double.infinity,
        child: Obx(
          () => ListView.builder(
            itemCount: manageController.list.length,
            itemBuilder: (context, index) {
              manageController.selecteditem
                  .add("STD ${manageController.list[index]['standard']}");
              print(manageController.list[index]['standard']);
              return Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 10.h,
                ),
                width: double.infinity,
                // color: Colors.amber,
                child: Column(
                  children: [
                    Row(
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
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              onPressed: () {
                                manageController.fire(_globalKey, index);
                              },
                              icon: Icon(
                                size: 30.r,
                                Icons.delete_forever,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 60.h,
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(
                        horizontal: 25.w,
                      ),
                      // color: Colors.amber,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "select ",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Obx(() {
                            return Container(
                              alignment: Alignment.center,
                              child: DropdownButton(
                                value: manageController.selecteditem[index],
                                items: manageController.items.map(
                                  (element) {
                                    return DropdownMenuItem(
                                      child: Text(
                                        element,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      value: element,
                                    );
                                  },
                                ).toList(),
                                onChanged: (it) {
                                  manageController.selecteditem[index] =
                                      it.toString();
                                },
                              ),
                            );
                          }),
                          InkWell(
                            onTap: () {
                              manageController.standard(_globalKey, index);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 5.h,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                border: Border.all(),
                              ),
                              child: Text(
                                "Update",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
