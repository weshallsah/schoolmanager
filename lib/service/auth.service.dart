import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:get/get.dart';
import 'package:schoolmanager/models/user.models.dart';
import 'package:schoolmanager/screen/auth.dart';

class AuthService {
  static Future<bool> islogin() async {
    return await APICacheManager().isAPICacheKeyExist("Login");
  }

  static Future<void> deleteuser() async {
    await APICacheManager().deleteCache("Login");
    Get.offAll(() => Authscreen());
  }

  static getuser() async {
    final user = await APICacheManager().getCacheData("Login");
    if (user.key.isNotEmpty) {
      final cachedata = await APICacheManager().getCacheData("Login");
      return UserModel.fromJson(jsonDecode(cachedata.syncData), false);
    }
  }

  static Future setlogin(UserModel userModel) async {
    print("usermodel := ${userModel.toJson()}");
    APICacheDBModel cacheDBModel = APICacheDBModel(
      key: "Login",
      syncData: jsonEncode(
        userModel,
      ),
    );
    await APICacheManager().addCacheData(cacheDBModel);
  }
}

class AttendanceService {
  static Future<bool> istaken(final date) async {
    return await APICacheManager().isAPICacheKeyExist("attendance := ${date}");
  }

  static Future setlogin(final date) async {
    APICacheDBModel cacheDBModel = APICacheDBModel(
      key: "attendance := ${date}",
      syncData: jsonEncode(
        true,
      ),
    );
    await APICacheManager().addCacheData(cacheDBModel);
  }
}
